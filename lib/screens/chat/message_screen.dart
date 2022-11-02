import 'dart:async';

import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/provider/chat_provider.dart';
import 'package:als_frontend/screens/profile/profile_screen.dart';
import 'package:als_frontend/screens/profile/public_profile_screen.dart';
import 'package:als_frontend/util/size.util.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
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
        viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom), axis: scrollDirection);
    if (widget.isFromProfile) {
    } else {

      Provider.of<ChatProvider>(context, listen: false).initializeP2PChats((bool status) {});
    }

    controller = AutoScrollController()
      ..addListener(() {
        if (controller.position.minScrollExtent == controller.position.pixels &&
            Provider.of<ChatProvider>(context, listen: false).hasNextData) {
          Provider.of<ChatProvider>(context, listen: false).updatePageNo((bool status) {
            if (status) {
              Timer(const Duration(seconds: 1), () {
                _scrollToIndex(0);
              });
            }
          });
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
          backgroundColor: Color(0xffFBFAFF),
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
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        children: [
          BackButton(
            onPressed: () {
              Provider.of<ChatProvider>(context, listen: false).channelDismiss();
              Navigator.of(context).pop();
            },
            color: Colors.black,
          ),
          CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.scaffold,
              child: CircleAvatar(radius: 17, backgroundImage: NetworkImage(widget.imageURL))),
          const SizedBox(width: kDefaultPadding * 0.75),
          Expanded(
            child: InkWell(
              onTap: () {
                if (!widget.isForGroup) {
                  if (Provider.of<AuthProvider>(context, listen: false).userID == widget.customerID.toString()) {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProfileScreen()));
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => PublicProfileScreen(widget.customerID.toString())));
                  }
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.name, style: const TextStyle(fontSize: 16, color: Colors.black)),
                  const Text("Active 3m ago", style: TextStyle(fontSize: 12, color: Colors.black))
                ],
              ),
            ),
          )
        ],
      ),
      actions: [
        IconButton(icon: const Icon(FontAwesomeIcons.phone, color: Colors.black), onPressed: () {}),
        IconButton(icon: const Icon(Icons.videocam, color: Colors.black), onPressed: () {}),
        const SizedBox(width: kDefaultPadding / 2),
      ],
    );
  }
}
