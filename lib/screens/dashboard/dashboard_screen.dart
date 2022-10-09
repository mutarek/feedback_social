import 'package:als_frontend/provider/dashboard_provider.dart';
import 'package:als_frontend/provider/newsfeed_provider.dart';
import 'package:als_frontend/screens/home/home_screen.dart';
import 'package:als_frontend/screens/profile/profile_screen.dart';
import 'package:als_frontend/widgets/circle_button.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final PageController controller = PageController();
  RefreshController refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    refreshController = RefreshController(initialRefresh: false);
  }
  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<NewsFeedProvider>(context, listen: false).initializeAllFeedData((bool status){},page: 1);
    return Builder(builder: (context) {
      return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Consumer<DashboardProvider>(
              builder: (context, dashboardProvider, child) => Column(
                children: [
                  dashboardProvider.selectIndex == 0
                      ? AppBar(
                          title: CustomText(title: 'Feedback', color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 27),
                          backgroundColor: Colors.white,
                          elevation: 0,
                          actions: [
                            CircleButton(
                              radius: 35.0,
                              icon: Icons.search,
                              iconSize: 20.0,
                              onPressed: () {
                                print('Search');
                              },
                            ),
                            CircleButton(
                              radius: 35.0,
                              icon: MdiIcons.facebookMessenger,
                              iconSize: 20.0,
                              onPressed: () {
                                print('messenger');
                              },
                            ),
                          ],
                        )
                      : const SizedBox(),
                  SizedBox(
                    height: 55,
                    child: Stack(
                      children: [
                        Positioned(bottom: 2, left: 0, right: 0, child: Container(height: 3, color: Colors.grey.withOpacity(.3))),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            tabItem(MdiIcons.home, 0, dashboardProvider),
                            tabItem(Icons.groups, 1, dashboardProvider),
                            tabItem(Icons.account_circle_outlined, 2, dashboardProvider, isCircle: true),
                            tabItem(Icons.notifications, 3, dashboardProvider),
                            tabItem(Icons.menu, 4, dashboardProvider),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: PageView(
                      controller: controller,
                      onPageChanged: (page) {
                        dashboardProvider.changeSelectIndex(page);
                      },
                      children: [
                        HomeScreen(refreshController),
                        Container(),
                        ProfileScreen(),
                        Container(),
                        Container(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ));
    });
  }

  Widget tabItem(IconData iconData, int position, DashboardProvider dashboardProvider, {bool isCircle = false}) {
    return Expanded(
        child: InkWell(
      onTap: () {
        dashboardProvider.changeSelectIndex(position);
        controller.animateToPage(position, duration: Duration(seconds: 1), curve: Curves.easeOut);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          !isCircle
              ? Tab(
                  icon: Icon(iconData,
                      size: 30.0, color: dashboardProvider.selectIndex == position ? Colors.blue : Colors.grey.withOpacity(.8)))
              : Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: dashboardProvider.selectIndex == position ? Colors.blue : Colors.grey.withOpacity(.8), width: 2.0)),
                  child: Tab(
                      icon: Icon(iconData,
                          size: 25.0, color: dashboardProvider.selectIndex == position ? Colors.blue : Colors.grey.withOpacity(.8)))),
          Container(
            height: 3,
            margin: const EdgeInsets.only(bottom: 2),
            decoration: BoxDecoration(
                color: dashboardProvider.selectIndex == position ? Colors.blue : Colors.transparent,
                borderRadius: BorderRadius.circular(10)),
          )
        ],
      ),
    ));
  }
}
