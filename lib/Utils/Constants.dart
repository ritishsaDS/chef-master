import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Constants {
  String currency = "₦";
}double textPrimarySizeGlobal = 16;
double textSecondarySizeGlobal = 14;
String currencyyy ="Pound";
void showToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0);
}TextStyle primaryTextStyle({
  int size,
  Color color,
  FontWeight weight = FontWeight.normal,
  String fontFamily,
  double letterSpacing,
  FontStyle fontStyle,
  double wordSpacing,
  TextDecoration decoration,
  TextDecorationStyle textDecorationStyle,
  TextBaseline textBaseline,
  Color decorationColor,
  Color backgroundColor,
}) {
  return TextStyle(
    fontSize: size != null ? size.toDouble() : textPrimarySizeGlobal,
    color: color ?? Colors.black,
    fontWeight: weight,
    fontFamily: fontFamily ?? Colors.black,
    letterSpacing: letterSpacing,
    fontStyle: fontStyle,
    decoration: decoration,
    decorationStyle: textDecorationStyle,
    decorationColor: decorationColor,
    wordSpacing: wordSpacing,
    textBaseline: textBaseline,
    backgroundColor: backgroundColor,
  );
}

// Secondary Text Style
TextStyle secondaryTextStyle({
  int size,
  Color color,
  FontWeight weight = FontWeight.normal,
  String fontFamily,
  double letterSpacing,
  FontStyle fontStyle,
  double wordSpacing,
  TextDecoration decoration,
  TextDecorationStyle textDecorationStyle,
  TextBaseline textBaseline,
  Color decorationColor,
  Color backgroundColor,
}) {
  return TextStyle(
    fontSize: size != null ? size.toDouble() : textSecondarySizeGlobal,
    color: color ?? Colors.black,
    fontWeight: weight,
    fontFamily: fontFamily ,
    letterSpacing: letterSpacing,
    fontStyle: fontStyle,
    decoration: decoration,
    decorationStyle: textDecorationStyle,
    decorationColor: decorationColor,
    wordSpacing: wordSpacing,
    textBaseline: textBaseline,
    backgroundColor: backgroundColor,
  );
}