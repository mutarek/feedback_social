import 'package:als_frontend/data/model/response/chat/all_message_chat_list_model.dart';
import 'package:als_frontend/helper/date_converter.dart';
import 'package:als_frontend/util/size.util.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/widgets/network_image.dart';
import 'package:flutter/material.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({Key? key, required this.chat, required this.press}) : super(key: key);

  final AllMessageChatListModel chat;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: 7),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(.05), blurRadius: 10.0, spreadRadius: 1.0, offset: const Offset(0.0, 0.0))
        ]),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: AppColors.facebookColor,
              child: circularImage(chat.users![0].profileImage!, 48, 48),
            ),
            // CircleAvatar(
            //   radius: 26,
            //   backgroundColor: AppColors.facebookColor,
            //   child: CircleAvatar(radius: 24, backgroundImage: CachedNetworkImageProvider(chat.users![0].profileImage!)),
            // ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(chat.users![0].fullName!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8),
                    Opacity(
                        opacity: 0.64,
                        child: Text(chat.lastSms!.isEmpty ? "" : chat.lastSms.toString(), maxLines: 1, overflow: TextOverflow.ellipsis)),
                  ],
                ),
              ),
            ),
            Opacity(opacity: 0.64, child: Text(DateConverter.isoStringToLocalTimeOnly(chat.updateAt!))),
          ],
        ),
      ),
    );
  }
}
