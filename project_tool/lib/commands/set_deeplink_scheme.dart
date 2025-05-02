import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:ff/helpers.dart';

class SetDeeplinkSchemeCommand extends Command {
  @override
  String get description => 'Set deeplink scheme.';

  @override
  String get name => 'set-scheme';

  SetDeeplinkSchemeCommand() {
    argParser.addOption(
      'scheme',
      abbr: 's',
      mandatory: true,
      help: 'Scheme for deeplink eg ea:// test_ea://',
    );
  }

  @override
  void run() async {
    final String scheme = argResults?['scheme'];

    await setScheme(scheme);
  }

  static Future setScheme(String scheme) async {
    // Info.plist
    await replaceFile(
      RegExp(
        r'([\n\s]*)<key>CFBundleURLSchemes</key>[\n\s]*<array>[\n\s]*<string>([^<]+)</string>[\n\s]*</array>',
        multiLine: true,
        dotAll: true,
      ),
      (match) {
        return '''${match.group(1)}<key>CFBundleURLSchemes</key>${match.group(1)}<array>${match.group(1)}\t<string>$scheme</string>${match.group(1)}</array>''';
      },
      'ios/Runner/Info.plist',
    );

    showTextInFile(
      RegExp(
        r'([\n\s]*)<key>CFBundleURLSchemes</key>[\n\s]*<array>[\n\s]*<string>([^<]+)</string>[\n\s]*</array>',
        multiLine: true,
        dotAll: true,
      ),
      File('ios/Runner/Info.plist'),
    );

    // AndroidManifest.xml
    await replaceFile(
      RegExp(
        r'(<data[\n\s]+android:scheme=")[^"]+("[\n\s]+android:host=)',
        multiLine: true,
        dotAll: true,
      ),
      (match) {
        return '${match.group(1)}$scheme${match.group(2)}';
      },
      'android/app/src/main/AndroidManifest.xml',
    );

    showTextInFile(
      RegExp(
        r'(<data[\n\s]+android:scheme=")[^"]+("[\n\s]+android:host=)',
        multiLine: true,
        dotAll: true,
      ),
      File('android/app/src/main/AndroidManifest.xml'),
    );

    // Runner.entitlements
    await replaceFile(
      RegExp(
        r'(<key>com.apple.developer.associated-domains</key>[\n\s]*<array>[\n\s]*)((<string>[^:]+.+[\n\s]+)+)',
        multiLine: true,
        dotAll: false,
      ),
      (match) {
        return '${match.group(1)}${match.group(2)!.replaceAll(RegExp(r'<string>[^:]+'), '<string>$scheme')}';
      },
      'ios/Runner/Runner.entitlements',
    );

    showTextInFile(
      RegExp(
        r'(<key>com.apple.developer.associated-domains</key>[\n\s]*<array>[\n\s]*)((<string>[^:]+.+[\n\s]+)+)',
        multiLine: true,
        dotAll: false,
      ),
      File('ios/Runner/Runner.entitlements'),
    );
  }
}
