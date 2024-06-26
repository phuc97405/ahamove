part of 'theme.dart';

final ThemeData appThemeData = ThemeData(
  fontFamily: 'Source Sans Pro',
  scaffoldBackgroundColor: Colors.white,
  primaryColor: ColorConstants.instance.primary,
  brightness: Brightness.light,
  // textTheme: _lightTextTheme,
  buttonTheme: ButtonThemeData(
    buttonColor: ColorConstants.instance.green,
    textTheme: ButtonTextTheme.primary,
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide(color: ColorConstants.instance.onPrimary),
      borderRadius: BorderRadius.circular(6),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: ColorConstants.instance.border),
      borderRadius: BorderRadius.circular(6),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: ColorConstants.instance.black0B),
      borderRadius: BorderRadius.circular(6),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: ColorConstants.instance.border),
      borderRadius: BorderRadius.circular(6),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: ColorConstants.instance.black0B),
      borderRadius: BorderRadius.circular(6),
    ),
    fillColor: Colors.white,
    focusColor: Colors.white,
  ),
  colorScheme: ColorScheme.light(
    primary: ColorConstants.instance.primary,
    // secondary: _lightSecondaryColor,
  ).copyWith(secondary: ColorConstants.instance.primary),
);

const double kHorizontalContentPadding = 20.0;
