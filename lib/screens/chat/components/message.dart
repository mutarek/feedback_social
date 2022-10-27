import 'package:als_frontend/data/model/response/chat/ChatMessageModel.dart';
import 'package:als_frontend/screens/chat/components/text_message.dart';
import 'package:als_frontend/screens/chat/enum/enum.dart';
import 'package:als_frontend/util/size.util.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:flutter/material.dart';


class Message extends StatelessWidget {
  const Message({Key? key, required this.message, required this.isSender}) : super(key: key);
  final bool isSender;
  final ChatMessageModel message;

  @override
  Widget build(BuildContext context) {
    Widget messageContaint(ChatMessageModel message) {
      return TextMessage(message: message, isSender: isSender);
    }
    // @override
    // Widget build(BuildContext context) {
    //   Widget messageContaint(ChatMessage message) {
    //     switch (message.messageType) {
    //       case ChatMessageType.text:
    //         return TextMessage(message: message);
    //       case ChatMessageType.audio:
    //         return AudioMessage(message: message);
    //       case ChatMessageType.video:
    //         return VideoMessage();
    //       default:
    //         return SizedBox();
    //     }
    //   }

    return Padding(
      padding: const EdgeInsets.only(
        top: kDefaultPadding,
      ),
      child: Row(
        mainAxisAlignment: isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isSender) ...[
            CircleAvatar(
              radius: 12,
              backgroundColor: kPrimaryColor,
              backgroundImage: AssetImage("assets/logo/profile_pic.jpg"),
            ),
            SizedBox(width: kDefaultPadding / 2),
          ],
          messageContaint(message),
          if (isSender) MessageStatusDot(status: MessageStatus.viewed)
        ],
      ),
    );
  }
}

class MessageStatusDot extends StatelessWidget {
  final MessageStatus? status;

  const MessageStatusDot({Key? key, this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color dotColor(MessageStatus status) {
      switch (status) {
        case MessageStatus.not_sent:
          return kErrorColor;
        case MessageStatus.not_view:
          return Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.1);
        case MessageStatus.viewed:
          return kPrimaryColor;
        default:
          return Colors.transparent;
      }
    }

    return Container(
      margin: EdgeInsets.only(left: kDefaultPadding / 2),
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        color: dotColor(status!),
        shape: BoxShape.circle,
      ),
      child: Icon(
        status == MessageStatus.not_sent ? Icons.close : Icons.done,
        size: 8,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}
