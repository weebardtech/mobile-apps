import 'package:flutter/material.dart';

class AppColorTheme {
  static final ThemeData appTheme = ThemeData(
    primarySwatch: AppColors.primary,
    hintColor: const Color(0xFF0062FF),
    primaryColor: const Color(0xFF003062),
    primaryColorDark: const Color(0xFF000D33),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    /*pageTransitionsTheme: PageTransitionsTheme(builders: {
        TargetPlatform.android: CustomPageTransitionBuilder(),
        TargetPlatform.iOS: CustomPageTransitionBuilder(),
      })
  */
  );

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColorDark: appTheme.primaryColor,
    colorScheme: ColorScheme.dark(primary: appTheme.primaryColor),
    dividerColor: Colors.white,
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: appTheme.primaryColor,
    colorScheme: ColorScheme.light(primary: appTheme.primaryColor),
    dividerColor: Colors.black,
  );

  static final Color primary = Color(0xFF0062FF);
  static final Color secondary =  Color(0xFF003062);
  static final Color primaryDark =  Color(0xFF000D33);
  static final Color light_gray =  Color(0xFFD3D3D3);


  static const Color white = Color(0xFFFFFFFF);
  static const Color gray = Color(0xFF999999);

  static const Color primary_light = Color(0xFFF8EEEC);
}

class AppColors {
  static const MaterialColor primary = MaterialColor(
    0xFF388e3c,
    <int, Color>{
      50: Color(0xFF003062),
      100: Color(0xFF003062),
      200: Color(0xFF003062),
      300: Color(0xFF003062),
      400: Color(0xFF003062),
      500: Color(0xFF003062),
      600: Color(0xFF003062),
      700: Color(0xFF003062),
      800: Color(0xFF003062),
      900: Color(0xFF003062),
    },
  );
}

