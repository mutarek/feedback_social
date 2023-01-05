import 'package:als_frontend/widgets/network_image.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NotificationCard extends StatelessWidget {
  NotificationCard(
      {required this.ontap,
      required this.textColor,
      required this.time,
      required this.image,
      required this.likecmnt,
      required this.containerColor,
      Key? key})
      : super(key: key);
  VoidCallback ontap;
  Color textColor;
  String time;

  String image;
  String likecmnt;
  Color containerColor;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: ontap,
      child: Container(
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: containerColor),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: circularImage(image, 35, 35),
                // CircleAvatar(backgroundColor: Colors.white, radius: height * 0.029, backgroundImage: NetworkImage(image)
                // ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Text(likecmnt, style: TextStyle(color: textColor)),
                    Padding(
                        padding: EdgeInsets.only(top: height * 0.01), child: Text(time, style: TextStyle(color: textColor, fontSize: 10)))
                  ],
                ),
              )
            ],
          )),
    );
  }
}
