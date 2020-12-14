import 'package:momentum/momentum.dart';

import '../../data/index.dart';
import 'index.dart';

class LoginModel extends MomentumModel<LoginController> {
  LoginModel(
    LoginController controller, {
    this.loadingProfile,
    this.accounts,
    this.activeAccountUsername,
    this.codeVerifier,
  }) : super(controller);

  final bool loadingProfile;
  final String codeVerifier;
  final List<Account> accounts;
  final String activeAccountUsername;

  bool get loading => loadingProfile;

  @override
  void update({
    bool loadingProfile,
    List<Account> accounts,
    String activeAccountUsername,
    String codeVerifier,
  }) {
    LoginModel(
      controller,
      loadingProfile: loadingProfile ?? this.loadingProfile,
      accounts: accounts ?? this.accounts,
      activeAccountUsername: activeAccountUsername ?? this.activeAccountUsername,
      codeVerifier: codeVerifier ?? this.codeVerifier,
    ).updateMomentum();
  }

  Map<String, dynamic> toJson() {
    return {
      'loadingProfile': false,
      'accounts': accounts?.map((x) => x?.toJson())?.toList(),
      'activeAccountUsername': activeAccountUsername,
      'codeVerifier': codeVerifier,
    };
  }

  LoginModel fromJson(Map<String, dynamic> map) {
    if (map == null) return null;

    return LoginModel(
      controller,
      loadingProfile: map['loadingProfile'],
      accounts: List<Account>.from(map['accounts']?.map((x) => Account.fromJson(x))),
      activeAccountUsername: map['activeAccountUsername'],
      codeVerifier: map['codeVerifier'],
    );
  }
}
