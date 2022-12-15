import 'dart:async';

import 'package:als_frontend/provider/chat_provider.dart';
import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:als_frontend/util/size.util.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

// ignore: must_be_immutable
class ChatInputField extends StatelessWidget {
  ChatInputField(this.controller, this.index, {this.customerID = 0, this.isFromProfile = false, Key? key}) : super(key: key);

  final AutoScrollController controller;
  final TextEditingController textEditingController = TextEditingController();

  final int index;
  final bool isFromProfile;
  final int customerID;
  bool hasConnection = false;
  late final prefs;


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
                        onTap: () {
                          controller.scrollToIndex(0, preferPosition: AutoScrollPosition.end);
                        },
                        controller: textEditingController,
                        decoration:  InputDecoration(hintText:LocaleKeys.type_message.tr(), border: InputBorder.none,enabledBorder: InputBorder.none),
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
                            onTap: () async{
                              bool result = await InternetConnectionChecker().hasConnection;
                              String userID = chatProvider.userID();
                              String message = textEditingController.text;
                              if(message.isEmpty){
                                Fluttertoast.showToast(
                                    msg: "Type a message",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                              }else{
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
