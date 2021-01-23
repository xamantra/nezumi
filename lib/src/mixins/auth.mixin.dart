import 'package:flutter/widgets.dart';
import 'package:momentum/momentum.dart';

import '../components/login/index.dart';
import '../utils/index.dart';

mixin AuthMixin<T> on MomentumController<T> {
  int _malAccountId;
  int get malAccountId {
    if (_malAccountId == null) {
      var account = controller<LoginController>().getActiveAccount();
      _malAccountId = account?.profile?.id;
    }
    return _malAccountId;
  }

  String _username;
  String get username {
    if (_username == null) {
      var account = controller<LoginController>().getActiveAccount();
      _username = account?.profile?.name;
    }
    return _username;
  }

  String _accessToken;
  String get accessToken {
    if (_accessToken == null) {
      var account = controller<LoginController>().getActiveAccount();
      _accessToken = account?.token?.accessToken;
    }
    return _accessToken;
  }
}

mixin AuthStateMixin<T extends StatefulWidget> on State<T> {
  int _malAccountId;
  int get malAccountId {
    if (_malAccountId == null) {
      var account = ctrl<LoginController>(context).getActiveAccount();
      _malAccountId = account?.profile?.id;
    }
    return _malAccountId;
  }

  String _username;
  String get username {
    if (_username == null) {
      var account = ctrl<LoginController>(context).getActiveAccount();
      _username = account?.profile?.name;
    }
    return _username;
  }

  String _accessToken;
  String get accessToken {
    if (_accessToken == null) {
      var account = ctrl<LoginController>(context).getActiveAccount();
      _accessToken = account?.token?.accessToken;
    }
    return _accessToken;
  }
}
