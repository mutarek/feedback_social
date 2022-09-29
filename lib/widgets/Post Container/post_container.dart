import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets.dart';

class PostContainer extends StatelessWidget {
  final VoidCallback delete;
  final VoidCallback edit;
  final VoidCallback reportThisPost;
  final String? name;
  final String? profileImage;
  final VoidCallback onProfileTap;
  final String? time;
  final bool? isShare;
  final String? sharerImage;
  final String? sharerName;
  final String? shareTime;
  final String? description;
  final String? shareDescription;
  final bool imageCount;
  final Widget showImages;
  final bool shareImageCount;
  final int likeCount;
  final int commentCount;
  final VoidCallback like;
  final VoidCallback comment;
  final VoidCallback share;
  final Widget shareImages;
  final double imageHeight;
  final String shareFrom;
  final String postType;
  final String groupImage;
  final String groupName;
  final String pageName;
  final String pageRole;
  final String pageImage;
  final bool isLiked;
  final VoidCallback moreOnPressed;
  final VoidCallback editOnPressed;
  final Icon editText;
  final int hasVideo;
  final VoidCallback onVideoTap;
  final Widget videoThumnail;
  const PostContainer(
      {required this.delete,
      required this.edit,
      required this.reportThisPost,
      required this.name,
      required this.time,
      required this.profileImage,
      required this.onProfileTap,
      required this.isShare,
      required this.shareTime,
      required this.sharerImage,
      required this.sharerName,
      required this.description,
      required this.shareDescription,
      required this.imageCount,
      required this.showImages,
      required this.shareImageCount,
      required this.likeCount,
      required this.commentCount,
      required this.comment,
      required this.share,
      required this.like,
      required this.shareImages,
      required this.imageHeight,
      required this.shareFrom,
      required this.postType,
      required this.groupImage,
      required this.groupName,
      required this.pageImage,
      required this.pageName,
      required this.pageRole,
      required this.isLiked,
      required this.moreOnPressed,
      required this.editOnPressed,
      required this.editText,
      required this.hasVideo,
      required this.onVideoTap,
      required this.videoThumnail,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        (isShare == false)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PostHeader(
                      moreOnPressed: moreOnPressed,
                      pageImage: pageImage,
                      pageName: pageName,
                      pageRole: pageRole,
                      groupImage: groupImage,
                      groupName: groupName,
                      postType: postType,
                      delete: delete,
                      edit: edit,
                      reportThisPost: reportThisPost,
                      name: name,
                      time: time,
                      profileImage: profileImage,
                      onProfileTap: onProfileTap),
                  Padding(
                    padding: EdgeInsets.only(
                        left: width * 0.04, bottom: height * 0.02),
                    child: Text(
                      description!,
                      style: GoogleFonts.lato(),
                    ),
                  ),
                  (imageCount == true)
                      ? SizedBox(
                          height: imageHeight,
                          child: showImages,
                        )
                      : Container(),
                ],
              )
/*-----------------------------------share from group-------------------------*/
            : (shareFrom == "timeline")
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: width * 0.02, top: height * 0.01),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    backgroundImage: NetworkImage(sharerImage!),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: height * 0.018, left: width * 0.02),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            sharerName!,
                                            style: GoogleFonts.lato(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: width * 0.02,
                                          ),
                                          const Text("Shared a post"),
                                        ],
                                      ),
                                      Text(
                                        shareTime!,
                                        style: GoogleFonts.lato(
                                          fontSize: 8,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: width * 0.04),
                              child: Text(
                                shareDescription!,
                                style: GoogleFonts.lato(),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14)),
                              child: PostHeader(
                                  moreOnPressed: () {},
                                  pageImage: pageImage,
                                  pageName: pageName,
                                  pageRole: pageRole,
                                  groupImage: groupImage,
                                  groupName: groupName,
                                  postType: postType,
                                  delete: delete,
                                  edit: edit,
                                  reportThisPost: reportThisPost,
                                  name: name,
                                  time: time,
                                  profileImage: profileImage,
                                  onProfileTap: onProfileTap),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: width * 0.04),
                              child: Text(description!),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            (shareImageCount == true)
                                ? SizedBox(
                                    height: height * 0.21,
                                    child: shareImages,
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                  )
                : (shareFrom == "group")
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: width * 0.02,
                                          top: height * 0.01),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        backgroundImage:
                                            NetworkImage(sharerImage!),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: height * 0.018,
                                          left: width * 0.02),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                sharerName!,
                                                style: GoogleFonts.lato(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                width: width * 0.02,
                                              ),
                                              const Text("Shared a post"),
                                            ],
                                          ),
                                          Text(
                                            shareTime!,
                                            style: GoogleFonts.lato(
                                              fontSize: 8,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: width * 0.04),
                                  child: Text(
                                    shareDescription!,
                                    style: GoogleFonts.lato(),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14)),
                                  child: PostHeader(
                                      moreOnPressed: moreOnPressed,
                                      pageImage: pageImage,
                                      pageName: pageName,
                                      pageRole: pageRole,
                                      groupImage: groupImage,
                                      groupName: groupName,
                                      postType: postType,
                                      delete: delete,
                                      edit: edit,
                                      reportThisPost: reportThisPost,
                                      name: name,
                                      time: time,
                                      profileImage: profileImage,
                                      onProfileTap: onProfileTap),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: width * 0.04),
                                  child: Text(description!),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                (shareImageCount == true)
                                    ? SizedBox(
                                        height: height * 0.21,
                                        child: shareImages,
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                      )
                    :

/*-----------------------------------------------share from page---------------------------------*/
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: width * 0.02,
                                          top: height * 0.01),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        backgroundImage:
                                            NetworkImage(sharerImage!),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: height * 0.018,
                                          left: width * 0.02),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            sharerName!,
                                            style: GoogleFonts.lato(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            shareTime!,
                                            style: GoogleFonts.lato(
                                              fontSize: 8,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: width * 0.04),
                                  child: Text(
                                    shareDescription!,
                                    style: GoogleFonts.lato(),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14)),
                                  child: PostHeader(
                                      moreOnPressed: moreOnPressed,
                                      pageImage: pageImage,
                                      pageName: pageName,
                                      pageRole: pageRole,
                                      groupImage: groupImage,
                                      groupName: groupName,
                                      postType: postType,
                                      delete: delete,
                                      edit: edit,
                                      reportThisPost: reportThisPost,
                                      name: name,
                                      time: time,
                                      profileImage: profileImage,
                                      onProfileTap: onProfileTap),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: width * 0.04),
                                  child: Text(description!),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                (shareImageCount == true)
                                    ? SizedBox(
                                        height: height * 0.21,
                                        child: shareImages,
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 06,
                      ),
        (hasVideo == 1)
            ? InkWell(
                onTap: onVideoTap,
                child: Container(
                  height: 200,
                  child: videoThumnail,
                  color: Colors.white10,
                ),
              )
            : Container(),
        LikeCommentCount(
          editOnPressed: editOnPressed,
          editText: editText,
          likeCount: likeCount,
          commentCount: commentCount,
          likeCountColor: (isLiked == true) ? Colors.red : Colors.black,
          likeText: (isLiked == true) ? "Liked" : "Like",
        ),
        LikeCommentShare(
          like: like,
          comment: comment,
          share: share,
          likeIconColor: (isLiked == true) ? Colors.red : Colors.black,
          likeText: "",
        ),
      ],
    );
  }
}
