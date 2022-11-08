import 'package:als_frontend/helper/number_helper.dart';
import 'package:als_frontend/old_code/const/palette.dart';
import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/provider/newsfeed_provider.dart';
import 'package:als_frontend/provider/notication_provider.dart';
import 'package:als_frontend/screens/notification/single_post_screen.dart';
import 'package:als_frontend/screens/notification/widget/notifications_card.dart';
import 'package:als_frontend/screens/profile/shimmer_effect/friend_req_shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  Future<void> _refresh(BuildContext context) async {
    Provider.of<NotificationProvider>(context, listen: false).initializeNotification(isFirstTimeLoading: false);
  }

  ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(() {
      if (controller.offset >= controller.position.maxScrollExtent &&
          !controller.position.outOfRange &&
          Provider.of<NotificationProvider>(context, listen: false).hasNextData) {
        Provider.of<NotificationProvider>(context, listen: false).updatePageNo();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<NotificationProvider>(context, listen: false).notificationRead();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Notifications",
          style: TextStyle(color: Palette.primary, fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: -1.2),
        ),
      ),
      body: Consumer<NotificationProvider>(
        builder: (context, notificationProvider, child) => RefreshIndicator(
            child: notificationProvider.isLoading
                ? const Center(child: FriendReqShimmerWidget())
                : ListView.builder(
                    shrinkWrap: true,
                    controller: controller,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(10),
                    itemCount: notificationProvider.notificationLists.length,
                    itemBuilder: ((context, index) {
                      return NotificationCard(
                        image: "${notificationProvider.notificationLists[index].actor!.profileImage}",
                        ontap: () {
                          List<String> noticeType = ['timeline', 'page', 'group'];
                          List<String> noticeType2 = ['friend'];
                          Provider.of<AuthProvider>(context, listen: false).getUserInfo();
                          if (noticeType.contains(notificationProvider.notificationLists[index].noticeType!.toLowerCase())) {
                            Get.to(() => SinglePostScreen(notificationProvider.notificationLists[index].url! + "comment/"));
                          }else if (noticeType2.contains(notificationProvider.notificationLists[index].noticeType!.toLowerCase())) {
                            Get.to(() => SinglePostScreen(notificationProvider.notificationLists[index].url! + "comment/"));
                          }  else {}

                        },
                        textColor: Colors.black,
                        likecmnt: "${notificationProvider.notificationLists[index].description}",
                        containerColor: (notificationProvider.notificationLists[index].isRead == false)
                            ? const Color.fromARGB(255, 175, 216, 243)
                            : Colors.white,
                        time: getDate(notificationProvider.notificationLists[index].timestamp!, context),
                      );
                    })),
            onRefresh: () {
              return _refresh(context);
            }),
      ),
    );
  }
}
