import 'package:als_frontend/helper/open_call_url_map_sms_helper.dart';
import 'package:als_frontend/old_code/const/palette.dart';
import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/provider/dashboard_provider.dart';
import 'package:als_frontend/provider/newsfeed_provider.dart';
import 'package:als_frontend/screens/dashboard/page_or_group_decesion_group.dart';
import 'package:als_frontend/screens/home/home_screen.dart';
import 'package:als_frontend/screens/more/more_screen.dart';
import 'package:als_frontend/screens/profile/profile_screen.dart';
import 'package:als_frontend/util/image.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/circle_button.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

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
    Provider.of<AuthProvider>(context, listen: false).getUserInfo();
    Provider.of<NewsFeedProvider>(context, listen: false).initializeAllFeedData((bool status) {}, page: 1);
  }

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
          backgroundColor: Colors.white,
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {},
          //   backgroundColor: Colors.white,
          //   child: Icon(CupertinoIcons.add_circled, color: Colors.blue),
          // ),
          // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: Consumer<DashboardProvider>(
            builder: (context, dashboardProvider, child) => Container(
              height: 48,
              child: StylishBottomBar(
                items: [
                  AnimatedBarItems(
                      // icon: Icon(CupertinoIcons.home, color: dashboardProvider.selectIndex == 0 ? Colors.blue : Colors.grey),
                      icon: SvgPicture.asset(ImagesModel.homeURI,
                          color: dashboardProvider.selectIndex == 0 ? Colors.blue : Colors.grey, width: 22, height: 22),
                      selectedColor: Colors.blue,
                      title: Text('Home',
                          style: latoStyle600SemiBold.copyWith(
                              color: dashboardProvider.selectIndex == 0 ? Colors.blue : Colors.grey, fontSize: 12))),
                  AnimatedBarItems(
                      icon: SvgPicture.asset(ImagesModel.friendRequestURI,
                          color: dashboardProvider.selectIndex == 1 ? Colors.blue : Colors.grey, width: 22, height: 22),
                      selectedColor: Colors.blue,
                      title: Text('Group',
                          style: latoStyle600SemiBold.copyWith(
                              color: dashboardProvider.selectIndex == 1 ? Colors.blue : Colors.grey, fontSize: 12))),
                  AnimatedBarItems(
                      icon: SvgPicture.asset(ImagesModel.notificationURI,
                          color: dashboardProvider.selectIndex == 2 ? Colors.blue : Colors.grey, width: 22, height: 22),
                      selectedColor: Colors.blue,
                      title: Text('Notifications',
                          style: latoStyle600SemiBold.copyWith(
                              color: dashboardProvider.selectIndex == 2 ? Colors.blue : Colors.grey, fontSize: 12))),
                  AnimatedBarItems(
                      icon: SvgPicture.asset(ImagesModel.messageURI,
                          color: dashboardProvider.selectIndex == 3 ? Colors.blue : Colors.grey, width: 22, height: 22),
                      selectedColor: Colors.blue,
                      title: Text('Message',
                          style: latoStyle600SemiBold.copyWith(
                              color: dashboardProvider.selectIndex == 3 ? Colors.blue : Colors.grey, fontSize: 12))),
                  AnimatedBarItems(
                      icon: SvgPicture.asset(ImagesModel.menuURI,
                          color: dashboardProvider.selectIndex == 4 ? Colors.blue : Colors.grey, width: 22, height: 22),
                      backgroundColor: Colors.blue,
                      title: Text('More',
                          style: latoStyle600SemiBold.copyWith(
                              color: dashboardProvider.selectIndex == 4 ? Colors.blue : Colors.grey, fontSize: 12))),
                ],
                iconSize: 25,
                barAnimation: BarAnimation.fade,
                iconStyle: IconStyle.animated,
                hasNotch: true,
                opacity: 0.3,
                currentIndex: dashboardProvider.selectIndex,
                bubbleFillStyle: BubbleFillStyle.fill,
                onTap: (index) {
                  controller.animateToPage(index!, duration: const Duration(seconds: 1), curve: Curves.easeOut);
                  dashboardProvider.changeSelectIndex(index);
                },
              ),
            ),
          ),
          body: SafeArea(
            child: Consumer<DashboardProvider>(
              builder: (context, dashboardProvider, child) => Column(
                children: [
                  dashboardProvider.selectIndex == 0
                      ? AppBar(
                          title: CustomText(title: 'Feedback', color: Palette.primary, fontWeight: FontWeight.bold, fontSize: 27),
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
                                openFeedbackMessengerApp();
                              },
                            ),
                          ],
                        )
                      : const SizedBox(),
                  // SizedBox(
                  //   height: 55,
                  //   child: Stack(
                  //     children: [
                  //       Positioned(bottom: 2, left: 0, right: 0, child: Container(height: 3, color: Colors.grey.withOpacity(.3))),
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //         children: [
                  //           tabItem(MdiIcons.home, 0, dashboardProvider),
                  //           tabItem(Icons.groups, 1, dashboardProvider),
                  //           tabItem(Icons.account_circle_outlined, 2, dashboardProvider, isCircle: true),
                  //           tabItem(Icons.notifications, 3, dashboardProvider),
                  //           tabItem(Icons.menu, 4, dashboardProvider),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Expanded(
                    child: PageView(
                      controller: controller,
                      physics: const NeverScrollableScrollPhysics(),
                      onPageChanged: (page) {
                        dashboardProvider.changeSelectIndex(page);
                      },
                      children: [
                        HomeScreen(refreshController),
                        const PageOrGroupDecisionGroup(),
                        Container(),
                        const ProfileScreen(),
                        const MoreScreen(),
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
        controller.animateToPage(position, duration: const Duration(seconds: 1), curve: Curves.easeOut);
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
