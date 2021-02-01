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

  String get username {
    var account = controller<LoginController>().getActiveAccount();
    return account.profile.name;
  }

  String get accessToken {
    var account = controller<LoginController>().getActiveAccount();
    return account.token.accessToken;
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

  String get username {
    var account = ctrl<LoginController>(context).getActiveAccount();
    return account.profile.name;
  }

  String get accessToken {
    var account = ctrl<LoginController>(context).getActiveAccount();
    return account.token.accessToken;
  }
}
