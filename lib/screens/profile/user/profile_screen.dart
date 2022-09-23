// import 'package:als_frontend/screens/profile/user/profile_details_card.dart';
import 'package:als_frontend/screens/profile/user_photos_tab.dart';
import 'package:als_frontend/screens/profile/user_videos_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../const/palette.dart';
import '../../../provider/provider.dart';
import '../../../widgets/widgets.dart';
import '../../screens.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ScrollController controller = ScrollController();
  @override
  void initState() {
    final value = Provider.of<UserProfileProvider>(context, listen: false);
    value.getUserData();
    final userNewsFeed =
        Provider.of<UserNewsfeedPostProvider>(context, listen: false);
    userNewsFeed.getData();
    controller.addListener(() {
      if (controller.offset >= controller.position.maxScrollExtent &&
          !controller.position.outOfRange) {
        userNewsFeed.getData();
      }
    });
    final profileImages =
        Provider.of<ProfileImagesProvider>(context, listen: false);
    profileImages.userId = userNewsFeed.id;
    final profileVideo =
        Provider.of<ProfileVideosProvider>(context, listen: false);
    profileVideo.userId = userNewsFeed.id;
    super.initState();
  }

  void refresh() {
    final userNewsFeed =
        Provider.of<UserNewsfeedPostProvider>(context, listen: false);
    userNewsFeed.getData();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Palette.scaffold,
          body: Consumer6<
                  UserProfileProvider,
                  UpdateProfileImageProvider,
                  PostImagesPreviewProvider,
                  UpdateCoverPhotProvider,
                  ProfileImagesProvider,
                  UserNewsfeedPostProvider>(
              builder: (context,
                  provider,
                  profileImageProvider,
                  postImageProvider,
                  coverPhotoProvider,
                  profileImages,
                  userPostProvider,
                  child) {
            return (provider.loading == true)
                ? const Center(
                    child: CupertinoActivityIndicator(),
                  )
                : SingleChildScrollView(
                  controller: controller,
                    physics: ScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                                height: height * 0.26,
                                width: width,
                                color: Palette.scaffold),
                            ProfileCoverPhotoWidget(
                                back: () {
                                  Get.to(const NavScreen());
                                },
                                viewCoverPhoto: (() {
                                  profileImages.imageUrl =
                                      provider.userprofileData.coverImage!;
                                  Get.to(() => const SingleImageView());
                                }),
                                coverphoto: (provider.loading == false)
                                    ? provider.userprofileData.coverImage!
                                    : "https://meektecbacekend.s3.amazonaws.com/media/profile/default.jpeg",
                                coverphotochange: (() {
                                  coverPhotoProvider.imageUrl =
                                      provider.userprofileData.coverImage!;
                                  Get.to(() => const UpdateCoverPhoto());
                                })),
                            ProfilePhotowidget(
                                profilePhotoChange: () {
                                  profileImageProvider.imageUrl =
                                      provider.userprofileData.profileImage!;
                                  Get.to(() => const UpdateProfileImage());
                                },
                                profileImage: (provider.loading == false)
                                    ? provider.userprofileData.profileImage!
                                    : "https://meektecbacekend.s3.amazonaws.com/media/profile/default.jpeg",
                                viewProfilePhoto: () {
                                  profileImages.imageUrl =
                                      provider.userprofileData.profileImage!;
                                  Get.to(() => const SingleImageView());
                                })
                          ],
                        ),

                        Padding(
                          padding: EdgeInsets.only(
                              top: height * 0.01, left: width * 0.05),
                          child: Text(
                            "${provider.userprofileData.firstName!} ${provider.userprofileData.lastName!}",
                            style: GoogleFonts.lato(
                                fontSize: width * 0.05,
                                fontWeight: FontWeight.w700),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(
                              top: height * 0.01,
                              left: width * 0.04,
                              right: width * 0.04),
                          child: Container(
                            height: height * 0.043,
                            width: width * 0.92,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            child: Padding(
                              padding: EdgeInsets.only(left: width * 0.1),
                              child: Row(
                                children: [
                                  Text(
                                    "${provider.userprofileData.friends!.length}",
                                    style: GoogleFonts.lato(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Palette.notificationColor),
                                  ),
                                  Text(" Friends",
                                      style: GoogleFonts.lato(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500)),
                                  SizedBox(
                                    width: width * 0.2,
                                  ),
                                  Text(
                                    "${provider.userprofileData.followers!.length}",
                                    style: GoogleFonts.lato(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Palette.notificationColor),
                                  ),
                                  Text(
                                    " Followers",
                                    style: GoogleFonts.lato(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ), //following
                        Padding(
                          padding: EdgeInsets.only(
                              top: height * 0.01,
                              left: width * 0.04,
                              right: width * 0.04),
                          child: ProfileDetailsCard(),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: height * 0.01,
                              left: width * 0.04,
                              right: width * 0.04),
                          child: Container(
                            height: height * 0.04,
                            width: width * 0.94,
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.to(()=> const UserPhotosTab());
                                  },
                                  child: Container(
                                    height: height * 0.03,
                                    width: width * 0.4,
                                    decoration: BoxDecoration(
                                        color: Palette.scaffold,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Center(
                                        child: Text(
                                      "Photos",
                                      style:
                                          GoogleFonts.lato(color: Colors.black),
                                    )),
                                  ),
                                ),
                                InkWell(
                                  onTap: (){
                                    Get.to(() => const UserVideoTab());
                                  },
                                  child: Container(
                                    height: height * 0.03,
                                    width: width * 0.4,
                                    decoration: BoxDecoration(
                                        color: Palette.scaffold,
                                        borderRadius: BorderRadius.circular(15)),
                                    child: Center(
                                        child: Text(
                                      "videos",
                                      style:
                                          GoogleFonts.lato(color: Colors.black),
                                    )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Consumer3<CreatePostProvider, SinglePostProvider,
                                SingleVideoShowProvider>(
                            builder: (context,
                                createPostProvider,
                                singlePostProvider,
                                singleVideoShowProvider,
                                child) {
                          return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  userPostProvider.authorPostResults.length + 1,
                              itemBuilder: ((context, index) {
                                if (index <
                                    userPostProvider.authorPostResults.length) {
                                  return (userPostProvider
                                          .authorPostResults.isEmpty)
                                      ? const Center(child: Text("Loading..."))
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            PostHeader(
                                                moreOnPressed: () {},
                                                postType: "timeline",
                                                delete: () {},
                                                edit: () {},
                                                reportThisPost: () {},
                                                name: userPostProvider
                                                    .authorPostResults[index]
                                                    .author!
                                                    .fullName,
                                                time: userPostProvider
                                                    .authorPostResults[index]
                                                    .timestamp,
                                                profileImage: userPostProvider
                                                    .authorPostResults[index]
                                                    .author!
                                                    .profileImage,
                                                onProfileTap: () {}),
                                            Text(userPostProvider
                                                .authorPostResults[index]
                                                .description!),
                                            SizedBox(
                                                height: (userPostProvider
                                                            .authorPostResults[
                                                                index]
                                                            .totalImage !=
                                                        0)
                                                    ? (userPostProvider
                                                                .authorPostResults[
                                                                    index]
                                                                .totalImage! <
                                                            3)
                                                        ? 200
                                                        : 400
                                                    : 0,
                                                child: (userPostProvider
                                                            .authorPostResults[
                                                                index]
                                                            .totalImage ==
                                                        1)
                                                    ? InkWell(
                                                        onTap: () {
                                                          postImageProvider
                                                              .iamges = [];

                                                          postImageProvider
                                                              .iamges
                                                              .add(userPostProvider
                                                                  .authorPostResults[
                                                                      index]
                                                                  .images![0]
                                                                  .image);
                                                          Get.to(() =>
                                                              const PostImagesPreview());
                                                        },
                                                        child: Center(
                                                          child: Container(
                                                              color:
                                                                  Colors.white,
                                                              height: 200,
                                                              width: width,
                                                              child:
                                                                  Image.network(
                                                                userPostProvider
                                                                    .authorPostResults[
                                                                        index]
                                                                    .images![0]
                                                                    .image!,
                                                                fit: BoxFit
                                                                    .contain,
                                                              )),
                                                        ),
                                                      )
                                                    : Expanded(
                                                        child: GridView.builder(
                                                          physics:
                                                              const NeverScrollableScrollPhysics(),
                                                          shrinkWrap: true,
                                                          gridDelegate:
                                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount:
                                                                (userPostProvider
                                                                            .authorPostResults[index]
                                                                            .totalImage ==
                                                                        1)
                                                                    ? 1
                                                                    : 2,
                                                            crossAxisSpacing:
                                                                2.0,
                                                            mainAxisSpacing:
                                                                2.0,
                                                          ),
                                                          itemCount: (userPostProvider
                                                                      .authorPostResults[
                                                                          index]
                                                                      .totalImage! <
                                                                  4)
                                                              ? userPostProvider
                                                                  .authorPostResults[
                                                                      index]
                                                                  .totalImage
                                                              : 4,
                                                          itemBuilder: (context,
                                                              index2) {
                                                            return InkWell(
                                                              onTap: () {
                                                                postImageProvider
                                                                    .iamges = [];
                                                                for (int i = 0;
                                                                    i <
                                                                        userPostProvider
                                                                            .authorPostResults[index]
                                                                            .images!
                                                                            .length;
                                                                    i++) {
                                                                  postImageProvider
                                                                      .iamges
                                                                      .add(userPostProvider
                                                                          .authorPostResults[
                                                                              index]
                                                                          .images![
                                                                              i]
                                                                          .image);
                                                                  Get.to(() =>
                                                                      const PostImagesPreview());
                                                                }
                                                              },
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Expanded(
                                                                    child: (userPostProvider.authorPostResults[index].totalImage! >
                                                                                4 &&
                                                                            index2 ==
                                                                                3)
                                                                        ? Container(
                                                                            child:
                                                                                const Center(
                                                                              child: Text(
                                                                                "More images",
                                                                                style: TextStyle(
                                                                                  color: Colors.white70,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontSize: 20,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            decoration: BoxDecoration(
                                                                                image: DecorationImage(
                                                                              image: NetworkImage(userPostProvider.authorPostResults[index].images![index2].image!),
                                                                              fit: BoxFit.cover,
                                                                            )),
                                                                          )
                                                                        : Image
                                                                            .network(
                                                                            userPostProvider.authorPostResults[index].images![index2].image!,
                                                                            fit:
                                                                                BoxFit.fill,
                                                                          ),
                                                                  )
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      )),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            (userPostProvider
                                                        .authorPostResults[
                                                            index]
                                                        .totalVideo !=
                                                    0)
                                                ? InkWell(
                                                    onTap: () {
                                                      singleVideoShowProvider
                                                              .videoUrl =
                                                          userPostProvider
                                                              .authorPostResults[
                                                                  index]
                                                              .videos![0]
                                                              .video;
                                                      Get.to(() =>
                                                          const ShowVideoPage());
                                                    },
                                                    child: Container(
                                                      height: 150,
                                                      width: width,
                                                      //                 child: (userPostProvider
                                                      //                         .authorPostResults[
                                                      //                             index]
                                                      //                         .videos![0]
                                                      //                         .thumbnail != null)?Container(
                                                      //   child: const Icon(Icons.play_circle_fill, size: 60, color: Colors.grey,),
                                                      //   decoration: BoxDecoration(
                                                      //     image: DecorationImage(
                                                      //       image: NetworkImage(
                                                      //                     userPostProvider
                                                      //                         .authorPostResults[
                                                      //                             index]
                                                      //                         .videos![0]
                                                      //                         .thumbnail)
                                                      //     )
                                                      //   ),
                                                      // )
                                                      // :
                                                      child: Image.asset(
                                                          "assets/background/video_pause.jpg"),
                                                      color: Colors.black,
                                                    ),
                                                  )
                                                : Container(),
                                            LikeCommentCount(
                                              editOnPressed: () {
                                                singlePostProvider.description =
                                                    userPostProvider
                                                        .authorPostResults[
                                                            index]
                                                        .description;
                                                createPostProvider.postId =
                                                    userPostProvider
                                                        .authorPostResults[
                                                            index]
                                                        .id;
                                                Get.to(() =>
                                                    const EditPostScreen());
                                              },
                                              editText: const Icon(
                                                Icons.edit,
                                                color: Palette.primary,
                                              ),
                                              likeCount: userPostProvider
                                                  .authorPostResults[index]
                                                  .totalLike,
                                              commentCount: userPostProvider
                                                  .authorPostResults[index]
                                                  .totalComment,
                                              likeCountColor: (userPostProvider
                                                          .authorPostResults[
                                                              index]
                                                          .like ==
                                                      false)
                                                  ? Colors.black
                                                  : Colors.red,
                                              likeText: (userPostProvider
                                                          .authorPostResults[
                                                              index]
                                                          .like ==
                                                      true)
                                                  ? "Liked"
                                                  : "Like",
                                            ),
                                            Consumer<LikeCommentShareProvider>(
                                                builder: (context, likeComment,
                                                    child) {
                                              return LikeCommentShare(
                                                likeText: "Liked",
                                                like: () {
                                                  likeComment.postId =
                                                      userPostProvider
                                                          .authorPostResults[
                                                              index]
                                                          .id
                                                          .toString();
                                                  likeComment.like();
                                                  refresh();
                                                },
                                                comment: () {
                                                  likeComment.postId =
                                                      userPostProvider
                                                          .authorPostResults[
                                                              index]
                                                          .id
                                                          .toString();
                                                  userPostProvider.index =
                                                      index;
                                                  Get.to(
                                                      const UserPostCommentsScreen());
                                                },
                                                share: () {
                                                  // likeComment.pageId =
                                                  //     userPostProvider
                                                  //         .authorPostResults![index]
                                                  //         .page
                                                  //         .id;
                                                  // likeComment.postId =
                                                  //     userPostProvider
                                                  //         .authorPostResults![index].id
                                                  //         .toString();
                                                  // Get.to(
                                                  //     const authorPostResultshareScreen());
                                                },
                                                likeIconColor: (userPostProvider
                                                            .authorPostResults[
                                                                index]
                                                            .like ==
                                                        false)
                                                    ? Colors.black
                                                    : Colors.red,
                                              );
                                            })
                                          ],
                                        );
                                } else {
                                  return const Center(
                                      child: CupertinoActivityIndicator());
                                }
                              }));
                        })
                      ],
                    ),
                  );
          })),
    );
  }
}
