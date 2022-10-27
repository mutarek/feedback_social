import 'dart:async';

import 'package:als_frontend/data/model/response/chat/AllMessageChatListModel.dart';
import 'package:als_frontend/provider/chat_provider.dart';
import 'package:als_frontend/util/size.util.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class ChatInputField extends StatelessWidget {
  ChatInputField(this.roomID, this.controller, this.model, this.index, {Key? key}) : super(key: key);
  final String roomID;
  final ScrollController controller;
  final TextEditingController textEditingController = TextEditingController();
  final AllMessageChatListModel model;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 32,
            color: Color(0xFF087949).withOpacity(0.08),
          ),
        ],
      ),
      child: Consumer<ChatProvider>(
        builder: (context, chatProvider, child) => Row(
          children: [
            Icon(Icons.mic, color: kPrimaryColor),
            SizedBox(width: kDefaultPadding),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding * 0.75,
                ),
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    Icon(Icons.sentiment_satisfied_alt_outlined, color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.64)),
                    SizedBox(width: kDefaultPadding / 4),
                    Expanded(
                      child: TextField(
                        controller: textEditingController,
                        decoration: InputDecoration(hintText: "Type message", border: InputBorder.none),
                      ),
                    ),
                    Icon(
                      Icons.attach_file,
                      color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.64),
                    ),
                    SizedBox(width: kDefaultPadding / 4),
                    chatProvider.sendMessageLoading
                        ? Center(child: CircularProgressIndicator())
                        : InkWell(
                            onTap: () {
                              String userID = chatProvider.userID();
                              String message = textEditingController.text;
                              chatProvider.addPost(userID, roomID, message, (int value) {
                                Timer(Duration(seconds: 1), () {
                                  controller.animateTo(controller.position.maxScrollExtent,
                                      duration: Duration(milliseconds: 250), curve: Curves.easeInOutCubic);
                                });
                              }, model, index);
                              textEditingController.clear();
                            },
                            child: Icon(Icons.send, color: kPrimaryColor)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
