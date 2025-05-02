import 'package:sex_g_app/export.dart';

class ThemeLight extends ThemeInterface {
  @override
  AppBarTheme get appBarTheme => AppBarTheme(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        shadowColor: const Color(0xFFDCDCDC),
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: typography.appBar,
        iconTheme: IconThemeData(color: fontColor, size: 24),
      );

  @override
  BottomNavigationBarThemeData get bottomNavigationBarTheme =>
      const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFFFAFAFA),
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        unselectedLabelStyle: TextStyle(
            color: Color(0xFFAAAAAA),
            fontSize: 12,
            fontWeight: FontWeight.w400),
        selectedLabelStyle: TextStyle(
            color: Colors.black, fontSize: 12, fontWeight: FontWeight.w500),
        unselectedItemColor: AppColor.grey,
        selectedItemColor: Colors.black,
      );

  @override
  BottomSheetThemeData get bottomSheetTheme => BottomSheetThemeData(
        backgroundColor: AppColor.bgLight,
        modalBarrierColor: AppColor.black.withAlpha(50),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(18))),
      );

  @override
  Brightness get brightness => Brightness.light;

  @override
  CardTheme get cardTheme => CardTheme(
        color: Colors.white,
        margin: EdgeInsets.zero,
        elevation: 15,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        shadowColor: Colors.black.withAlpha(40),
        surfaceTintColor: AppColor.white,
      );

  @override
  ColorScheme get colorScheme => const ColorScheme(
        primary: AppColor.primary,
        secondary: Colors.white,
        surface: Color(0xffffffff),
        error: Color(0xffd32f2f),
        onPrimary: Color(0xffffffff),
        onSecondary: Color(0xffffffff),
        onSurface: Color(0xff000000),
        onError: Colors.red,
        brightness: Brightness.light,
      );

  @override
  Color get dividerColor => AppColor.grey;

  @override
  Color get fontColor => typography.fontColor;

  @override
  Color get highlightColor => const Color(0x66bcbcbc);

  @override
  InputDecorationTheme get inputDecorationTheme => InputDecorationTheme(
        fillColor: Colors.grey[50]!,
        suffixStyle: TextStyle(fontSize: 12, color: fontColor),
        labelStyle: const TextStyle(
            color: Colors.black54, fontSize: 14, fontWeight: FontWeight.w500),
        hintStyle: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black54),
        prefixIconColor: fontColor,
        suffixIconColor: fontColor,
        focusColor: AppColor.grey,
        border: OutlineInputBorder(
          // borderSide: BorderSide(color: Color(0xFF828282), width: 1.5),
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 1, color: Colors.grey),
          gapPadding: 0,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 1, color: Colors.grey),
          gapPadding: 0,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 1, color: Colors.grey),
          gapPadding: 0,
        ),
        constraints: const BoxConstraints(minHeight: 20),
      );

  @override
  MaterialColor get primarySwatch => Colors.green;

  @override
  Color get scaffoldBackgroundColor => AppColor.white;

  @override
  TabBarTheme get tabBarTheme => TabBarTheme(
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: fontColor,
        unselectedLabelColor: const Color(0xFFC4C4C4),
        labelPadding: const EdgeInsets.symmetric(horizontal: 14),
        unselectedLabelStyle:
            TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.7)),
        labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
      );

  @override
  TypographyInterface get typography => TypographyLight();

  @override
  Color get unselectedWidgetColor => Colors.black;
}
