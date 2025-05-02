import 'package:flutter/material.dart';

class AppColor {
  const AppColor._();

  static const Color primary = Color(0xff63ABFF);
  static const Color yellow = Color(0xffFDC814);
  static const Color black = Color(0xff000000);
  static const Color white = Color(0xffFFFFFF);
  static const Color grey = Color(0xffDBDBDB);
  static const Color danger = Color(0xffFF3E3E);
  static const Color waring = Color(0xffF7A539);
  static const Color green = Color(0xff1AD37B);
  static const Color bgColor = Color(0xffF8FAFB);

  static const Color pr50 = Color(0xfff0f5fe);
  static const Color pr100 = Color(0xffdde8fc);
  static const Color pr200 = Color(0xffc3d8fa);
  static const Color pr300 = Color(0xff9abff6);
  static const Color pr400 = Color(0xff6a9ef0);
  static const Color pr500 = Color(0xff477bea);
  static const Color pr600 = Color(0xff325dde);
  static const Color pr700 = Color(0xff2644bd);
  static const Color pr800 = Color(0xff273da6);
  static const Color pr900 = Color(0xff253783);
  static const Color pr950 = Color(0xff1b2450);

  static const Color neutral50 = Color(0xfff6f6f6);
  static const Color neutral100 = Color(0xffe7e7e7);
  static const Color neutral200 = Color(0xffd1d1d1);
  static const Color neutral300 = Color(0xffb0b0b0);
  static const Color neutral400 = Color(0xff888888);
  static const Color neutral500 = Color(0xff6d6d6d);
  static const Color neutral600 = Color(0xff5d5d5d);
  static const Color neutral700 = Color(0xff4f4f4f);
  static const Color neutral800 = Color(0xff454545);
  static const Color neutral900 = Color(0xff3d3d3d);
  static const Color neutral950 = Color(0xff0a0a0a);

  /// Gradient colors dark ===================================
  static const Gradient primaryBgGradient = LinearGradient(
    colors: [Color(0xff070429), Color(0xff000000)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Color bgDark = Color(0xff1B2450);

  static const Gradient secondaryBgGradient = LinearGradient(
    colors: [Color(0xff050532), Color(0xff050532)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Gradient colors light ====================================
  static const Gradient primaryBgGradientLight = LinearGradient(
    colors: [neutral50, neutral100],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient homeBgGradient = LinearGradient(
    colors: [Color(0xff1B2450), Color(0xff080F33)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.1, 1.0],
  );

  static const Gradient homeBgGradientLight = LinearGradient(
    colors: [Colors.white, Colors.white],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Color bgLight = Color(0xffEEF1F6);

  static const Gradient secondaryBgGradientLight = LinearGradient(
    colors: [Color(0xffEEF1F6), Color(0xffEEF1F6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient primaryBtnGradient = LinearGradient(
    colors: [Color(0xff2644BD), Color(0xff3B59FC)],
    begin: Alignment.topLeft,
    end: Alignment.topRight,
  );

  static Gradient disabledGradient = LinearGradient(
    colors: [
      const Color(0xff2644BD).withAlpha(50),
      const Color(0xff3B59FC).withAlpha(50)
    ],
    begin: Alignment.topLeft,
    end: Alignment.topRight,
  );

  static Gradient disabledGradientDark = LinearGradient(
    colors: [
      const Color(0xff2644BD).withOpacity(0.6),
      const Color(0xff3B59FC).withOpacity(0.6)
    ],
    begin: Alignment.topLeft,
    end: Alignment.topRight,
  );

  static const Gradient secondaryBtnGradient = LinearGradient(
    colors: [Color(0xff6FC2FF), Color(0xffACD8FF)],
    begin: Alignment.topLeft,
    end: Alignment.topRight,
  );

  static const Gradient thirdBtnGradient = LinearGradient(
    colors: [Color(0xff5683DB), Color(0xff4E7AD1)],
    begin: Alignment.topLeft,
    end: Alignment.topRight,
  );

  static Color colorHex(String v) {
    v = v.replaceAll("#", "");
    return Color(int.parse("0xFF$v"));
  }
}
