
import 'package:als_frontend/data/model/response/chat/ChatMessageModel.dart';
import 'package:als_frontend/util/size.util.dart';
import 'package:flutter/material.dart';


class TextMessage extends StatelessWidget {
  const TextMessage({Key? key, this.message, this.isSender = false}) : super(key: key);
  final bool isSender;
  final ChatMessageModel? message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding * 0.75, vertical: kDefaultPadding / 2),
      decoration: BoxDecoration(color: isSender ? const Color(0xffE12942):const Color(0xffE8EDF1),
          borderRadius: isSender?const BorderRadius.only(topLeft: Radius.circular(10),topRight:  Radius.circular(10),bottomLeft:  Radius.circular(10)):const BorderRadius.only(topLeft: Radius.circular(10),topRight:  Radius.circular(10),bottomRight:  Radius.circular(10)),),
      child: Text(message!.text!, style: TextStyle(color: isSender ? Colors.white : const Color(0xff61656A))),
    );
  }
}
