import 'package:als_frontend/data/model/response/news_feed_model.dart';
import 'package:als_frontend/provider/comment_provider.dart';
import 'package:als_frontend/screens/post/widget/post_widget.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/image.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:als_frontend/widgets/network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void likeModalBottomSheet(NewsFeedModel newsfeedData, {bool isFromImage = false, int index = 0}) {
  showModalBottomSheet<void>(
    enableDrag: true,
    isScrollControlled: true,
    context: Helper.navigatorKey.currentState!.context,
    builder: (BuildContext context) {
      return Card(
        color: Colors.white,
        child: Consumer<CommentProvider>(
          builder: (context, commentProvider, child) => SizedBox(
            height: MediaQuery.of(context).size.height*0.95  + MediaQuery.of(context).viewInsets.bottom,
            child: Column(
              children: [
                CustomText(title: 'Reactions', textStyle: robotoStyle600SemiBold.copyWith(fontSize: 16)),
                Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.only(top: 10, bottom: 5),
                  decoration: BoxDecoration(color: colorText.withOpacity(.1), borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      reactionButton(
                          'All',
                          isFromImage ? newsfeedData.images![index].totalReaction! as int : newsfeedData.totalReaction! as int,
                          () {},
                          Colors.transparent,
                          0,
                          commentProvider,
                          isIcons: false),
                      reactionButton(ImagesModel.likeIconsSvg,
                          isFromImage ? newsfeedData.images![index].totalLiked! as int : newsfeedData.totalLiked! as int, () {
                        commentProvider
                            .initializeLikeListsData(isFromImage ? newsfeedData.images![index].likeReactUrl! : newsfeedData.likeReactUrl!);
                      }, AppColors.primaryColorLight, 1, commentProvider),
                      reactionButton(ImagesModel.loveIcons,
                          isFromImage ? newsfeedData.images![index].totalLoved! as int : newsfeedData.totalLoved! as int, () {
                        commentProvider
                            .initializeLikeListsData(isFromImage ? newsfeedData.images![index].loveReactUrl! : newsfeedData.loveReactUrl!);
                      }, Colors.red, 2, commentProvider),
                      reactionButton(
                          ImagesModel.hahaIcons, isFromImage ? newsfeedData.images![index].totalSad! as int : newsfeedData.totalSad! as int,
                          () {
                        commentProvider
                            .initializeLikeListsData(isFromImage ? newsfeedData.images![index].sadReactUrl! : newsfeedData.sadReactUrl!);
                      }, Colors.yellow, 3, commentProvider),
                    ],
                  ),
                ),
                commentProvider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: commentProvider.authorList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [BoxShadow(color: colorText.withOpacity(.06), blurRadius: 10.0, spreadRadius: 3.0)],
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              children: [
                                circularImage(commentProvider.authorList[index].profileImage!, 35, 35),
                                const SizedBox(width: 10),
                                CustomText(
                                  title: commentProvider.authorList[index].fullName!,
                                  textStyle: robotoStyle500Medium.copyWith(fontSize: 16),
                                )
                              ],
                            ),
                          );
                        })
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget reactionButton(
    String urlOrText, int count, GestureTapCallback gestureDetector, Color color, int status, CommentProvider commentProvider,
    {bool isIcons = true}) {
  return Expanded(
    child: Container(
      decoration: BoxDecoration(
          color: commentProvider.likeMenuCount == status ? colorText : Colors.transparent, borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          commentProvider.changeLikeMenu(status);
          gestureDetector();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isIcons
                ? reactWidget(urlOrText, commentProvider.likeMenuCount == status ? Colors.grey : color)
                : CustomText(
                    title: urlOrText,
                    textStyle: robotoStyle700Bold.copyWith(
                        fontSize: 14, color: commentProvider.likeMenuCount == status ? Colors.white : colorText)),
            const SizedBox(width: 3),
            CustomText(
                title: '$count',
                textStyle: robotoStyle400Regular.copyWith(
                    fontSize: 16, color: commentProvider.likeMenuCount == status ? Colors.white : colorText)),
          ],
        ),
      ),
    ),
  );
}
