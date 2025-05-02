import 'package:sex_g_app/export.dart';

abstract class ThemeInterface {
  final defaultFontHeight = 1.35;
  final fontFamily = "SFPro";

  TypographyInterface get typography;

  Color get fontColor;

  Brightness get brightness;

  MaterialColor get primarySwatch;

  Color get scaffoldBackgroundColor;

  Color get dividerColor;

  Color get highlightColor;

  Color get unselectedWidgetColor;

  AppBarTheme get appBarTheme;

  BottomSheetThemeData get bottomSheetTheme;

  BottomNavigationBarThemeData get bottomNavigationBarTheme;

  InputDecorationTheme get inputDecorationTheme;

  ColorScheme get colorScheme;

  TabBarTheme get tabBarTheme;

  CardTheme get cardTheme;

  ThemeData get theme => ThemeData(
        useMaterial3: true,
        // ignore: deprecated_member_use
        primarySwatch: primarySwatch,
        brightness: brightness,
        primaryColor: AppColor.primary,
        primaryColorLight: const Color(0xffc8e6c9),
        primaryColorDark: const Color(0xff388e3c),
        canvasColor: Colors.white,
        cardTheme: cardTheme,
        filledButtonTheme: _filledButtonThemeData,
        textButtonTheme: _textButton,
        outlinedButtonTheme: _outLineButtonTheme,
        bottomSheetTheme: bottomSheetTheme,
        actionIconTheme: ActionIconThemeData(
            backButtonIconBuilder: (_) =>
                const Icon(Icons.arrow_back_ios_new, size: 19)),
        inputDecorationTheme: inputDecorationTheme,
        colorScheme: colorScheme,

        /// Scaffold backgroundColor
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        cardColor: const Color(0xFFF5F5F5),
        dividerColor: dividerColor,
        highlightColor: const Color(0xFF0C0E0E),
        splashColor: const Color(0x66c8c8c8),
        unselectedWidgetColor: Colors.black.withAlpha(70),
        disabledColor: const Color(0x61000000),
        secondaryHeaderColor: const Color(0xffe8f5e9),
        indicatorColor: AppColor.primary,
        hintColor: AppColor.black,
        bottomAppBarTheme: const BottomAppBarTheme(color: Colors.white),
        bottomNavigationBarTheme: bottomNavigationBarTheme,
        appBarTheme: appBarTheme,
        buttonTheme: const ButtonThemeData(
          textTheme: ButtonTextTheme.normal,
          minWidth: 88,
          height: 47,
          padding: EdgeInsets.only(top: 0, bottom: 0, left: 16, right: 16),
          shape: RoundedRectangleBorder(
            side: BorderSide(
                color: Color(0xff000000), width: 0, style: BorderStyle.none),
            borderRadius: BorderRadius.all(Radius.circular(2.0)),
          ),
          alignedDropdown: false,
          buttonColor: Color(0xffe0e0e0),
          disabledColor: Color(0x61000000),
          highlightColor: Color(0x29000000),
          splashColor: Color(0x1f000000),
          focusColor: Color(0x1f000000),
          hoverColor: Color(0x0a000000),
          colorScheme: ColorScheme(
            primary: AppColor.primary,
            secondary: Colors.white,
            surface: Color(0xffffffff),
            error: Color(0xffd32f2f),
            onPrimary: Color(0xffffffff),
            onSecondary: Color(0xffffffff),
            onSurface: Color(0xff000000),
            onError: Colors.red,
            brightness: Brightness.light,
          ),
        ),
        fontFamily: fontFamily,
        textTheme: textTheme,
        primaryTextTheme: primaryTextTheme,
        iconTheme: IconThemeData(color: fontColor, opacity: 1, size: 24),
        primaryIconTheme: IconThemeData(color: fontColor, opacity: 1, size: 24),
        sliderTheme: const SliderThemeData(
          activeTrackColor: null,
          inactiveTrackColor: null,
          disabledActiveTrackColor: null,
          disabledInactiveTrackColor: null,
          activeTickMarkColor: null,
          inactiveTickMarkColor: null,
          disabledActiveTickMarkColor: null,
          disabledInactiveTickMarkColor: null,
          thumbColor: null,
          disabledThumbColor: null,
          thumbShape: null,
          overlayColor: null,
          valueIndicatorColor: Colors.black,
          valueIndicatorShape: null,
          showValueIndicator: null,
          valueIndicatorTextStyle: TextStyle(
            color: Color(0xffffffff),
            fontSize: null,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
        ),
        tabBarTheme: tabBarTheme,
        chipTheme: const ChipThemeData(
          backgroundColor: Color(0x1f000000),
          brightness: Brightness.light,
          deleteIconColor: Color(0xde000000),
          disabledColor: Color(0x0c000000),
          labelPadding: EdgeInsets.only(top: 0, bottom: 0, left: 8, right: 8),
          labelStyle: TextStyle(
            color: Color(0xde000000),
            fontSize: null,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          padding: EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 4),
          secondaryLabelStyle: TextStyle(
            color: Color(0x3d000000),
            fontSize: null,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          secondarySelectedColor: Color(0x3d4caf50),
          selectedColor: Color(0x3d000000),
          shape: StadiumBorder(
              side: BorderSide(
                  color: Color(0xff000000), width: 0, style: BorderStyle.none)),
        ),
        dialogTheme: const DialogTheme(
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            side: BorderSide(
                color: Color(0xff000000), width: 0, style: BorderStyle.none),
            borderRadius: BorderRadius.all(Radius.circular(0.0)),
          ),
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xff4285f4),
          selectionColor: Color(0xff658ed3),
          selectionHandleColor: Color(0xff658ed3),
        ),
      );

