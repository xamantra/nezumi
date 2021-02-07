import 'package:momentum/momentum.dart';

import '../../_mconfig/index.dart';
import '../../data/index.dart';
import '../../mixins/index.dart';
import '../../utils/index.dart';
import 'index.dart';

class SessionController extends MomentumController<SessionModel> with CoreMixin {
  @override
  SessionModel init() {
    return SessionModel(
      this,
    );
  }

  @override
  void bootstrap() {
    refreshToken();
  }

  Future<void> refreshToken() async {
    var last_refresh = trycatch(() => DateTime.fromMillisecondsSinceEpoch(int.parse(miscBox.get('last_refresh'))));
    if (last_refresh != null) {
      var diff = DateTime.now().difference(last_refresh).abs();
      if (diff.inHours < 12) {
        return;
      }
    }
    print('Refreshing token...');
    if (login.activeAccountUsername == null) {
      print('Not logged in.');
      return;
    }
    var account = login.controller.getActiveAccount();
    if (account != null && account.token != null) {
      var token = await api.refreshToken(refresh_token: account.token.refreshToken);
      if (token?.accessToken == null) {
        print('Unable to refresh token.');
        return;
      }
      var profile = await api.getProfile(accessToken: token?.accessToken);
      if (profile?.name == null) {
        print('Unable to refresh token.');
        return;
      }
      account = Account(token: token, profile: profile);

      var accounts = List<Account>.from(login.accounts);
      accounts.removeWhere((x) => x.profile.id == account.profile.id);
      accounts.add(account);
      login.update(accounts: accounts);
      await miscBox.put('last_refresh', DateTime.now().millisecondsSinceEpoch.toString());
      print('Token refreshed!');
    }
  }
}
