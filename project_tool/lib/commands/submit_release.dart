import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:chalk/chalk.dart';
import 'package:ff/commands/set_app_version.dart';
import 'package:ff/commands/set_env.dart';
import 'package:ff/helpers.dart';
import 'package:interact/interact.dart';

class SubmitReleaseCommand extends Command {
  @override
  String get description =>
      'Submit new release to release manager. If you did not specify any flag, it will use setting from ff.yaml.';

  @override
  String get name => 'release-submit';

  SubmitReleaseCommand() {
    argParser.addFlag(
      'test',
      abbr: 't',
      defaultsTo: null,
      help: 'Submit for test environment',
    );
    argParser.addFlag(
      'prod',
      abbr: 'p',
      defaultsTo: null,
      help: 'Submit for production environment',
    );
    argParser.addFlag(
      'yes-all',
      abbr: 'y',
      defaultsTo: false,
      help: 'Yes for all questions',
    );
  }

  @override
  void run() async {
    final config = await getConfig();
    final allYes = argResults?['yes-all'] ?? false;

    await checkAssetNotYetUpload(config);

    bool test =
        config['build_settings']['environments']?.contains('test') ?? false;
    bool production =
        config['build_settings']['environments']?.contains('production') ??
            false;

    // Any test or prod flag is specified, default is false
    if (argResults?['test'] != null || argResults?['prod'] != null) {
      test = argResults?['test'] ?? false;
      production = argResults?['prod'] ?? false;
    }

    final testPrefix = 'test/';
    final productionPrefix = 'production/';

    final version = config['build_settings']['version']['name'];
    final buildNumber = config['build_settings']['version']['number'];
    final patchNumber = config['build_settings']['version']['patch'];
    final numericVersion =
        '$patchNumber' == '0' ? '$version' : '$version.$patchNumber';

    final testVersionName = testPrefix + numericVersion;
    final productionVersionName = productionPrefix + numericVersion;

    final confirmVersion = allYes ||
        Confirm(
          prompt:
              'Version will be set to $version+$buildNumber with patch #$patchNumber',
          defaultValue: false,
          waitForNewLine: true,
        ).interact();

    if (!confirmVersion) {
      printWarning('💡💡💡 Please update version info in ff.yaml');
      exit(1);
    }

    SetAppVersionCommand.setVersion('$version', '$buildNumber',
        patchVersion: '$patchNumber');

    // Validate empty option
    if (!test && !production) {
      print('Please specify an environment');
      return;
    }

    final confirmEnvironment = allYes ||
        Confirm(
          prompt: [
            if (test)
              '${chalk.white('I will push test as')} ${chalk.bold(testVersionName)}',
            if (production)
              '${chalk.white('I will push production as')} ${chalk.bold(productionVersionName)}',
          ].join(chalk.white(' and ')),
          defaultValue: false,
          waitForNewLine: true,
        ).interact();

    if (!confirmEnvironment) {
      printWarning('💡💡💡 Please specify environment info in ff.yaml');
      exit(1);
    }

    String getChangeLog() {
      final changeLog = config['change_logs'];
      if (changeLog != null) {
        if (changeLog.containsKey(numericVersion)) {
          final lines = changeLog[numericVersion].map((e) => '- $e');
          printInfo("Changelog : \n${lines.map((e) => '  $e').join('\n')}");
          return lines.join('\n');
        }
      }
      return 'Release v$numericVersion';
    }

    Future<bool> tagExists(versionName) async {
      final exitCode = await runScript(
        '''
        git ls-remote --tags origin | grep -q "refs/tags/$versionName^{}"
        exit \$?;
      ''',
        'Check if tag exist',
        printExitCode: false,
      );
      var tagExistOnRemote = exitCode == 0;

      if (tagExistOnRemote) {
        return true;
      }

      // Check tag on local
      var existTag = (await runScript(
            '''
if [ \$(git tag -l "$versionName") ]; then
  exit 1;
else
  exit 0;
fi
      ''',
            description,
            printExitCode: false,
          )) ==
          1;

      if (existTag) {
        final confirmDeleteLocalTag = allYes ||
            Confirm(
              prompt:
                  "Tag $versionName already exists. Are you sure to delete tag $versionName on your machine?",
              defaultValue: false,
              waitForNewLine: true,
            ).interact();

        if (confirmDeleteLocalTag) {
          runScript('''
git tag -d $versionName
      ''', "Remove local tag to create a new one");
        }
      }

      return tagExistOnRemote;
    }

    Future submitAs(String versionName) async {
      // Get message from change log
      final changeLog = getChangeLog();

      // Commit
      await runScript('''
      git add . &&
      git commit -m "Commit tag $versionName with changelog
$changeLog"
      ''', 'Commit the env');

      // Create tag
      await runScript('''
        git tag -a $versionName -m "$changeLog"
      ''', 'Create a new tag.');

      final confirmPushToTag = allYes ||
          Confirm(
            prompt:
                "Are you sure everything is correct before pushing $versionName to origin?",
            defaultValue: false,
            waitForNewLine: true,
          ).interact();

      if (!confirmPushToTag) {
        printError('How come you not sure 😏');
        exit(1);
      }

      // Push to tag
      await runScript(
          'git push origin $versionName', "Push tag $versionName to origin");
    }

    if (test) {
      if (await tagExists(testVersionName)) {
        printError('Tag $testVersionName already exists on origin ✘');
        exit(1);
      }

      await SetEnvironmentCommand.setEnv('test');

      await submitAs(testVersionName);

      printSuccess("Pushed tag $testVersionName to test successfully 🎉");
    }

    if (production) {
      if (await tagExists(productionVersionName)) {
        printError('Tag $productionVersionName already exists on origin ✘');
        exit(1);
      }

      await SetEnvironmentCommand.setEnv('prod');

      await submitAs(productionVersionName);

      printSuccess(
          "Pushed tag $productionVersionName to production successfully 🎉");

      final confirmSwitchBackToText = allYes ||
          Confirm(
            prompt: "Do you need to switch environment back to test?",
            defaultValue: true,
            waitForNewLine: true,
          ).interact();

      if (confirmSwitchBackToText) {
        printInfo("Change environment back to ");
        await SetEnvironmentCommand.setEnv('test');
        await runScript('''
      git add . &&
      git commit -m "Switch to test env"
      ''', 'Commit the switch test env');
      }
    }
  }

  checkAssetNotYetUpload(config) async {
    final version = config['build_settings']['version']['name'];
    final patchNumber = config['build_settings']['version']['patch'];
    final testVersionName = 'test/$version';

    if ('$patchNumber' == '0') {
      return;
    }

    await runScript('''
git diff tags/$testVersionName..HEAD --name-only --stat -- assets > push_assets/asset_list.tmp &&
if [ ! -s "push_assets/asset_list.tmp" ]; then
  echo "assets/images/app_logo.png" > push_assets/asset_list.tmp
fi
    ''', '');

    var tmp = File(testablePath('push_assets/asset_list.tmp'));
    var txt = File(testablePath('push_assets/asset_list.txt'));

    if (tmp.readAsStringSync() != txt.readAsStringSync()) {
      printError('❌ Asset is changed but not yet uploaded');
      printInfo('💡 Run: ./ff release-asset');
      exit(1);
    }
  }
}
