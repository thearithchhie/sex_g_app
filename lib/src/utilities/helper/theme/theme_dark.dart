import 'package:sex_g_app/export.dart';

class ThemeDark extends ThemeInterface {
  @override
  AppBarTheme get appBarTheme => AppBarTheme(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        shadowColor: const Color(0xFF0C0E0E),
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: typography.appBar,
        iconTheme: IconThemeData(color: fontColor, size: 24),
      );

  @override
  BottomNavigationBarThemeData get bottomNavigationBarTheme =>
      BottomNavigationBarThemeData(
        backgroundColor: AppColor.black.withAlpha(70),
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        unselectedLabelStyle: const TextStyle(
            color: AppColor.grey, fontSize: 12, fontWeight: FontWeight.w400),
        selectedLabelStyle: const TextStyle(
            color: AppColor.white, fontSize: 12, fontWeight: FontWeight.w500),
        unselectedItemColor: AppColor.grey,
        selectedItemColor: AppColor.white,
      );

  @override
  BottomSheetThemeData get bottomSheetTheme => const BottomSheetThemeData(
        backgroundColor: AppColor.bgDark,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(18))),
      );

  @override
  Brightness get brightness => Brightness.dark;

  @override
  CardTheme get cardTheme => CardTheme(
        color: Colors.black,
        margin: EdgeInsets.zero,
        elevation: 15,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        shadowColor: Colors.black.withOpacity(0.4),
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
        brightness: Brightness.dark,
        surfaceContainer: Color(0xff1B2450),
        onSurfaceVariant: Color(0xff000000),
        inverseSurface: Color(0xff000000),
        inversePrimary: Color(0xffc8e6c9),
        shadow: Color(0xFF0C0E0E),
        surfaceTint: AppColor.primary,
      );

  @override
  Color get dividerColor => AppColor.black.withAlpha(70);

  @override
  Color get fontColor => AppColor.white;

  @override
  Color get highlightColor => const Color(0xFF0C0E0E);

  @override
  InputDecorationTheme get inputDecorationTheme => InputDecorationTheme(
        fillColor: Colors.grey[600]!,
        suffixStyle: TextStyle(fontSize: 12, color: fontColor),
        labelStyle: const TextStyle(
            color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
        hintStyle: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
        prefixIconColor: fontColor,
        suffixIconColor: fontColor,
        focusColor: AppColor.grey,
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF828282), width: 1.5),
            gapPadding: 0),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF828282), width: 1),
            gapPadding: 0),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF828282), width: 1.5),
          gapPadding: 0,
        ),
        constraints: const BoxConstraints(minHeight: 20),
      );

  @override
  MaterialColor get primarySwatch =>
      MaterialColor(AppColor.primary.value, const <int, Color>{
        50: AppColor.pr50,
        100: AppColor.pr100,
        200: AppColor.pr200,
        300: AppColor.pr300,
        400: AppColor.pr400,
        500: AppColor.pr500,
        600: AppColor.pr600,
        700: AppColor.pr700,
        800: AppColor.pr800,
        900: AppColor.pr900,
      });

  @override
  Color get scaffoldBackgroundColor => AppColor.black.withAlpha(70);

  @override
  TabBarTheme get tabBarTheme => TabBarTheme(
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: fontColor,
        unselectedLabelColor: AppColor.colorHex('#9ABFF6'),
        labelPadding: 10.p(t: 0, b: 15),
        unselectedLabelStyle: typography.body14M,
        labelStyle: typography.body14Sb,
      );

  @override
  TypographyInterface get typography => TypographyDark();

  @override
  Color get unselectedWidgetColor => Colors.black.withAlpha(70);
}
