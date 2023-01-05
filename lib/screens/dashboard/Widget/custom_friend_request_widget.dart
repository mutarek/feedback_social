import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/widgets/network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomFriendRequestWidget extends StatelessWidget {
  final String userName;
  final VoidCallback cancelButtonTap;
  final VoidCallback confirmButtonTap;
  final VoidCallback gotoProfileScreen;
  final String imgUrl;

  const CustomFriendRequestWidget({
    Key? key,
    required this.userName,
    required this.cancelButtonTap,
    required this.confirmButtonTap,
    required this.gotoProfileScreen,
    required this.imgUrl,

  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
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
            Expanded(
              flex: 1,
              // TODO: change it
              child: InkWell(
                onTap: gotoProfileScreen,
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child:    circularImage(imgUrl,40,40),
                  // CircleAvatar(
                  //     radius: width * 0.07,
                  //     backgroundColor: AppColors.scaffold,
                  //     backgroundImage: NetworkImage(imgUrl)),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(userName, style: const TextStyle(fontSize: 12)),
            ),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: cancelButtonTap,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border.all(width: 1,color: Colors.blueGrey),
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child:  Center(
                                child: Text(
                                  LocaleKeys.cancel.tr(),
                                  style: const TextStyle(color: Colors.blue,fontSize: 15,fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),),
                      const SizedBox(width: 10),
                      Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: confirmButtonTap,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border.all(width: 1,color: Colors.blueGrey),
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child:  Center(
                                child: Text(
                                  LocaleKeys.confirm.tr(),
                                  style: const TextStyle(color: Colors.blue,fontSize: 15,fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),),
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
