import 'dart:async';

import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/provider/chat_provider.dart';
import 'package:als_frontend/screens/profile/profile_screen.dart';
import 'package:als_frontend/screens/profile/public_profile_screen.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import 'components/body.dart';

class MessagesScreen extends StatefulWidget {
  final int index;
  final bool isFromProfile;
  final int customerID;
  final String name;
  final String imageURL;
  final bool isForGroup;

  const MessagesScreen(
      {required this.name,
      required this.imageURL,
      this.index = 0,
      this.customerID = 0,
      this.isFromProfile = false,
      this.isForGroup = false,
      Key? key})
      : super(key: key);

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final scrollDirection = Axis.vertical;

  late AutoScrollController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: scrollDirection);
    if (widget.isFromProfile) {
      Provider.of<ChatProvider>(context, listen: false).initializeP2PChats(
          (bool status) {},
          isFromChatTwoUser: true,
          userID: widget.customerID);
    } else {
      Provider.of<ChatProvider>(context, listen: false)
          .initializeP2PChats((bool status) {});
    }

    controller = AutoScrollController()
      ..addListener(() {
        if (controller.position.minScrollExtent == controller.position.pixels &&
            Provider.of<ChatProvider>(context, listen: false).hasNextData) {
          Provider.of<ChatProvider>(context, listen: false).updatePageNo(
              (bool status) {
            if (status) {
              Timer(const Duration(seconds: 1), () {
                _scrollToIndex(0);
              });
            }
          }, isFromChatTwoUser: true, userID: widget.customerID);
        }
      });
  }

  Future _scrollToIndex(int index) async {
    controller.scrollToIndex(index, preferPosition: AutoScrollPosition.begin);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Provider.of<ChatProvider>(context, listen: false).channelDismiss();
        Navigator.of(context).pop();
        return Future.value(true);
      },
      child: Scaffold(
          backgroundColor: const Color(0xffFBFAFF),
          appBar: buildAppBar(),
          body: BodyWidget(
            controller,
            widget.index,
            customerID: widget.customerID,
            isFromProfile: widget.isFromProfile,
            imageURL: widget.imageURL,
          )),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.scaffold,
              child: CircleAvatar(
                  radius: 18,
                  backgroundImage:
                      CachedNetworkImageProvider(widget.imageURL))),
          const SizedBox(width: 7),
          Expanded(
            child: InkWell(
              onTap: () {
                if (!widget.isForGroup) {
                  if (Provider.of<AuthProvider>(context, listen: false)
                          .userID ==
                      widget.customerID.toString()) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const ProfileScreen()));
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) =>
                            PublicProfileScreen(widget.customerID.toString())));
                  }
                }
              },
              child: CustomText(
                  title: widget.name,
                  textStyle:
                      latoStyle500Medium.copyWith(fontWeight: FontWeight.w600)),
            ),
          )
        ],
      ),
      leadingWidth: 40,
      leading: IconButton(
        icon: const Icon(FontAwesomeIcons.arrowLeft,
            color: kPrimaryColor, size: 20),
        onPressed: () {
          Provider.of<ChatProvider>(context, listen: false).channelDismiss();
          Navigator.of(context).pop();
        },
      ),
      actions: [
        Icon(FontAwesomeIcons.phone, color: kPrimaryColor, size: 20),
        SizedBox(width: 15),
        Icon(FontAwesomeIcons.video, color: kPrimaryColor, size: 20),
        SizedBox(width: 15),
      ],
    );
  }
}
