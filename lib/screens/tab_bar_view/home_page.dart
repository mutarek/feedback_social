import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../../const/palette.dart';
import '../../provider/provider.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  ScrollController controller = ScrollController();
  @override
  void initState() {
    final value = Provider.of<GetInfoFromDb>(context, listen: false);
    value.info();
    final data = Provider.of<NewsFeedPostProvider>(context, listen: false);
    data.getData();
    controller.addListener(() {
      if (controller.offset >= controller.position.maxScrollExtent &&
          !controller.position.outOfRange) {
        data.getData();
      }
    });
    // final data2 =
    //     Provider.of<ProfileNewsFeedPostProvider>(context, listen: false);
    // data2.getData();
    final profileDetails =
        Provider.of<ProfileDetailsProvider>(context, listen: false);
    profileDetails.getUserData();
    data.checkConnection();
    final profieImage =
        Provider.of<UserProfileProvider>(context, listen: false);
    profieImage.getUserData();
    final notification =
        Provider.of<NotificationsProvider>(context, listen: false);
    notification.getData();
    notification.check();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "FeedBack",
          style: TextStyle(
              color: Palette.primary,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: -1.2),
        ),
        actions: [
          Consumer<LoginProvider>(builder: (context, provider, child) {
            return CustomIconButton(
                iconName: Icons.search,
                onPressed: () {
                  Get.to(() => const SearchScreen());
                });
          }),
          CustomIconButton(
              iconName: MdiIcons.facebookMessenger,
              onPressed: () {
                Get.to(() => const CommingSoonScreen());
              })
        ],
      ),
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: width * 0.1, top: height * 0.014),
              child:
                  Consumer2<ProfileDetailsProvider, UserNewsfeedPostProvider>(
                      builder: (context, provider, provide2, child) {
                return NewsfeedPostWidget(
                  height: height,
                  width: width,
                  progilePhoto: (provider.userprofileData.profileImage == null)
                      ? "https://meektecbacekend.s3.amazonaws.com/media/profile/default.jpeg"
                      : provider.userprofileData.profileImage!,
                  goToPostScreen: () {
                    provide2.id = provider.userId!;
                    Get.to(() => const ProfileScreen());
                  },
                  goToProfile: () {
                    Get.to(() => const CreateNewPostScreen());
                  },
                );
              }),
            ),
            Consumer6<
                    NewsFeedPostProvider,
                    LikeCommentShareProvider,
                    CreatePostProvider,
                    ProfileDetailsProvider,
                    SinglePostProvider,
                    PublicProfileDetailsProvider>(
                builder: (context,
                    newsfeedProvider,
                    likeCommentShareProvider,
                    postCreateProvider,
                    profileProvider,
                    singlePostProvider,
                    publicProfileProvider,
                    child) {
              return Visibility(
                visible: newsfeedProvider.isLoaded,
                child: (newsfeedProvider.results.isEmpty)
                    ? Padding(
                        padding: EdgeInsets.only(top: height * 0.3),
                        child: const Center(
                          child: Text(
                              "              Nothing to show. \n Add new friends to see new posts."),
                        ),
                      )
                    : Consumer6<
                            UserNewsfeedPostProvider,
                            CreatePostProvider,
                            CreateGroupPost,
                            CreatePagePost,
                            SingleVideoShowProvider,
                            ReportPostProvider>(
                        builder: (context,
                            userNewsfeedPostProvider,
                            createPostProvider,
                            createGroupPost,
                            createPagePost,
                            singleVideoShowProvider,
                            reportPostProvider,
                            child) {
                        return (newsfeedProvider.results.isEmpty)?
                        const Center(
                          child: CupertinoActivityIndicator(),
                        ):
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: newsfeedProvider.results.length + 1,
                            itemBuilder: (context, index) {
                              if (index < newsfeedProvider.results.length) {
                                return Consumer2<ShareTimeLinePostProvider,
                                        PostImagesPreviewProvider>(
                                    builder: (context, sharePostProvider,
                                        postImageProvider, child) {
                                  return PostContainer(
                                    editOnPressed: (newsfeedProvider
                                                .results[index].author!.id ==
                                            profileProvider.userId)
                                        ? (newsfeedProvider.results[index]
                                                    .postType ==
                                                "timeline")
                                            ? () {
                                                createPostProvider
                                                        .description =
                                                    (newsfeedProvider
                                                                .results[
                                                                    index]
                                                                .sharePost !=
                                                            null)
                                                        ? newsfeedProvider
                                                            .results[index]
                                                            .sharePost!
                                                            .post!
                                                            .description!
                                                        : newsfeedProvider
                                                            .results[index]
                                                            .description!;
                                                createPostProvider
                                                        .editPostId =
                                                    newsfeedProvider
                                                        .results[index].id;
                                                createPostProvider.postId =
                                                    newsfeedProvider
                                                        .results[index]
                                                        .newsfeedId;
                                                Get.to(() =>
                                                    const EditPostScreen());
                                              }
                                            : (newsfeedProvider.results[index]
                                                        .postType ==
                                                    "group")
                                                ? () {
                                                    //------

                                                    createGroupPost.groupId =
                                                        newsfeedProvider
                                                            .results[index]
                                                            .group!
                                                            .id;

                                                    createGroupPost.postId =
                                                        newsfeedProvider
                                                            .results[index]
                                                            .id;
                                                    createGroupPost
                                                            .description =
                                                        newsfeedProvider
                                                            .results[index]
                                                            .description!;
                                                    Get.to(() =>
                                                        const EditGroupPostScreen());
                                                    //-----
                                                    //Group post edit
                                                  }
                                                : () {
                                                    //page post edit

                                                    createPagePost.pageId =
                                                        newsfeedProvider
                                                            .results[index]
                                                            .page!
                                                            .id;
                                                    createPagePost.postId =
                                                        newsfeedProvider
                                                            .results[index]
                                                            .id;
                                                    createPagePost
                                                            .description =
                                                        newsfeedProvider
                                                            .results[index]
                                                            .description!;
                                                    Get.to(() =>
                                                        const EditPagePostScreen());
                                                  }
                                        : () {
                                            reportPostProvider.postId =
                                                newsfeedProvider
                                                    .results[index].id;
                                            reportPostProvider.postFrom =
                                                "newsfeed";
                                            Get.to(() =>
                                                const ReportPostScreen());
                                          },
                                    editText: (newsfeedProvider
                                                .results[index].author!.id ==
                                            profileProvider.userId)
                                        ? const Icon(
                                            Icons.edit,
                                            color: Palette.primary,
                                          )
                                        : const Icon(
                                            Icons.report,
                                            color: Colors.orange,
                                          ),
                                    moreOnPressed: () {},
                                    pageImage: (newsfeedProvider
                                                .results[index].postType ==
                                            "page")
                                        ? newsfeedProvider
                                            .results[index].page!.avatar!
                                        : "",
                                    pageName: (newsfeedProvider
                                                .results[index].postType ==
                                            "page")
                                        ? newsfeedProvider
                                            .results[index].page!.name!
                                        : "",
                                    pageRole: "",
                                    groupImage: (newsfeedProvider
                                                .results[index].postType ==
                                            "group")
                                        ? newsfeedProvider
                                            .results[index].group!.coverPhoto!
                                        : "",
                                    groupName: (newsfeedProvider
                                                .results[index].postType ==
                                            "group")
                                        ? newsfeedProvider
                                            .results[index].group!.name!
                                        : "",
                                    postType: newsfeedProvider
                                        .results[index].postType!,
                                    shareFrom: (newsfeedProvider
                                                .results[index].sharePost !=
                                            null)
                                        ? newsfeedProvider.results[index]
                                            .sharePost!.shareFrom!
                                        : "timeline",
                                    imageHeight: (newsfeedProvider
                                                .results[index].totalImage ==
                                            1)
                                        ? height * 0.35
                                        : (newsfeedProvider.results[index]
                                                    .totalImage ==
                                                2)
                                            ? height * 0.2
                                            : height * 0.5,
                                    isShare: newsfeedProvider
                                        .results[index].isShare,
                                    sharerName: (newsfeedProvider
                                                .results[index].sharePost !=
                                            null)
                                        ? newsfeedProvider.results[index]
                                            .sharePost!.post!.author!.fullName
                                        : "",
                                    sharerImage: (newsfeedProvider
                                                .results[index].sharePost !=
                                            null)
                                        ? newsfeedProvider
                                            .results[index]
                                            .sharePost!
                                            .post!
                                            .author!
                                            .profileImage
                                        : "https://meektecbacekend.s3.amazonaws.com/media/profile/default.jpeg",
                                    shareTime: (newsfeedProvider
                                                .results[index].sharePost !=
                                            null)
                                        ? newsfeedProvider.results[index]
                                            .sharePost!.timestamp
                                        : "",
                                    shareDescription: newsfeedProvider
                                        .results[index].description,
                                    description: (newsfeedProvider
                                                .results[index].sharePost !=
                                            null)
                                        ? newsfeedProvider.results[index]
                                            .sharePost!.post!.description
                                        : newsfeedProvider
                                            .results[index].description,
                                    imageCount: (newsfeedProvider
                                                    .results[index]
                                                    .totalImage !=
                                                null &&
                                            newsfeedProvider.results[index]
                                                    .totalImage !=
                                                0)
                                        ? true
                                        : false,
                                    shareImageCount: (newsfeedProvider
                                                    .results[index]
                                                    .sharePost !=
                                                null &&
                                            newsfeedProvider
                                                    .results[index]
                                                    .sharePost!
                                                    .post!
                                                    .images !=
                                                null)
                                        ? true
                                        : false,
                                    showImages: Padding(
                                      padding: EdgeInsets.only(
                                          left: width * 0.04,
                                          right: width * 0.04),
                                      child: Column(
                                        children: [
                                          (newsfeedProvider.results[index]
                                                      .totalImage ==
                                                  1)
                                              ? Center(
                                                  child: InkWell(
                                                    onTap: () {
                                                      postImageProvider
                                                          .iamges = [];
                                                      for (int i = 0;
                                                          i <
                                                              newsfeedProvider
                                                                  .results[
                                                                      index]
                                                                  .totalImage!;
                                                          i++) {
                                                        postImageProvider
                                                            .iamges
                                                            .add(
                                                                newsfeedProvider
                                                                    .results[
                                                                        index]
                                                                    .images![
                                                                        0]
                                                                    .image!);
                                                        Get.to(() =>
                                                            const PostImagesPreview());
                                                      }
                                                    },
                                                    child: CachedNetworkImage(
                                                        imageUrl:
                                                            newsfeedProvider
                                                                .results[
                                                                    index]
                                                                .images![0]
                                                                .image!,
                                                        imageBuilder: (context,
                                                                imageProvider) =>
                                                            Container(
                                                                height:
                                                                    height *
                                                                        0.35,
                                                                decoration: BoxDecoration(
                                                                    image: DecorationImage(
                                                                        image:
                                                                            imageProvider,
                                                                        fit: BoxFit
                                                                            .fitWidth))),
                                                        placeholder:
                                                            ((context, url) =>
                                                                Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Image
                                                                      .asset(
                                                                    "assets/background/loading.gif",
                                                                    height:
                                                                        200,
                                                                  ),
                                                                ))),
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
                                                          (newsfeedProvider
                                                                      .results[
                                                                          index]
                                                                      .totalImage ==
                                                                  1)
                                                              ? 1
                                                              : 2,
                                                      crossAxisSpacing: 2.0,
                                                      mainAxisSpacing: 2.0,
                                                    ),
                                                    itemCount: (newsfeedProvider
                                                                .results[
                                                                    index]
                                                                .totalImage! <
                                                            4)
                                                        ? newsfeedProvider
                                                            .results[index]
                                                            .totalImage
                                                        : 4,
                                                    itemBuilder:
                                                        (context, index2) {
                                                      return InkWell(
                                                        onTap: () {
                                                          postImageProvider
                                                              .iamges = [];
                                                          for (int i = 0;
                                                              i <
                                                                  newsfeedProvider
                                                                      .results[
                                                                          index]
                                                                      .totalImage!;
                                                              i++) {
                                                            postImageProvider
                                                                .iamges
                                                                .add(newsfeedProvider
                                                                    .results[
                                                                        index]
                                                                    .images![
                                                                        i]
                                                                    .image!);
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
                                                                child: (newsfeedProvider.results[index].totalImage! >
                                                                            4 &&
                                                                        index2 ==
                                                                            3)
                                                                    ? Container(
                                                                        child:
                                                                            const Center(
                                                                          child:
                                                                              Text(
                                                                            "More images",
                                                                            style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 20,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        decoration: BoxDecoration(
                                                                            image: DecorationImage(
                                                                          image:
                                                                              NetworkImage(newsfeedProvider.results[index].images![index2].image!),
                                                                          fit:
                                                                              BoxFit.cover,
                                                                        )),
                                                                      )
                                                                    : CachedNetworkImage(
                                                                        imageUrl: newsfeedProvider
                                                                            .results[
                                                                                index]
                                                                            .images![
                                                                                index2]
                                                                            .image!,
                                                                        imageBuilder: (context, imageProvider) => Container(
                                                                            width: 400,
                                                                            height: 200,
                                                                            decoration: BoxDecoration(image: DecorationImage(image: imageProvider, fit: BoxFit.fitWidth))),
                                                                        placeholder: ((context, url) => Container(
                                                                              alignment: Alignment.center,
                                                                              child: Image.asset(
                                                                                "assets/background/loading.gif",
                                                                                height: 200,
                                                                              ),
                                                                            ))))
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ),
                                    shareImages: (newsfeedProvider
                                                    .results[index]
                                                    .sharePost !=
                                                null &&
                                            newsfeedProvider
                                                    .results[index]
                                                    .sharePost!
                                                    .post!
                                                    .images !=
                                                null)
                                        ? (newsfeedProvider
                                                    .results[index]
                                                    .sharePost!
                                                    .post!
                                                    .images!
                                                    .length >
                                                1)
                                            ? Center(
                                                child: InkWell(
                                                  onTap: () {
                                                    print("Hello line 293");
                                                  },
                                                  child: Container(
                                                      color: Colors.white,
                                                      height: 200,
                                                      width: width,
                                                      child: Image.network(
                                                        newsfeedProvider
                                                            .results[index]
                                                            .sharePost!
                                                            .post!
                                                            .images![0]
                                                            .image!,
                                                        fit: BoxFit.contain,
                                                      )),
                                                ),
                                              )
                                            : Column(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      print("Hello line 309");
                                                    },
                                                    child: Expanded(
                                                      child: GridView.builder(
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        gridDelegate:
                                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 2,
                                                          crossAxisSpacing:
                                                              5.0,
                                                          mainAxisSpacing:
                                                              5.0,
                                                        ),
                                                        itemCount:
                                                            newsfeedProvider
                                                                .results[
                                                                    index]
                                                                .sharePost!
                                                                .post!
                                                                .images!
                                                                .length,
                                                        itemBuilder: (context,
                                                            index2) {
                                                          return Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Expanded(
                                                                child: Image
                                                                    .network(
                                                                  newsfeedProvider
                                                                      .results[
                                                                          index]
                                                                      .sharePost!
                                                                      .post!
                                                                      .images![
                                                                          index2]
                                                                      .image!,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              )
                                                            ],
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                        : const Text(""),
                                    onProfileTap: () {
                                      if (profileProvider.userId ==
                                          newsfeedProvider
                                              .results[index].author!.id) {
                                        userNewsfeedPostProvider.id =
                                            newsfeedProvider
                                                .results[index].author!.id!;
                                        Get.to(() => const ProfileScreen());
                                      } else {
                                        publicProfileProvider.id =
                                            newsfeedProvider
                                                .results[index].author!.id!;
                                        userNewsfeedPostProvider.id =
                                            newsfeedProvider
                                                .results[index].author!.id!;

                                        Get.to(() =>
                                            const PublicProfileDetailsScreen());
                                      }
                                    },
                                    name: newsfeedProvider
                                        .results[index].author!.fullName,
                                    time: (newsfeedProvider
                                                .results[index].timestamp !=
                                            null)
                                        ? newsfeedProvider
                                            .results[index].timestamp
                                        : "",
                                    profileImage: newsfeedProvider
                                        .results[index].author!.profileImage,
                                    delete: () {},
                                    edit: () {},
                                    reportThisPost: () {},
                                    hasVideo: (newsfeedProvider
                                                .results[index].totalVideo !=
                                            null)
                                        ? newsfeedProvider
                                            .results[index].totalVideo!
                                        : 0,
                                    onVideoTap: () {
                                      singleVideoShowProvider.videoUrl =
                                          newsfeedProvider.results[index]
                                              .videos![0].video!;
                                      Get.to(() => const ShowVideoPage());
                                    },
                                    videoThumnail: (newsfeedProvider
                                                .results[index].totalVideo !=
                                            1)? Container()
                                    :(newsfeedProvider.results[index]
                                              .videos![0].thumbnail != null)?
                                    Container(
                                      width: width*0.8,
                                      child: const Icon(Icons.play_circle_fill, size: 60, color: Colors.grey,),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                                        newsfeedProvider
                                                            .results[index]
                                                            .videos![0]
                                                            .thumbnail!)
                                        )
                                      ),
                                    )  
                                    :Image.asset("assets/background/video_pause.jpg", width: width*0.7,),
                                    likeCount: (newsfeedProvider
                                                .results[index].totalLike !=
                                            null)
                                        ? newsfeedProvider
                                            .results[index].totalLike!
                                        : 0,
                                    commentCount: (newsfeedProvider
                                                .results[index]
                                                .totalComment !=
                                            null)
                                        ? newsfeedProvider
                                            .results[index].totalComment!
                                        : 0,
                                    isLiked:
                                        newsfeedProvider.results[index].like!,
                                    like: () {
                                      likeCommentShareProvider.postId =
                                          newsfeedProvider.results[index].id
                                              .toString();
                                      likeCommentShareProvider.like();
                                      newsfeedProvider.refresh();
                                    },
                                    comment: () {
                                      likeCommentShareProvider.postId =
                                          newsfeedProvider.results[index].id
                                              .toString();
                                      newsfeedProvider.index = index;
                                      Get.to(const CommentsScreen());
                                    },
                                    share: () {
                                      Get.to(() => const SharePostScreen());
                                      (newsfeedProvider
                                                  .results[index].isShare ==
                                              false)
                                          ? sharePostProvider.postId =
                                              newsfeedProvider
                                                  .results[index].id
                                          : sharePostProvider.postId =
                                              newsfeedProvider.results[index]
                                                  .sharePost!.post!.id;
                                    },
                                  );
                                });
                              } else {
                                return const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Center(
                                      child: CupertinoActivityIndicator()),
                                );
                              }
                            });
                      }),
              );
            })
          ],
        ),
      ),
    );
  }
}
