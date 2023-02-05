import 'package:als_frontend/provider/post_provider.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:provider/provider.dart';

Widget postStatusWidget(BuildContext context) {
  Provider.of<PostProvider>(context, listen: false).initializeNotificationSettings();

  return Consumer<PostProvider>(
      builder: (context, postProvider, child) => Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            height: 45,
            margin: const EdgeInsets.symmetric(vertical: 2),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                boxShadow: [BoxShadow(color: colorText.withOpacity(.1), blurRadius: 13.0, spreadRadius: 3.0, offset: const Offset(0.0, 0.0))]),
            child: Row(
              children: [
                CustomText(title: 'Post Creating...', textStyle: robotoStyle700Bold),
                const SizedBox(width: 20),
                postProvider.status == 1
                    ? const SizedBox()
                    : Expanded(
                        child: SizedBox(
                          height: 25,
                          child: LiquidLinearProgressIndicator(
                            value: postProvider.uploadPercent,
                            valueColor: const AlwaysStoppedAnimation(colorText),
                            backgroundColor: Colors.green,
                            borderRadius: 40.0,
                            direction: Axis.vertical,
                            center: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3),
                              child: CustomText(
                                title: "${(postProvider.uploadPercent * 100).toStringAsFixed(0)}%",
                                color: postProvider.uploadPercent < 0.2
                                    ? Colors.white.withOpacity(.7)
                                    : postProvider.uploadPercent < 0.4
                                        ? Colors.white.withOpacity(.9)
                                        : postProvider.uploadPercent < 0.5
                                            ? Colors.white
                                            : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                postProvider.status == 1
                    ? Expanded(
                        child: Row(
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
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ));
}
