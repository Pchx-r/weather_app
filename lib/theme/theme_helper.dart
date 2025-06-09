import 'package:flutter/material.dart';
import '../core/app_export.dart';
import '../core/utils/pref_utils.dart';

String _appTheme = "lightCode";
LightCodeColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();


class ThemeHelper {
  Map<String, LightCodeColors> _supportedCustomColor = {
    'lightCode': LightCodeColors()
  };

  Map<String, ColorScheme> _supportedColorScheme = {
    'lightCode': ColorSchemes.lightCodeColorScheme
  };

  void changeTheme(String _newTheme) {
    _appTheme = _newTheme;
  }

  LightCodeColors _getThemeColors() {
    return _supportedCustomColor[_appTheme] ?? LightCodeColors();
  }

  ThemeData _getThemeData() {
    var colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.lightCodeColorScheme;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
    );
  }

  LightCodeColors themeColor() => _getThemeColors();

  ThemeData themeData() => _getThemeData();
}

class ColorSchemes {
  static final lightCodeColorScheme = ColorScheme.light();
}

class LightCodeColors {
  Color get black => Color(0xFF1E1E1E);
  Color get white => Color(0xFFFFFFFF);
  Color get gray300 => Color(0xFFD1D5DB);
  Color get gray400 => Color(0xFF9CA3AF);
  Color get gray600 => Color(0xFF4B5563);

  Color get whiteCustom => Colors.white;
  Color get blackCustom => Colors.black;
  Color get transparentCustom => Colors.transparent;
  Color get greyCustom => Colors.grey;
  Color get colorFF2E33 => Color(0xFF2E335A);
  Color get colorFF1C1B => Color(0xFF1C1B33);
  Color get colorFF612F => Color(0xFF612FAB);
  Color get colorFF612E => Color(0xFF612EAB);
  Color get colorFFD1D5 => Color(0xFFD1D5DB);
  Color get colorFF9CA3 => Color(0xFF9CA3AF);
  Color get colorFF4B55 => Color(0xFF4B5563);
  Color get color3F0000 => Color(0x3F000000);
  Color get colorFFF5F5 => Color(0xFFF5F5F9);
  Color get colorFFDADF => Color(0xFFDADFE7);
  Color get colorFFBBBF => Color(0xFFBBBFC6);
  Color get colorFF4831 => Color(0xFF48319D);
  Color get colorFF22D3 => Color(0xFF22D3EE);
  Color get colorFF8888 => Color(0xFF888888);
  Color get colorFFEBEB => Color(0xFFEBEBF5);

  Color get grey200 => Colors.grey.shade200;
  Color get grey100 => Colors.grey.shade100;
  Color get grey400 => Colors.grey.shade400;
}
