import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:ff/commands/set_app_id.dart';
import 'package:ff/commands/set_app_name.dart';
import 'package:ff/commands/set_deeplink_scheme.dart';
import 'package:ff/helpers.dart';

import 'set_app_version.dart';

class SetEnvironmentCommand extends Command {
  @override
  String get description => 'Change environment to test or production.';

  @override
  String get name => 'set-env';

  SetEnvironmentCommand() {
    argParser.addOption(
      'env',
      abbr: 'e',
      mandatory: true,
      allowed: ['dev', 'test', 'prod'],
      help:
          '[dev] refer to developer version. \n[test] for build buy point to testing server. \n[prod] for release',
    );
  }

  @override
  void run() async {
    var env = argResults?['env'];

    await setEnv(env);
  }

  static Future setEnv(String env) async {
    final config = await getConfig();
    var devMode = false;

    switch (env) {
      case 'dev':
        devMode = true;
        break;
      case 'test':
        devMode = true;
        break;
      case 'prod':
        devMode = false;
        break;
      default:
    }

    final version = config['build_settings']['version']['name'];
    final buildNumber = config['build_settings']['version']['number'];
    final patchVersion = config['build_settings']['version']['patch'];

    SetAppVersionCommand.setVersion(
      '$version',
      '$buildNumber',
      patchVersion: '$patchVersion',
    );

    if (devMode) {
      await replaceFile(
        RegExp(r'.*isTestEnvironment[^;]*;'),
        (match) {
          return "const isTestEnvironment = true;";
        },
        'lib/utils/core/config.gen.dart',
      );

      showTextInFile(
        RegExp(
          r'.*isTestEnvironment[^;]*;',
          multiLine: true,
          dotAll: false,
        ),
        File('lib/utils/core/config.gen.dart'),
      );

      await replaceFile(
          RegExp(
              r'(const|final|bool) +showFloatingDebugTool *=[ \n\t]*[A-Za-z]+ *;'),
          (match) {
        return "const showFloatingDebugTool = kDebugMode;";
      }, 'lib/utils/core/config.gen.dart');

      showTextInFile(
        RegExp(
            r'(const|final|String) +showFloatingDebugTool *=[ \n\t]*[A-Za-z]+ *;'),
        File('lib/utils/core/config.gen.dart'),
      );

      printSuccess('Updated config.dart useDefaultTestingLine variable! ✔');

      await SetDeeplinkSchemeCommand.setScheme(
          config['uni_link_scheme']['test']);
      await SetAppNameCommand.setAppName(config['display_app_name']['test']);
      await SetAppIdCommand.setAppId(
          config['app_id']['android']['test'], config['app_id']['ios']['test']);
    } else {
      await replaceFile(
        RegExp(r'.*isTestEnvironment[^;]*;'),
        (match) {
          return "const isTestEnvironment = false;";
        },
        'lib/utils/core/config.gen.dart',
      );

      showTextInFile(
        RegExp(
          r'.*isTestEnvironment[^;]*;',
          multiLine: true,
          dotAll: false,
        ),
        File('lib/utils/core/config.gen.dart'),
      );

      await replaceFile(
          RegExp(
              r'(const|final|String) +showFloatingDebugTool *=[ \n\t]*[A-Za-z]+ *;'),
          (match) {
        return "const showFloatingDebugTool = kDebugMode;";
      }, 'lib/utils/core/config.gen.dart');

      showTextInFile(
        RegExp(
            r'(const|final|String) +showFloatingDebugTool *=[ \n\t]*[A-Za-z]+ *;'),
        File('lib/utils/core/config.gen.dart'),
      );

      printSuccess('Updated config.dart useDefaultTestingLine variable! ✔');

      await SetDeeplinkSchemeCommand.setScheme(
          config['uni_link_scheme']['prod']);
      await SetAppNameCommand.setAppName(config['display_app_name']['prod']);
      await SetAppIdCommand.setAppId(
          config['app_id']['android']['prod'], config['app_id']['ios']['prod']);
    }
  }
}
