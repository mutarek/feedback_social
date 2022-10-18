import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/provider/newsfeed_provider.dart';
import 'package:als_frontend/screens/posts/add_post_screen.dart';
import 'package:als_frontend/screens/profile/profile_screen.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget createPostWidget(BuildContext context, AuthProvider authProvider,
    {NewsFeedProvider? newsFeedProvider, bool isForGroup = false, int groupID = 0}) {
  return InkWell(
    onTap: () async {
      var result = await Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => AddPostScreen(authProvider.profileImage, isFromGroupScreen: isForGroup, groupID: groupID)));


    },
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(.1), blurRadius: 10.0, spreadRadius: 3.3, offset: const Offset(0.0, 0.0))],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProfileScreen()));
                  },
                  child:
                      CircleAvatar(backgroundImage: NetworkImage(authProvider.profileImage), backgroundColor: Colors.grey.withOpacity(.4)),
                ),
                const SizedBox(width: 5),
                CustomText(
                    title: 'Write Somethings',
                    textStyle: latoStyle400Regular.copyWith(fontWeight: FontWeight.w300, fontSize: 13, color: Colors.grey.withOpacity(.8))),
                const SizedBox(width: 5),
                Icon(Icons.mode_edit_outline_outlined, size: 20, color: Colors.grey.withOpacity(.8)),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.blue.withOpacity(.1),
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.photo_camera_back, size: 20, color: Colors.grey),
                            const SizedBox(width: 5),
                            CustomText(title: 'Photo', textStyle: latoStyle700Bold.copyWith()),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(CupertinoIcons.video_camera, size: 28, color: Colors.grey),
                            const SizedBox(width: 5),
                            CustomText(title: 'Video', textStyle: latoStyle700Bold.copyWith()),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.calendar_month, size: 20, color: Colors.grey),
                            const SizedBox(width: 5),
                            CustomText(title: 'Event', textStyle: latoStyle700Bold.copyWith()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 50,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(.3), borderRadius: const BorderRadius.only(bottomRight: Radius.circular(10))),
                  child: const Icon(Icons.send, color: Color(0xff031765)),
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}
