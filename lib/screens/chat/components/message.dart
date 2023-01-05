import 'package:als_frontend/data/model/response/chat/chat_message_model.dart';
import 'package:als_frontend/screens/chat/components/text_message.dart';
import 'package:als_frontend/screens/chat/enum/enum.dart';
import 'package:als_frontend/util/size.util.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/widgets/network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class Message extends StatelessWidget {
  const Message({Key? key, required this.imageURL, required this.message, required this.isSender}) : super(key: key);
  final bool isSender;
  final ChatMessageModel message;
  final String imageURL;
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
            circularImage(imageURL,40,40),
            // CircleAvatar(
            //   radius: 15,
            //   backgroundColor: kPrimaryColor,
            //   backgroundImage: NetworkImage(imageURL),
            // ),
            const SizedBox(width: kDefaultPadding / 2),
          ],
          messageContaint(message),
          if (isSender) const MessageStatusDot(status: MessageStatus.viewed)
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

    return Padding(
      padding: const EdgeInsets.only(top: 15,left: 10),
      child: Icon(
        status == MessageStatus.notSent ? Icons.close : FontAwesomeIcons.checkDouble,
        size: 8,
        color: status == MessageStatus.notSent ? Colors.red: Colors.green,
      ),
    );
  }
}
