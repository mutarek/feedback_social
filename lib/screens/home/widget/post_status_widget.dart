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
          status == 1
              ? const SizedBox()
              : SizedBox(
                  height: 25,
                  width: 270,
                  child: LiquidLinearProgressIndicator(
                    value: postProvider.uploadPercent,
                    valueColor: const AlwaysStoppedAnimation(AppColors.unreadColorLight),
                    backgroundColor: AppColors.scaffold,
                    borderRadius: 40.0,
                    direction: Axis.vertical,
                    center: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: CustomText(
                        title: "${(postProvider.uploadPercent * 100).toStringAsFixed(0)}%",
                        color: postProvider.uploadPercent < 0.2
                            ? Colors.green.withOpacity(.7)
                            : postProvider.uploadPercent < 0.4
                                ? Colors.green.withOpacity(.9)
                                : postProvider.uploadPercent < 0.5
                                    ? Colors.green
                                    : Colors.white,
                      ),
                    ),
                  ),
                ),
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
