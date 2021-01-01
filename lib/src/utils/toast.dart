import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(
  String message, {
  @required double fontSize,
  @required Color color,
}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: color ?? Colors.black.withOpacity(0.5),
    textColor: Colors.white,
    fontSize: fontSize,
  );
}
