import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:ff/commands/set_app_version.dart';
import 'package:ff/commands/set_env.dart';
import 'package:ff/commands/sign_apk.dart';
import 'package:ff/helpers.dart';

class BuildProjectCommand extends Command {
  @override
  String get description => 'Using for building apk and ipa files.';

  @override
  String get name => 'build';

  BuildProjectCommand();

  @override
  void run() async {
    final flutter = await getFlutterRunnable();
    final config = await getConfig();

    final bool test =
        config['build_settings']['environments']?.contains('test') ?? false;
    final bool production =
        config['build_settings']['environments']?.contains('production') ??
            false;
    final bool android =
        config['build_settings']['platforms']?.contains('android') ?? false;
    final bool ios =
        config['build_settings']['platforms']?.contains('ios') ?? false;
    final version = config['build_settings']['version']['name'];
    final buildNumber = config['build_settings']['version']['number'];
    final patchVersion = config['build_settings']['version']['patch'];
    final buildDirectoryPath = config['build_settings']['output_path'];

    SetAppVersionCommand.setVersion('$version', '$buildNumber', patchVersion: '$patchVersion');

    // Validate empty option
    if (!test && !production) {
      print('Please specify an environment');
      return;
    }

    if (!ios && !android) {
      print('Please specify a platform');
      return;
    }

    final buildDirectory = Directory(buildDirectoryPath);

    // Clean output folder
    if (buildDirectory.existsSync()) {
      await buildDirectory.delete(
        recursive: true,
      );
    }
    await buildDirectory.create(recursive: true);

    Future build(String outputPrefix) async {
      if (ios) {
        printSuccess("Building ipa and copy to output folder...");
        await runScript('''
rm -f build/ios/ipa/*.ipa &&
"$flutter" build ipa &&

cp build/ios/ipa/*.ipa "${buildDirectory.path}"/${outputPrefix}_"$version+$buildNumber".ipa
        ''', "Build ipa file");
      }
      if (android) {
        printInfo("Building APK file...");
        await runScript('''
"$flutter" build apk
        ''', "Build apk file");

        printInfo("Signing APK...");
        await SignApkCommand.signApk(
          'app-release.apk',
          'final-signed.apk',
          buildToolVersion: config['build_settings']
              ['android_build_tool_version'],
        );

        printInfo("Copy APKs to output folder...");
        await runScript('''
cp build/app/outputs/flutter-apk/final-signed.apk "${buildDirectory.path}"/${outputPrefix}_"$version+$buildNumber".apk &&
cp build/app/outputs/flutter-apk/final-signed.apk.idsig "${buildDirectory.path}"/_${outputPrefix}_"$version+$buildNumber".apk.idsig
        ''', 'Copy apk and signature to output folder');
      }
    }

    if (test) {
      await SetEnvironmentCommand.setEnv('test');

      await build('test_ea');
    }

    if (production) {
      await SetEnvironmentCommand.setEnv('prod');

      await build('ea');
    }
  }
}