  OutlinedButtonThemeData get _outLineButtonTheme {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        surfaceTintColor: AppColor.primary,
        foregroundColor: AppColor.primary,
        disabledForegroundColor: AppColor.grey,
        minimumSize: const Size(30, 44),
        side: const BorderSide(width: 1, color: AppColor.primary),
        textStyle: TextStyle(
          fontFamily: fontFamily,
          color: AppColor.primary,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    );
  }

  TextButtonThemeData get _textButton {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColor.primary,
        minimumSize: const Size(30, 40),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        textStyle: TextStyle(
            fontSize: 14, fontWeight: FontWeight.w600, fontFamily: fontFamily),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    );
  }

  FilledButtonThemeData get _filledButtonThemeData {
    return FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(30, 44),
        disabledBackgroundColor: const Color(0xffaeaeae),
        disabledForegroundColor: Colors.white,
        backgroundColor: AppColor.primary,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: TextStyle(
            fontFamily: fontFamily,
            color: AppColor.white,
            fontSize: 16,
            fontWeight: FontWeight.w500),
      ),
    );
  }

  TextTheme get textTheme {
    return TextTheme(
      displayLarge: TextStyle(
        color: fontColor,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.normal,
        height: defaultFontHeight,
      ),
      displayMedium: TextStyle(
        color: fontColor,
        fontSize: 19,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.normal,
        height: defaultFontHeight,
      ),
      displaySmall: TextStyle(
        color: fontColor,
        fontSize: 18,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w700,
        height: defaultFontHeight,
      ),
      headlineLarge: TextStyle(
        color: fontColor,
        fontSize: 17,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.normal,
        height: defaultFontHeight,
      ),
      headlineMedium: TextStyle(
        color: fontColor,
        fontSize: 16,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.normal,
        height: defaultFontHeight,
      ),
      headlineSmall: TextStyle(
        color: fontColor,
        fontSize: 15,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.normal,
        height: defaultFontHeight,
      ),
      titleLarge: TextStyle(
        color: fontColor,
        fontSize: 20,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        height: defaultFontHeight,
      ),
      titleMedium: TextStyle(
        color: fontColor,
        fontSize: 19,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        height: defaultFontHeight,
      ),
      titleSmall: TextStyle(
        color: fontColor,
        fontSize: 18,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        height: defaultFontHeight,
      ),
      bodyLarge: TextStyle(
        color: fontColor,
        fontSize: 17,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        height: defaultFontHeight,
      ),
      bodyMedium: TextStyle(
        color: fontColor,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        height: defaultFontHeight,
      ),
      bodySmall: TextStyle(
        color: fontColor,
        fontSize: 15,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        height: defaultFontHeight,
      ),
      labelLarge: TextStyle(
        color: fontColor,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        height: defaultFontHeight,
      ),
      labelMedium: TextStyle(
        color: fontColor,
        fontSize: 13,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        height: defaultFontHeight,
      ),
      labelSmall: TextStyle(
        color: fontColor,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        letterSpacing: 0.5,
        height: defaultFontHeight,
      ),
    );
  }

  TextTheme get primaryTextTheme {
    return TextTheme(
      displayLarge: TextStyle(
        color: fontColor,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.normal,
        height: defaultFontHeight,
      ),
      displayMedium: TextStyle(
        color: fontColor,
        fontSize: 17,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
        height: defaultFontHeight,
      ),
      displaySmall: TextStyle(
        color: fontColor,
        fontSize: 16,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w600,
        height: defaultFontHeight,
      ),
      headlineLarge: TextStyle(
        color: fontColor,
        fontSize: 15,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
        height: defaultFontHeight,
      ),
      headlineMedium: TextStyle(
        color: fontColor,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
        height: defaultFontHeight,
      ),
      headlineSmall: TextStyle(
        color: fontColor,
        fontSize: 13,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
        height: defaultFontHeight,
      ),
      titleLarge: TextStyle(
        color: fontColor,
        fontSize: 17,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        height: defaultFontHeight,
      ),
      titleMedium: TextStyle(
        color: fontColor,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        height: defaultFontHeight,
      ),
      titleSmall: TextStyle(
        color: fontColor,
        fontSize: 15,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        height: defaultFontHeight,
      ),
      bodyLarge: TextStyle(
        color: fontColor,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        height: defaultFontHeight,
      ),
      bodyMedium: TextStyle(
        color: fontColor,
        fontSize: 13,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        height: defaultFontHeight,
      ),
      bodySmall: TextStyle(
        color: fontColor,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        height: defaultFontHeight,
      ),
      labelLarge: TextStyle(
        color: fontColor,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        height: defaultFontHeight,
      ),
      labelMedium: TextStyle(
        color: fontColor,
        fontSize: 11,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        height: defaultFontHeight,
      ),
      labelSmall: TextStyle(
        color: fontColor,
        fontSize: 10,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        height: defaultFontHeight,
      ),
    );
  }
}
