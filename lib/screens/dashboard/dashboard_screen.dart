import 'package:als_frontend/old_code/const/palette.dart';
import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/provider/dashboard_provider.dart';
import 'package:als_frontend/provider/newsfeed_provider.dart';
import 'package:als_frontend/provider/notication_provider.dart';
import 'package:als_frontend/provider/search_provider.dart';
import 'package:als_frontend/screens/chat/chats_screen.dart';
import 'package:als_frontend/screens/dashboard/page_or_group_decesion_group.dart';
import 'package:als_frontend/screens/home/home_screen.dart';
import 'package:als_frontend/screens/more/more_screen.dart';
import 'package:als_frontend/screens/notification/notification_screen.dart';
import 'package:als_frontend/screens/profile/profile_screen.dart';
import 'package:als_frontend/screens/search/search_screen.dart';
import 'package:als_frontend/util/image.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/circle_button.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:als_frontend/widgets/network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final PageController controller = PageController();

  @override
  void initState() {
    super.initState();

    Provider.of<NewsFeedProvider>(context, listen: false).initializeAllFeedData(page: 1);
    Provider.of<NotificationProvider>(context, listen: false).initializeNotification();
  }

  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer3<DashboardProvider, NotificationProvider, AuthProvider>(
        builder: (context, dashboardProvider, notificationProvider, authProvider, child) => WillPopScope(
              onWillPop: () async {
                if (dashboardProvider.selectIndex != 0) {
                  controller.jumpToPage(0);
                  return false;
                } else {
                  if (dashboardProvider.backButtonPressCount >= 2) {
                    return true;
                  } else {
                    Provider.of<NewsFeedProvider>(context, listen: false).initializeAllFeedData(page: 1, isFirstTime: false);
                    dashboardProvider.incrementBackButtonPressCount();
                    return false;
                  }
                }
              },
              child: Scaffold(
                  backgroundColor: Colors.white,
                  bottomNavigationBar: SizedBox(
                    height: 48,
                    child: StylishBottomBar(
                      items: [
                        AnimatedBarItems(
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
                            icon: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                SvgPicture.asset(ImagesModel.notificationURI,
                                    color: dashboardProvider.selectIndex == 2 ? Colors.blue : Colors.grey, width: 22, height: 22),
                                Positioned(
                                    right: -15,
                                    top: -3,
                                    child: notificationProvider.notificationCount == 0
                                        ? const SizedBox.shrink()
                                        : CircleAvatar(
                                            radius: 10,
                                            backgroundColor: AppColors.redColor,
                                            child: CustomText(
                                              title:
                                                  '${notificationProvider.notificationCount > 9 ? "9+" : notificationProvider.notificationCount}',
                                              color: Colors.white,
                                              fontSize: 9,
                                            ),
                                          ))
                              ],
                            ),
                            selectedColor: Colors.blue,
                            title: Text('Notifications',
                                style: latoStyle600SemiBold.copyWith(
                                    color: dashboardProvider.selectIndex == 2 ? Colors.blue : Colors.grey, fontSize: 12))),
                        AnimatedBarItems(
                            icon: SvgPicture.asset(ImagesModel.chatingURI,
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
                  body: SafeArea(
                    child: Column(
                      children: [
                        dashboardProvider.selectIndex == 0
                            ? AppBar(
                                title: CustomText(title: 'Feedback', color: Palette.feedback, fontWeight: FontWeight.bold, fontSize: 27),
                                backgroundColor: Colors.white,
                                elevation: 0,
                                actions: [
                                  CircleButton(
                                    radius: 35.0,
                                    icon: Icons.search,
                                    iconSize: 20.0,
                                    onPressed: () {
                                      Provider.of<SearchProvider>(context, listen: false).resetFirstTime();
                                      Get.to(SearchScreen());
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () {
                                        Get.to(const ProfileScreen());
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(2),
                                        width: 40,
                                        height: 30,
                                        decoration: const BoxDecoration(color: AppColors.scaffold, shape: BoxShape.circle),
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.circular(30),
                                            child: customNetworkImage2(context, authProvider.profileImage, height: 30)),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : const SizedBox(),
                        Expanded(
                          child: PageView(
                            controller: controller,
                            physics: const NeverScrollableScrollPhysics(),
                            onPageChanged: (page) {
                              if (page != 0) {
                                dashboardProvider.resetBackButtonPress();
                              }
                              dashboardProvider.changeSelectIndex(page);
                            },
                            children: const [
                              HomeScreen(),
                              PageOrGroupDecisionGroup(),
                              NotificationScreen(),
                              ChatsScreen(),
                              MoreScreen(),
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
            ));
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
