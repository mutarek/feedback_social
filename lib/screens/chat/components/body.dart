import 'dart:async';

import 'package:als_frontend/provider/chat_provider.dart';
import 'package:als_frontend/util/size.util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import 'chat_input_field.dart';
import 'message.dart';

// ignore: must_be_immutable
class BodyWidget extends StatelessWidget {
  BodyWidget(this.controller, this.index, {this.customerID = 0, this.isFromProfile = false, required this.imageURL, Key? key})
      : super(key: key);

  final AutoScrollController controller;
  int status = 0;
  final int index;
  final bool isFromProfile;
  final int customerID;
  final String imageURL;

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(builder: (context, chatProvider, child) {
      if (status == 0 && !chatProvider.isLoading) {
        Timer(const Duration(seconds: 1), () {
          controller.animateTo(controller.position.maxScrollExtent,
              duration: const Duration(milliseconds: 250), curve: Curves.easeInOutCubic);
          status = 1;
        });
      }
      if (chatProvider.isChangeValue) {
        Timer(const Duration(milliseconds: 250), () {
          controller.scrollToIndex(0, preferPosition: AutoScrollPosition.begin);
        });
      }
      return Column(
        children: [
          Expanded(
            child: chatProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: ListView.builder(
                      controller: controller,
                      physics: const BouncingScrollPhysics(),
                      itemCount: chatProvider.p2pChatLists.length,
                      itemBuilder: (context, index) {
                        bool isSender =
                            chatProvider.userID().toLowerCase() == chatProvider.p2pChatLists[index].user!.toString() ? true : false;
                        return Message(
                          message: chatProvider.p2pChatLists[index],
                          isSender: isSender,
                          imageURL: imageURL,
                        );
                      },
                    ),
                  ),
          ),
          ChatInputField(controller, index, customerID: customerID, isFromProfile: isFromProfile),
        ],
      );
    });
  }
}
