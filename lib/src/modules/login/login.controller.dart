import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:momentum/momentum.dart';
import 'package:random_string/random_string.dart';

import '../../data/index.dart';
import '../../mixins/index.dart';
import 'index.dart';

class LoginController extends MomentumController<LoginModel> with CoreMixin {
  @override
  LoginModel init() {
    return LoginModel(
      this,
      loadingProfile: false,
      accounts: [],
    );
  }

  @override
  void bootstrap() {
    Clipboard.setData(ClipboardData(text: ''));
    if (isLoggedIn()) {
      sendEvent(LoginEvent.loggedIn);
      return;
    }
  }

  void generateCodeVerifier() {
    var codeVerifier = randomAlphaNumeric(50);
    model.update(codeVerifier: codeVerifier);
  }

  void tryLogin() async {
    var code = await getLoginCode();
    if (code != null) {
      login(loginCode: code);
    } else {
      generateCodeVerifier();
      sendEvent(LoginEvent.gotoLogin);
    }
  }

  Future<String> getLoginCode() async {
    try {
      var clip = await Clipboard.getData('text/plain');
      var text = clip?.text ?? '';
      if (text.length > 800) {
        return text;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<void> login({@required String loginCode}) async {
    model.update(loadingProfile: true);
    var accounts = List<Account>.from(model.accounts);
    var token = await api.getToken(code: loginCode, codeVerifier: model.codeVerifier);
    var profile = await api.getProfile(accessToken: token.accessToken);
    var account = Account(token: token, profile: profile);
    accounts.add(account);
    model.update(loadingProfile: false, accounts: accounts, activeAccountUsername: profile.name);
    sendEvent(LoginEvent.loggedIn);
  }

  Account getActiveAccount() {
    try {
      var find = model.accounts.firstWhere((x) => x.profile.name == model.activeAccountUsername);
      return find;
    } catch (e) {
      return null;
    }
  }

  bool isLoggedIn() {
    return model.activeAccountUsername != null && getActiveAccount() != null;
  }
}
