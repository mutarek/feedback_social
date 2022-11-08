
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/network_image.dart';
import 'package:flutter/material.dart';

class FriendReqWidget extends StatelessWidget {


double height;
double width;
String userName;
String fastButtunName;
String seconButunName;
VoidCallback fastButton;
VoidCallback secondButton;
VoidCallback gotoProfileScreen;
Color fastbuttunColor;
String imgUrl;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        height: height * 0.09,
        width: width,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(.2),
                  blurRadius: 10.0,
                  spreadRadius: 3.0,
                  offset: const Offset(0.0, 0.0))
            ],
            borderRadius: BorderRadius.circular(8),
            color: AppColors.whiteColorLight),
        child: Row(
          children: [
            SizedBox(
              width: width * 0.02,
            ),
            InkWell(
              onTap: gotoProfileScreen,
              child: CircleAvatar(
                radius: width * 0.07,
                backgroundColor: AppColors.scaffold,
               backgroundImage: NetworkImage(imgUrl),
              ),
            ),
            SizedBox(
              width: width * 0.02,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.005,
                  ),
                  Text(
                    userName,
                    style: latoStyle800ExtraBold,
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: fastbuttunColor),
                              onPressed: fastButton,
                              child: Text(fastButtunName))),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          flex: 1,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                  Colors.red.withOpacity(0.7)),
                              onPressed: secondButton,
                              child: Text(seconButunName))),
                      SizedBox(
                        width: 10,
                      ),
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

FriendReqWidget({
  required this.height,
  required this.width,
  required this.userName,
  required this.fastButtunName,
  required this.seconButunName,
  required   this.fastButton,
  required this.secondButton,
  required this.gotoProfileScreen,
  required this.fastbuttunColor,
  required this.imgUrl,

});
}
