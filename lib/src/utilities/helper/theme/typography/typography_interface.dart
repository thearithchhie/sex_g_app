import 'package:sex_g_app/export.dart';

abstract class TypographyInterface {
  final String fontFamily = "SFPro";
  final double fontHeight = 1.35;

  Color get fontColor;

  /// headline :::::::::::::::::::::::::::::::::::::
  TextStyle get headline24R => TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      fontFamily: fontFamily,
      height: fontHeight,
      color: fontColor);

  TextStyle get headline24M =>
      headline24R.copyWith(fontSize: 24, fontWeight: FontWeight.w500);

  TextStyle get headline24Sb =>
      headline24R.copyWith(fontSize: 24, fontWeight: FontWeight.w600);

  TextStyle get headline24B =>
      headline24R.copyWith(fontSize: 24, fontWeight: FontWeight.w700);

  /// subtitle :::::::::::::::::::::::::::::::::::::
  TextStyle get subtitle18R =>
      headline24R.copyWith(fontSize: 18, fontWeight: FontWeight.w400);

  TextStyle get subtitle18M =>
      headline24R.copyWith(fontSize: 18, fontWeight: FontWeight.w500);

  TextStyle get subtitle18Sb =>
      headline24R.copyWith(fontSize: 18, fontWeight: FontWeight.w600);

  TextStyle get subtitle18B =>
      headline24R.copyWith(fontSize: 18, fontWeight: FontWeight.w700);

  /// body :::::::::::::::::::::::::::::::::::::

  TextStyle get body16R =>
      headline24R.copyWith(fontSize: 16, fontWeight: FontWeight.w400);

  TextStyle get body16M =>
      headline24R.copyWith(fontSize: 16, fontWeight: FontWeight.w500);

  TextStyle get body16Sb =>
      headline24R.copyWith(fontSize: 16, fontWeight: FontWeight.w600);

  TextStyle get body16B =>
      headline24R.copyWith(fontSize: 16, fontWeight: FontWeight.w700);

  TextStyle get body14R =>
      headline24R.copyWith(fontSize: 14, fontWeight: FontWeight.w400);

  TextStyle get body14Sb =>
      headline24R.copyWith(fontSize: 14, fontWeight: FontWeight.w600);

  TextStyle get body14M =>
      headline24R.copyWith(fontSize: 14, fontWeight: FontWeight.w500);

  TextStyle get body14B =>
      headline24R.copyWith(fontSize: 14, fontWeight: FontWeight.w700);

  TextStyle get body14MOST =>
      headline24R.copyWith(fontSize: 14, fontWeight: FontWeight.w900);

  TextStyle get body12Sb =>
      headline24R.copyWith(fontSize: 12, fontWeight: FontWeight.w600);

  TextStyle get body12M =>
      headline24R.copyWith(fontSize: 12, fontWeight: FontWeight.w500);

  TextStyle get body12B =>
      headline24R.copyWith(fontSize: 12, fontWeight: FontWeight.w700);

  TextStyle get body12R =>
      headline24R.copyWith(fontSize: 12, fontWeight: FontWeight.w400);

  /// caption :::::::::::::::::::::::::::::::::::::

  TextStyle get caption10R =>
      headline24R.copyWith(fontSize: 10, fontWeight: FontWeight.w400);

  TextStyle get caption10Sb =>
      headline24R.copyWith(fontSize: 10, fontWeight: FontWeight.w600);

  TextStyle get caption10B =>
      headline24R.copyWith(fontSize: 10, fontWeight: FontWeight.w700);

  TextStyle get caption10M =>
      headline24R.copyWith(fontSize: 10, fontWeight: FontWeight.w500);

  TextStyle get caption8R =>
      headline24R.copyWith(fontSize: 10, fontWeight: FontWeight.w400);

  TextStyle get caption8Sb =>
      headline24R.copyWith(fontSize: 10, fontWeight: FontWeight.w500);

  TextStyle get caption8M =>
      headline24R.copyWith(fontSize: 10, fontWeight: FontWeight.w600);

  TextStyle get caption8B =>
      headline24R.copyWith(fontSize: 10, fontWeight: FontWeight.w700);

  /// label :::::::::::::::::::::::::::::::::::::

  /// theme :::::::::::::::::::::::::::::::::::::
  TextStyle get appBar =>
      headline24R.copyWith(fontSize: 18, fontWeight: FontWeight.w600);

  /// input :::::::::::::::::::::::::::::::::::::
  TextStyle get inputText =>
      headline24R.copyWith(fontSize: 14, fontWeight: FontWeight.w400);

  /// button :::::::::::::::::::::::::::::::::::::
  TextStyle get giant =>
      headline24R.copyWith(fontSize: 18, fontWeight: FontWeight.w700);

  TextStyle get large =>
      headline24R.copyWith(fontSize: 16, fontWeight: FontWeight.w500);

  TextStyle get medium =>
      headline24R.copyWith(fontSize: 14, fontWeight: FontWeight.w500);

  TextStyle get small =>
      headline24R.copyWith(fontSize: 12, fontWeight: FontWeight.w500);

  TextStyle get tiny =>
      headline24R.copyWith(fontSize: 10, fontWeight: FontWeight.w500);

  ButtonStyle get buttonMedium => FilledButton.styleFrom(
      minimumSize: const Size(30, 34), maximumSize: const Size(100, 50));

  ButtonStyle get buttonSmall => FilledButton.styleFrom(
      minimumSize: const Size(30, 26), maximumSize: const Size(100, 34));

  ButtonStyle get buttonTiny => FilledButton.styleFrom(
      minimumSize: const Size(30, 26),
      maximumSize: const Size(100, 27),
      textStyle: small,
      padding: 10.px());

  ButtonStyle get buttonGradient => FilledButton.styleFrom(
        textStyle: body16Sb,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundBuilder:
            (BuildContext context, Set<MaterialState> states, Widget? child) {
          return Container(
              decoration: BoxDecoration(
                  borderRadius: 15.r(), gradient: AppColor.primaryBtnGradient),
              child: child);
        },
      );

  InputBorder outlineInputBorder(
      {required Color color, double? borderRadius, bool isBorderNone = false}) {
    return OutlineInputBorder(
      borderSide: BorderSide(
          color: isBorderNone ? Colors.transparent : color, width: 1.0),
      borderRadius: (borderRadius ?? 8).r(),
    );
  }
}
