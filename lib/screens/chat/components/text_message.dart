import 'package:als_frontend/data/model/response/chat/chat_message_model.dart';
import 'package:als_frontend/helper/open_call_url_map_sms_helper.dart';
import 'package:als_frontend/helper/url_checkig_helper.dart';
import 'package:als_frontend/screens/chat/widget/any_link_preview_chat_widget.dart';
import 'package:als_frontend/util/size.util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({Key? key, this.message, this.isSender = false})
      : super(key: key);
  final bool isSender;
  final ChatMessageModel? message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding * 0.75, vertical: kDefaultPadding / 2),
      decoration: BoxDecoration(
        color: isSender ? const Color(0xffE12942) : const Color(0xffE8EDF1),
        borderRadius: isSender
            ? const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10))
            : const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10)),
      ),
      child: message!.text!.contains("http")
          ? Column(
              children: [
                MarkdownBody(
                  onTapLink: (text, href, title) {
                    href != null ? openNewLink(href) : null;
                  },
                  softLineBreak: true,
                  selectable: true,
                  data: message!.text!,
                  shrinkWrap: true,
                  styleSheet: MarkdownStyleSheet(
                      a: const TextStyle(fontSize: 12)),
                ),
                const SizedBox(height: 10,),
                AnyLinkPreviewChat(extractdescription(message!.text!))
              ],
            )
          : Text(message!.text!,
              style: TextStyle(
                  color: isSender ? Colors.white : const Color(0xff61656A))),
    );
  }
}
