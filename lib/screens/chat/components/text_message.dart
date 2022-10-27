
import 'package:als_frontend/data/model/response/chat/ChatMessageModel.dart';
import 'package:als_frontend/util/size.util.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:flutter/material.dart';


class TextMessage extends StatelessWidget {
  const TextMessage({Key? key, this.message, this.isSender = false}) : super(key: key);
  final bool isSender;
  final ChatMessageModel? message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding * 0.75, vertical: kDefaultPadding / 2),
      decoration: BoxDecoration(color: kPrimaryColor.withOpacity(isSender ? 1 : 0.1), borderRadius: BorderRadius.circular(30)),
      child: Text(message!.text!, style: TextStyle(color: isSender ? Colors.white : Theme.of(context).textTheme.bodyText1!.color)),
    );
  }
}
