import 'package:momentum/momentum.dart';
import 'package:nezumi/src/modules/login/index.dart';

mixin AuthMixin<T> on MomentumController<T> {
  String _username;
  String get username {
    if (_username == null) {
      var account = dependOn<LoginController>().getActiveAccount();
      _username = account?.profile?.name;
    }
    return _username;
  }

  String _accessToken;
  String get accessToken {
    if (_accessToken == null) {
      var account = dependOn<LoginController>().getActiveAccount();
      _accessToken = account?.token?.accessToken;
    }
    return _accessToken;
  }
}
