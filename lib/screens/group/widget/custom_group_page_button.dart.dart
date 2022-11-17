import 'package:als_frontend/util/palette.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomPageGroupButton extends StatelessWidget {
  const CustomPageGroupButton({
    Key? key,
    required this.goToGroupOrPage,
    required this.groupOrPageImage,
    required this.groupOrPageName,
    required this.groupOrPageLikes,
    required this.onTap,
  }) : super(key: key);
  final VoidCallback goToGroupOrPage;
  final String groupOrPageImage;
  final String groupOrPageName;
  final String groupOrPageLikes;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: goToGroupOrPage,
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), color: Colors.white, boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(.1), blurRadius: 15.0, spreadRadius: 3.0)
        ]),
        child: InkWell(
          onTap: onTap,
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Palette.notificationColor,
                child: CircleAvatar(
                  radius: 24,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: CachedNetworkImage(
                      imageUrl: groupOrPageImage,
                      fit: BoxFit.fill,
                      height: height == 0 ? MediaQuery.of(context).size.height : height,
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                      placeholder: ((context, url) => Container(alignment: Alignment.center, child: const CupertinoActivityIndicator())),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(title: groupOrPageName, textStyle: latoStyle400Regular.copyWith(fontSize: 15, color: Palette.primary)),
                      CustomText(
                          title: groupOrPageLikes.toString(),
                          textStyle: latoStyle300Light.copyWith(fontSize: 15, color: Palette.timeColor)),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
