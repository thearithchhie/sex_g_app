import 'package:args/command_runner.dart';
import 'package:ff/helpers.dart';

class SignApkCommand extends Command {
  @override
  String get description => 'Sign APK file with version 2, 3, 4';

  @override
  String get name => 'sign-apk';

  SignApkCommand() {
    argParser.addOption('input',
        mandatory: true, abbr: 'i', help: 'Input apk file name of unsigned APK inside directory build/app/outputs/flutter-apk/');
    argParser.addOption('output',
        mandatory: true, abbr: 'o', help: 'Output apk file name of unsigned APK inside directory build/app/outputs/flutter-apk/');
    argParser.addOption(
      'build-tool-version',
      help: 'Android build tool version',
      defaultsTo: 'ff.yaml config or 33.0.2',
    );
  }

  @override
  void run() async {
    final String input = argResults?['input'];
    final String output = argResults?['output'];
    final buildToolVersion = argResults?['build-tool-version'];

    await signApk(
      input,
      output,
      buildToolVersion: buildToolVersion,
    );
  }

  static Future signApk(
    String input,
    String output, {
    String buildToolVersion = '33.0.2',
  }) async {
    await runScript('''
input="$input"
output="$output"
  
source ./android/key.properties

rm -f build/app/outputs/flutter-apk/aligned-unsigned-release.apk &&
rm -f build/app/outputs/flutter-apk/"\$output" &&
~/Library/Android/sdk/build-tools/$buildToolVersion/zipalign -v -p 4 build/app/outputs/flutter-apk/"\$input" build/app/outputs/flutter-apk/aligned-unsigned-release.apk &&
~/Library/Android/sdk/build-tools/$buildToolVersion/apksigner sign --ks \$storeFile --ks-key-alias \$keyAlias --ks-pass pass:\$keyPassword --out build/app/outputs/flutter-apk/"\$output" build/app/outputs/flutter-apk/aligned-unsigned-release.apk
    ''', 'Sign apk');
  }
}
