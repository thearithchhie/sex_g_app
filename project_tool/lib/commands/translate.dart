import 'dart:io';
import 'dart:math';

import 'package:args/command_runner.dart';
import 'package:chalk/chalk.dart';
import 'package:translator/translator.dart';

class TranslateCommand extends Command {
  @override
  String get description => 'For working on translation';

  @override
  String get name => 'translate';

  TranslateCommand() {
    argParser.addOption(
      'english',
      mandatory: true,
      abbr: 'e',
      help: 'English word',
    );
    argParser.addOption(
      'key',
      abbr: 'k',
      help: 'Translation key (default to English word)',
    );
  }

  @override
  void run() async {
    final String english = argResults?['english'];
    final String key = argResults?['key'] ?? english;

    final translator = GoogleTranslator();
    final result = await translator.translate(english, from: 'en', to: 'zh-cn');

    final chinese = result.text;

    var englishLine = '';
    var chineseLine = '';

    final englishPath = 'lib/data/locales/en_US.dart';
    final chinesePath = 'lib/data/locales/zh_CN.dart';

    try {
      final enContent = File(englishPath).readAsStringSync().split('\n');
      final zhContent = File(chinesePath).readAsStringSync().split('\n');
      final atLineEnglish = max(enContent.length - 2, 0);
      final atLineChinese = max(zhContent.length - 2, 0);
      englishLine = ':$atLineEnglish:${enContent[atLineEnglish - 1].length + 1}';
      chineseLine = ':$atLineChinese:${zhContent[atLineChinese - 1].length + 1}';
    } catch (_) {}

    print('''
➜ Copy English to file://${Directory.current.path}/$englishPath$englishLine
${key == english ? chalk.yellow('\n(Optional)'): ''}
"${chalk.cyan(key.replaceAll('"', '\\"').replaceAll('\n', '\\n'))}": "${chalk.green(english.replaceAll('"', '\\"').replaceAll('\n', '\\n'))}",
    
➜ Copy Chinese to file://${Directory.current.path}/$chinesePath$chineseLine

"${chalk.cyan(key.replaceAll('"', '\\"').replaceAll('\n', '\\n'))}": "${chalk.green(chinese.replaceAll('"', '\\"').replaceAll('\n', '\\n'))}",  // Google Translate
    ''');
  }
}
