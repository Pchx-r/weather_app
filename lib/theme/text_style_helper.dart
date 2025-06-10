import 'package:flutter/material.dart';
import '../core/app_export.dart';

class TextStyleHelper {
  static TextStyleHelper? _instance;

  TextStyleHelper._();

  static TextStyleHelper get instance {
    _instance ??= TextStyleHelper._();
    return _instance!;
  }

  TextStyle get display52 => TextStyle(
        fontSize: 52.fSize,
        color: appTheme.whiteCustom,
      );

  TextStyle get display64Thin => TextStyle(
        fontSize: 64.fSize,
        fontWeight: FontWeight.w100,
        color: appTheme.whiteCustom,
      );

  TextStyle get headline24Regular => TextStyle(
        fontSize: 24.fSize,
        fontWeight: FontWeight.w400,
        color: appTheme.whiteCustom,
      );

  TextStyle get headline28 => TextStyle(
        fontSize: 28.fSize,
        color: appTheme.whiteCustom,
      );
  
  TextStyle get title20RegularRoboto => TextStyle(
        fontSize: 20.fSize,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
      );

  TextStyle get title18Regular => TextStyle(
        fontSize: 18.fSize,
        fontWeight: FontWeight.w400,
        color: appTheme.whiteCustom,
      );

  TextStyle get title17 => TextStyle(
        fontSize: 17.fSize,
        color: appTheme.colorFFEBEB,
      );

  TextStyle get title16SemiBold => TextStyle(
        fontSize: 16.fSize,
        fontWeight: FontWeight.w600,
        color: appTheme.colorFFD1D5,
      );

  TextStyle get body14SemiBold => TextStyle(
        fontSize: 14.fSize,
        fontWeight: FontWeight.w600,
        color: appTheme.whiteCustom,
      );

  TextStyle get body13 => TextStyle(
        fontSize: 13.fSize,
        color: appTheme.colorFFEBEB,
      );

  TextStyle get body12SemiBold => TextStyle(
        fontSize: 12.fSize,
        fontWeight: FontWeight.w600,
        color: appTheme.colorFF22D3,
      );




  TextStyle get textStyle8 => TextStyle();
}
