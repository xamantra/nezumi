// import 'package:flutter/material.dart';
// import 'package:relative_scale/relative_scale.dart';

// import '../../../mixins/index.dart';
// import '../../app-theme.dart';
// import '../../index.dart';
// import 'index.dart';

// class AnimeListPage extends StatefulWidget {
//   const AnimeListPage({Key key}) : super(key: key);

//   @override
//   _AnimeListPageState createState() => _AnimeListPageState();
// }

// class _AnimeListPageState extends State<AnimeListPage> with TickerProviderStateMixin, CoreStateMixin {
//   TabController tabController;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     tabController = TabController(length: 6, vsync: this);
//     mal?.controller?.initializeAnimeList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return RelativeBuilder(
//       builder: (context, height, width, sy, sx) {
//         return Container(
//           height: height,
//           width: width,
//           color: AppTheme.of(context).primary,
//           child: SafeArea(
//             child: Column(
//               children: [
//                 Toolbar(
//                   height: sy(42),
//                   leadingIcon: Icons.menu,
//                   title: 'Anime List',
//                   actions: [
//                     ToolbarAction(icon: Icons.search),
//                     ToolbarAction(icon: Icons.filter_list),
//                     ToolbarAction(icon: Icons.more_vert),
//                   ],
//                   leadingAction: () {
//                     Scaffold.of(context).openDrawer();
//                   },
//                 ),
//                 Container(
//                   width: width,
//                   color: AppTheme.of(context).primary,
//                   padding: EdgeInsets.symmetric(horizontal: sy(8)),
//                   child: TabBar(
//                     controller: tabController,
//                     isScrollable: true,
//                     labelColor: Colors.white,
//                     indicatorColor: Colors.white,
//                     labelStyle: TextStyle(
//                       fontSize: sy(9.5),
//                       fontWeight: FontWeight.w400,
//                     ),
//                     physics: BouncingScrollPhysics(),
//                     tabs: [
//                       Tab(text: 'All'),
//                       Tab(text: 'Watching'),
//                       Tab(text: 'On Hold'),
//                       Tab(text: 'Completed'),
//                       Tab(text: 'Planning'),
//                       Tab(text: 'Dropped'),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: Container(
//                     color: AppTheme.of(context).primaryBackground,
//                     padding: EdgeInsets.symmetric(horizontal: sy(8)),
//                     child: TabBarView(
//                       controller: tabController,
//                       physics: BouncingScrollPhysics(),
//                       children: [
//                         AnimeListView(status: 'all'),
//                         AnimeListView(status: 'watching'),
//                         AnimeListView(status: 'on_hold'),
//                         AnimeListView(status: 'completed'),
//                         AnimeListView(status: 'plan_to_watch'),
//                         AnimeListView(status: 'dropped'),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
