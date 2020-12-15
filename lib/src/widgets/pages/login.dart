import 'package:flutter/material.dart' hide Router;
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:momentum/momentum.dart';
import 'package:nezumi/src/widgets/pages/index.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../modules/login/index.dart';
import '../../utils/index.dart';
import '../index.dart';
import 'history.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends MomentumState<Login> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ctrl<LoginController>(context).listen<LoginEvent>(
      state: this,
      invoke: (event) {
        switch (event) {
          case LoginEvent.loggedIn:
            Router.goto(context, Dashboard);
            break;
          case LoginEvent.gotoLogin:
            var codeVerifier = ctrl<LoginController>(context).model.codeVerifier;
            gotoLogin(context, codeVerifier);
            break;
          default:
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RelativeBuilder(
        builder: (context, height, width, sy, sx) {
          return Container(
            width: width,
            color: AppTheme.of(context).primaryBackground,
            child: MomentumBuilder(
              controllers: [LoginController],
              builder: (context, snapshot) {
                var login = snapshot<LoginModel>();
                var loading = login.loading;

                if (loading) {
                  return Center(
                    child: SizedBox(
                      height: sy(20),
                      width: sy(20),
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(AppTheme.of(context).primary),
                      ),
                    ),
                  );
                }

                return Center(
                  child: SizedButton(
                    height: sy(30),
                    width: width - sy(30),
                    color: AppTheme.of(context).primary,
                    child: Text(
                      'LOGIN NOW',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      login.controller.tryLogin();
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void gotoLogin(BuildContext context, String codeVerifier) async {
    try {
      await launch(
        'https://myanimelist.net/v1/oauth2/authorize?response_type=code&client_id=$client_id&code_challenge=$codeVerifier&redirect_uri=$redirect_uri',
        option: new CustomTabsOption(
          toolbarColor: Theme.of(context).primaryColor,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          animation: new CustomTabsAnimation.slideIn(),
          extraCustomTabs: <String>[
            // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
            'org.mozilla.firefox',
            // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
            'com.microsoft.emmx',
          ],
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
