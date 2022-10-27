import 'dart:async';

import 'package:als_frontend/data/model/response/chat/AllMessageChatListModel.dart';
import 'package:als_frontend/provider/chat_provider.dart';
import 'package:als_frontend/util/size.util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import 'components/body.dart';

class MessagesScreen extends StatefulWidget {
  final AllMessageChatListModel chatModels;
  final int index;

  MessagesScreen(this.chatModels, this.index);

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

    Provider.of<ChatProvider>(context, listen: false).initializeSocket(widget.chatModels, widget.index);
    Provider.of<ChatProvider>(context, listen: false).initializeP2PChats(widget.chatModels.id!, (bool status) {});
  }

  Future _scrollToIndex(int index) async {
    controller.scrollToIndex(index, preferPosition: AutoScrollPosition.begin);
  }

  @override
  Widget build(BuildContext context) {
    controller = AutoScrollController()
      ..addListener(() {
        if (controller.position.minScrollExtent == controller.position.pixels &&
            Provider.of<ChatProvider>(context, listen: false).hasNextMessage) {
          Provider.of<ChatProvider>(context, listen: false).updatePageNo(widget.chatModels.id!, (bool status) {
            if (status) {
              Timer(const Duration(seconds: 1), () {
                _scrollToIndex(0);
              });
            }
          });
        }
      });

    return WillPopScope(
      onWillPop: () {
        Provider.of<ChatProvider>(context, listen: false).channelDismiss();
        Navigator.of(context).pop();
        return Future.value(true);
      },
      child: Scaffold(appBar: buildAppBar(), body: Body(widget.chatModels.id!, controller, widget.chatModels, widget.index)),
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
              backgroundImage: NetworkImage(
                  widget.chatModels.roomType == "G" ? widget.chatModels.chatGroup!.avatar! : widget.chatModels.users![0].profileImage!)),
          const SizedBox(width: kDefaultPadding * 0.75),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.chatModels.roomType == "G" ? widget.chatModels.chatGroup!.name! : widget.chatModels.users![0].fullName!,
                    style: const TextStyle(fontSize: 16, color: Colors.black)),
                const Text("Active 3m ago", style: TextStyle(fontSize: 12, color: Colors.black))
              ],
            ),
          )
        ],
      ),
      actions: [
        IconButton(icon: const Icon(Icons.local_phone,color: Colors.black), onPressed: () {}),
        IconButton(icon: const Icon(Icons.videocam,color: Colors.black), onPressed: () {}),
        const SizedBox(width: kDefaultPadding / 2),
      ],
    );
  }
}
