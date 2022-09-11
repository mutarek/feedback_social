import 'package:als_frontend/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../../const/palette.dart';
import '../../provider/provider.dart';
import '../screens.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    final value = Provider.of<NotificationsProvider>(context, listen: false);
    value.getData();

    value.check();
    value.notificationRead();
    super.initState();
  }

  Future<void> _refresh() async {
    final data = Provider.of<NotificationsProvider>(context, listen: false);
    data.getData();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Consumer3<NotificationsProvider, PublicProfileDetailsProvider,
            SinglePostProvider>(
        builder: (context, provider, publicProfileProvider, singlePostProvider,
            child) {
      return RefreshIndicator(
        onRefresh: _refresh,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              elevation: 0,
              title: const Text(
                "FeedBack",
                style: TextStyle(
                    color: Palette.primary,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1.2),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    "Notifications",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: provider.data.length,
                      itemBuilder: ((context, index) {
                        return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: width * 0.02,
                                vertical: height * 0.001),
                            child: NotificationCard(
                              image:
                                  "${provider.data[index].actor!.profileImage}",
                              ontap: () {
                                provider.notificationId =
                                    provider.data[index].id;
                                provider.tappedOnNotification();

                                if (provider.data[index].verb ==
                                    "friend_request") {
                                  publicProfileProvider.id =
                                      provider.data[index].actor!.id!;
                                  publicProfileProvider.id = provider.data[index].actor!.id!;
                                  Get.to(
                                      () => const PublicProfileDetailsScreen());
                                }

                                if (provider.data[index].verb == "like" || provider.data[index].verb == "comment" || provider.data[index].verb == "post") {
                                  singlePostProvider.url =
                                      provider.data[index].url!;
                                  singlePostProvider.getUserData();
                                  Get.to(() => const SinglePostScreen());
                                }

                                _refresh();
                              },
                              textColor: Colors.black,
                              likecmnt: "${provider.data[index].description}",
                              containerColor:
                                  (provider.data[index].isRead == false)
                                      ? const Color.fromARGB(255, 175, 216, 243)
                                      : Colors.white,
                              time: "${provider.data[index].timestamp} ago",
                            ));
                      })),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
