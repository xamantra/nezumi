import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../components/app/index.dart';
import '../../mixins/index.dart';
import '../app-theme.dart';
import 'index.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with SingleTickerProviderStateMixin, CoreStateMixin {
  TabController tabController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return MomentumBuilder(
          controllers: [AppController],
          builder: (context, snapshot) {
            return Scaffold(
              backgroundColor: AppTheme.of(context).primary,
              body: nav.activeWidget,
              drawer: AppDrawer(),
            );
          },
        );
      },
    );
  }
}
