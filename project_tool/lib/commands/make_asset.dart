import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:ff/helpers.dart';


class MakeAssetCommand extends Command {
  @override
  String get description => 'Generate asset zip.';

  @override
  String get name => 'release-asset';

  MakeAssetCommand() {
    argParser.addFlag('manual',
        abbr: 'm',
        defaultsTo: false,
        help:
            'Do not check diff from git. Use list in asset_list.txt directly');
  }

  @override
  void run() async {
    final bool manual = argResults?['manual'];
    await makeAsset(manual);
  }

  static Future makeAsset(bool manual) async {
    final config = await getConfig();

    final version = config['build_settings']['version']['name'];
    final testVersionName = 'test/$version';

    await runScript('''
${manual ? '' : "git diff tags/$testVersionName..HEAD --name-only --stat -- assets > push_assets/asset_list.txt &&"}

if [ ! -s "push_assets/asset_list.txt" ]; then
echo "assets/images/app_logo.png" > push_assets/asset_list.txt
fi

cd push_assets

rm -rf all
mkdir -p all
cd all

while read asset; do
  echo "Copying \$asset"
  cp ../../"\$asset" .
  find * | zip ../"$version".zip -@
done < ../asset_list.txt

cd ..
rm -rf all
cd ..
    ''', 'Get changed asset and zip it to push_assets/$version.zip');

    final pushAssetFolder = Directory('push_assets');

    printInfo("📁 Please check file://${pushAssetFolder.absolute.path}");
    printInfo("📦 Upload to https://site.wrs.wns8.io");
  }
}
