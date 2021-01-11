import 'package:flutter/material.dart';

Future<T> dialog<T>(BuildContext context, Widget dialog) async {
  try {
    var result = await showDialog<T>(context: context, builder: (context) => dialog);
    return result;
  } catch (e) {
    return null;
  }
}

Future<T> push<T>(BuildContext context, Widget page) async {
  var result = await Navigator.push<T>(context, MaterialPageRoute(builder: (_) => page));
  return result;
}
