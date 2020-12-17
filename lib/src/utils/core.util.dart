import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Future<T> dialog<T>(BuildContext context, Widget dialog) async {
  try {
    var result = await showDialog<T>(context: context, builder: (context) => dialog);
    return result;
  } catch (e) {
    return null;
  }
}
