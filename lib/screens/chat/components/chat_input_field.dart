import 'dart:async';

import 'package:als_frontend/provider/chat_provider.dart';
import 'package:als_frontend/util/size.util.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatInputField extends StatelessWidget {
  ChatInputField(this.controller, this.index, {this.customerID = 0, this.isFromProfile = false, Key? key}) : super(key: key);

  final ScrollController controller;
  final TextEditingController textEditingController = TextEditingController();

  final int index;
  final bool isFromProfile;
  final int customerID;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 32,
            color: const Color(0xFF087949).withOpacity(0.08),
          ),
        ],
      ),
      child: Consumer<ChatProvider>(
        builder: (context, chatProvider, child) => Row(
          children: [
            const Icon(Icons.mic, color: kPrimaryColor),
            const SizedBox(width: kDefaultPadding),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding * 0.75,
                ),
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    Icon(Icons.sentiment_satisfied_alt_outlined, color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.64)),
                    const SizedBox(width: kDefaultPadding / 4),
                    Expanded(
                      child: TextField(
                        controller: textEditingController,
                        decoration: const InputDecoration(hintText: "Type message", border: InputBorder.none),
                      ),
                    ),
                    Icon(
                      Icons.attach_file,
                      color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.64),
                    ),
                    const SizedBox(width: kDefaultPadding / 4),
                    chatProvider.sendMessageLoading
                        ? const Center(child: CircularProgressIndicator())
                        : InkWell(
                            onTap: () {
                              String userID = chatProvider.userID();
                              String message = textEditingController.text;
                              if (chatProvider.isOneTime && isFromProfile) {
                                chatProvider.createRoom(userID, customerID.toString(), message, index).then((value) {
                                  Timer(const Duration(seconds: 1), () {
                                    controller.animateTo(controller.position.maxScrollExtent,
                                        duration: const Duration(milliseconds: 250), curve: Curves.easeInOutCubic);
                                  });
                                });
                              } else {
                                chatProvider.addPost(userID, message, (int value) {
                                  Timer(const Duration(seconds: 1), () {
                                    controller.animateTo(controller.position.maxScrollExtent,
                                        duration: const Duration(milliseconds: 250), curve: Curves.easeInOutCubic);
                                  });
                                }, index);
                              }

                              textEditingController.clear();
                            },
                            child: const Icon(Icons.send, color: kPrimaryColor)),
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

