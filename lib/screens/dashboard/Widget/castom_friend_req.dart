import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/network_image.dart';
import 'package:flutter/material.dart';

class FriendRequestWidget extends StatelessWidget {
  final double width;
  final String userName;
  final String firstButtonName;
  final String secondButtonName;
  final VoidCallback firstButtonOnTab;
  final VoidCallback secondButtonOnTab;
  final VoidCallback gotoProfileScreen;
  final Color firstButtonColor;
  final String imgUrl;

  const FriendRequestWidget({Key? key,
    required this.width,
    required this.userName,
    required this.firstButtonName,
    required this.secondButtonName,
    required this.firstButtonOnTab,
    required this.secondButtonOnTab,
    required this.gotoProfileScreen,
    required this.firstButtonColor,
    required this.imgUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        width: width,
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.grey.withOpacity(.2), blurRadius: 10.0, spreadRadius: 3.0, offset: const Offset(0.0, 0.0))],
            borderRadius: BorderRadius.circular(8),
            color: AppColors.whiteColorLight),
        child: Row(
          children: [
            SizedBox(width: width * 0.02),
            InkWell(
              onTap: gotoProfileScreen,
              child: CircleAvatar(radius: width * 0.07, backgroundColor: AppColors.scaffold, backgroundImage: NetworkImage(imgUrl)),
            ),
            SizedBox(width: width * 0.02),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(userName, style: latoStyle800ExtraBold),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: firstButtonColor),
                              onPressed: firstButtonOnTab,
                              child: Text(firstButtonName))),
                      const SizedBox(width: 10),
                      Expanded(
                          flex: 1,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.red.withOpacity(0.7)),
                              onPressed: secondButtonOnTab,
                              child: Text(secondButtonName))),
                      const SizedBox(width: 10),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
