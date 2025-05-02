import 'package:easy_localization/easy_localization.dart';

extension StringTranslateExtension on String {
  String localize() => this.tr();
}
