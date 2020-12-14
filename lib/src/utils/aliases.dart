import 'package:flutter/widgets.dart';
import 'package:momentum/momentum.dart';
import 'package:momentum/momentum.dart' as alias;

const ctrl = Momentum.controller;
const srv = Momentum.service;
const restart = Momentum.restart;
const resetAll = Momentum.resetAll;
const getActivePage = alias.Router.getActivePage;

alias.Router createRouter(
  List<Widget> pages, {
  bool enablePersistence,
}) {
  return alias.Router(pages, enablePersistence: enablePersistence);
}
