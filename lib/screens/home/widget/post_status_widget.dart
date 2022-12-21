import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/provider/post_provider.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:provider/provider.dart';

Widget postStatusWidget(BuildContext context, AuthProvider authProvider, PostProvider postProvider, bool isLoading, int status) {

  Provider.of<PostProvider>(context, listen: false).initializeNotificationSettings();
  Provider.of<PostProvider>(context, listen: false).showOneTimeNotification();
  return Container(
    padding: const EdgeInsets.only(left: 10, right: 10),
    height: 50,
    width: double.infinity,
    child: Card(
      child: Row(
        children: [
          ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5)), child: CachedNetworkImage(imageUrl: authProvider.profileImage)),
          const SizedBox(width: 10),

  Container(
  height: 15,
  width: 270,
  child: LiquidLinearProgressIndicator(
  value: postProvider.uploadPercent*100, // Defaults to 0.5.
  valueColor: AlwaysStoppedAnimation(AppColors.unreadColorLight), // Defaults to the current Theme's accentColor.
  backgroundColor: AppColors.scaffold,
  borderRadius: 40.0,
  direction: Axis.vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.horizontal.
  center: CustomText(title: "${(postProvider.uploadPercent * 100).toStringAsFixed(0)}%",color: Colors.white,),
  ),),

  Expanded(
    child: status == 1
        ? Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
            onPressed: () {},
            child: InkWell(
                onTap: () {
                  postProvider.disCardPost();
                },
                child: const Text('Discard'))),
        TextButton(
            onPressed: () {},
            child: InkWell(
                onTap: () {
                  postProvider.addPost(postProvider.body);
                },
                child: const Text('Retry')))
      ],
    )
        : const Text(''),
  ),
        ],
      ),
    ),
  );
}