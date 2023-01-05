import 'package:als_frontend/helper/open_call_url_map_sms_helper.dart';
import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/provider/dashboard_provider.dart';
import 'package:als_frontend/provider/newsfeed_provider.dart';
import 'package:als_frontend/provider/notication_provider.dart';
import 'package:als_frontend/provider/search_provider.dart';
import 'package:als_frontend/provider/splash_provider.dart';
import 'package:als_frontend/screens/chat/chats_screen.dart';
import 'package:als_frontend/screens/dashboard/friend_request_screen.dart';
import 'package:als_frontend/screens/home/home_screen.dart';
import 'package:als_frontend/screens/more/more_screen.dart';
import 'package:als_frontend/screens/notification/notification_screen.dart';
import 'package:als_frontend/screens/profile/profile_screen.dart';
import 'package:als_frontend/screens/search/search_screen.dart';
import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/image.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/circle_button.dart';
import 'package:als_frontend/widgets/custom_button.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:als_frontend/widgets/network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

    Provider.of<NewsFeedProvider>(context, listen: false).initializeAllFeedData(page: 1, isFirstTime: false);
    Provider.of<NotificationProvider>(context, listen: false).initializeNotification();
    Provider.of<NotificationProvider>(context, listen: false).notificationUnread();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer4<DashboardProvider, NotificationProvider, AuthProvider, SplashProvider>(
        builder: (context, dashboardProvider, notificationProvider, authProvider, splashProvider, child) => WillPopScope(
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
                            title: Text(LocaleKeys.home.tr(),
                                style: latoStyle600SemiBold.copyWith(
                                    color: dashboardProvider.selectIndex == 0 ? Colors.blue : Colors.grey, fontSize: 12))),
                        AnimatedBarItems(
                            icon: SvgPicture.asset(ImagesModel.friendRequestURI,
                                color: dashboardProvider.selectIndex == 1 ? Colors.blue : Colors.grey, width: 22, height: 22),
                            selectedColor: Colors.blue,
                            title: Text(LocaleKeys.friend.tr(),
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
                                                  '${notificationProvider.notificationCount > 9 ? LocaleKeys.nine_plus.tr() : notificationProvider.notificationCount}',
                                              color: Colors.white,
                                              fontSize: 9,
                                            ),
                                          ))
                              ],
                            ),
                            selectedColor: Colors.blue,
                            title: Text(LocaleKeys.notifications.tr(),
                                style: latoStyle600SemiBold.copyWith(
                                    color: dashboardProvider.selectIndex == 2 ? Colors.blue : Colors.grey, fontSize: 12))),
                        AnimatedBarItems(
                            icon: SvgPicture.asset(ImagesModel.chatingURI,
                                color: dashboardProvider.selectIndex == 3 ? Colors.blue : Colors.grey, width: 22, height: 22),
                            selectedColor: Colors.blue,
                            title: Text(LocaleKeys.message.tr(),
                                style: latoStyle600SemiBold.copyWith(
                                    color: dashboardProvider.selectIndex == 3 ? Colors.blue : Colors.grey, fontSize: 12))),
                        AnimatedBarItems(
                            icon: SvgPicture.asset(ImagesModel.menuURI,
                                color: dashboardProvider.selectIndex == 4 ? Colors.blue : Colors.grey, width: 22, height: 22),
                            backgroundColor: Colors.blue,
                            title: CustomText(
                              title: LocaleKeys.more.tr(),
                              textStyle: latoStyle600SemiBold.copyWith(
                                  color: dashboardProvider.selectIndex == 4 ? Colors.blue : Colors.grey, fontSize: 12),
                            )),
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
                                title: CustomText(
                                    title: LocaleKeys.feedback.tr(), color: AppColors.feedback, fontWeight: FontWeight.bold, fontSize: 27),
                                backgroundColor: Colors.white,
                                elevation: 0,
                                actions: [
                                  CircleButton(
                                    radius: 35.0,
                                    icon: Icons.search,
                                    iconSize: 20.0,
                                    onPressed: () {
                                      Provider.of<SearchProvider>(context, listen: false).resetFirstTime();
                                      Helper.toScreen(SearchScreen());
                                    },
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: () {
                                            Helper.toScreen(const ProfileScreen());
                                          },
                                          child: circularImage(authProvider.profileImage, 35, 35),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : AppBar(
                                title: CustomText(
                                    title: dashboardProvider.selectIndex == 1
                                        ? 'Friend'
                                        : dashboardProvider.selectIndex == 2
                                            ? 'Notifications'
                                            : dashboardProvider.selectIndex == 3
                                                ? 'Chats'
                                                : 'Feedback',
                                    color: AppColors.feedback,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 27),
                                backgroundColor: Colors.white,
                                elevation: 0,
                                actions: [
                                  dashboardProvider.selectIndex == 3
                                      ? CircleButton(
                                          radius: 35.0,
                                          icon: Icons.search,
                                          iconSize: 20.0,
                                          onPressed: () {
                                            Provider.of<SearchProvider>(context, listen: false).resetFirstTime();
                                            Helper.toScreen(SearchScreen());
                                          },
                                        )
                                      : const SizedBox.shrink(),
                                ],
                              ),
                        splashProvider.isLoading || splashProvider.value == -2 || splashProvider.value == 1
                            ? const SizedBox.shrink()
                            : splashProvider.value == 0
                                ? CustomButton(
                                    btnTxt: "Update available.",
                                    onTap: () {
                                      openFeedbackAppOnPlayStore();
                                    },
                                    backgroundColor: kErrorColor,
                                    textWhiteColor: true,
                                    radius: 0,
                                    fontSize: 13,
                                  )
                                : const CustomButton(
                                    btnTxt: 'Server Problems are found, and our maintainer working here please try sometime later. ',
                                    backgroundColor: AppColors.feedback,
                                    textWhiteColor: true,
                                    radius: 0,
                                    fontSize: 13,
                                  ),
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
                              FriendRequestSuggestionScreen(),
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
