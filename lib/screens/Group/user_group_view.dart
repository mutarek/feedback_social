import 'package:als_frontend/const/palette.dart';
import 'package:als_frontend/provider/Group%20Page/Group/group_images_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../provider/provider.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';
import 'Tab items/group_videos_tab.dart';

class UserGroupView extends StatefulWidget {
  const UserGroupView({Key? key}) : super(key: key);

  @override
  State<UserGroupView> createState() => _UserGroupViewState();
}

class _UserGroupViewState extends State<UserGroupView> {
  @override
  void initState() {
    final value1 = Provider.of<GroupDetailsProvider>(context, listen: false);
    value1.getData();
    final value4 = Provider.of<GroupMembersProvider>(context, listen: false);
    value4.getData();
    final value = Provider.of<ProfileDetailsProvider>(context, listen: false);
    value.getUserData();
    final groupPost = Provider.of<GroupPostProvider>(context, listen: false);
    groupPost.getData();
    final groupImages =
        Provider.of<GroupImagesProvider>(context, listen: false);
    groupImages.groupId = value1.groupIndex;

    final groupVideo =
        Provider.of<GroupVideoProvider>(context, listen: false);
    groupVideo.groupId = value1.groupIndex;


    final groupMembers =
        Provider.of<GroupMembersProvider>(context, listen: false);
    groupMembers.id = value1.groupIndex;
    super.initState();
  }

  TextEditingController writePostController = TextEditingController();

  void refresh() {
    final groupPost = Provider.of<GroupPostProvider>(context, listen: false);
    groupPost.getData();
  }

  List poplist = ["edit", "delete"];

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          body: NestedScrollView(
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              // Setting floatHeaderSlivers to true is required in order to float
              // the outer slivers over the inner scrollable.
              floatHeaderSlivers: true,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverList(
                      delegate: SliverChildListDelegate([
                    SafeArea(
                      child: GestureDetector(
                        onTap: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                        child: Consumer6<
                                AllGroupProvider,
                                GroupDetailsProvider,
                                GroupInviteProvider,
                                GroupInviteFriendListProvider,
                                ProfileImagesProvider,
                                EditGroupProvider>(
                            builder: (context,
                                provider,
                                groupDetailsProvider,
                                groupInviteProvider,
                                groupFriendListProvider,
                                profileImageProvider,
                                editGroupProvider,
                                child) {
                          return (groupDetailsProvider.groupDetails == null)
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Container(
                                  height: height * 0.376,
                                  width: width,
                                  color: Palette.scaffold,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Stack(
                                          children: [
                                            CoverPhotoWidget(
                                              isTrue: false,
                                              coverphotochange: () {},
                                              back: () {
                                                Get.back();
                                              },
                                              coverphoto: groupDetailsProvider
                                                  .groupDetails.coverPhoto,
                                              viewCoverPhoto: () {
                                                profileImageProvider.imageUrl =
                                                    groupDetailsProvider
                                                        .groupDetails
                                                        .coverPhoto;
                                                Get.to(() =>
                                                    const SingleImageView());
                                              },
                                            ),
                                            Positioned(
                                              top: height * 0.21,
                                              child: Container(
                                                height: height * 0.14,
                                                width: width,
                                                decoration: const BoxDecoration(
                                                  color: Palette.scaffold,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(15)),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: height * 0.22,
                                                  left: width * 0.03),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        groupDetailsProvider
                                                            .groupDetails.name,
                                                        style: TextStyle(
                                                            fontSize:
                                                                height * 0.03,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: width *
                                                                    0.227),
                                                        child: Text(
                                                          groupDetailsProvider
                                                              .groupDetails
                                                              .category,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: height * 0.01,
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          groupFriendListProvider
                                                              .friendsList = [];
                                                          groupInviteProvider
                                                                  .groupId =
                                                              groupDetailsProvider
                                                                  .groupDetails
                                                                  .id;
                                                          groupFriendListProvider
                                                                  .groupId =
                                                              groupDetailsProvider
                                                                  .groupDetails
                                                                  .id;
                                                          Get.to(() =>
                                                              const InviteFriendScreen());
                                                        },
                                                        child: CircleAvatar(
                                                          backgroundColor: Palette
                                                              .notificationColor,
                                                          radius: 20,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              const Icon(
                                                                  FontAwesomeIcons
                                                                      .plus,
                                                                  size: 8,
                                                                  color: Colors
                                                                      .white),
                                                              Text("Invite",
                                                                  style: GoogleFonts.lato(
                                                                      fontSize:
                                                                          10,
                                                                      color: Colors
                                                                          .white))
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  const Spacer(),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          groupDetailsProvider
                                                              .groupDetails
                                                              .totalMember
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize:
                                                                  height * 0.03,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        const Text("Members"),
                                                        SizedBox(
                                                          height:
                                                              height * 0.014,
                                                        ),
                                                        Consumer<
                                                                GroupMembersProvider>(
                                                            builder: (context,
                                                                provider,
                                                                child) {
                                                          return InkWell(
                                                            onTap: () {
                                                              editGroupProvider
                                                                      .groupId =
                                                                  groupDetailsProvider
                                                                      .groupDetails
                                                                      .id;
                                                              Get.to(() =>
                                                                  const EditGroup());
                                                            },
                                                            child: Container(
                                                              height: height *
                                                                  0.036,
                                                              width:
                                                                  width * 0.2,
                                                              decoration: BoxDecoration(
                                                                  color: Palette
                                                                      .primary,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  const Icon(
                                                                    FontAwesomeIcons
                                                                        .penToSquare,
                                                                    size: 14,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  SizedBox(
                                                                    width: width *
                                                                        0.007,
                                                                  ),
                                                                  Text(
                                                                    "Edit Group",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            height *
                                                                                0.012,
                                                                        color: Colors
                                                                            .white),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        })
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.02,
                                            ),
                                          ],
                                        ),
                                        Container(
                                          height: height * 0.03,
                                          color: Colors.white,
                                          child: TabBar(tabs: [
                                            Text(
                                              "Discussion",
                                              style: TextStyle(
                                                  fontSize: height * 0.013,
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              "Photos",
                                              style: TextStyle(
                                                  fontSize: height * 0.013,
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              "Videos",
                                              style: TextStyle(
                                                  fontSize: height * 0.013,
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              "Members",
                                              style: TextStyle(
                                                  fontSize: height * 0.013,
                                                  color: Colors.black),
                                            ),
                                          ]),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                        }),
                      ),
                    ),
                  ]))
                ];
              },
              body: TabBarView(
                children: [
                  Column(
                    children: [
                      Consumer6<
                              ProfileDetailsProvider,
                              CreateGroupPost,
                              GroupPostProvider,
                              GroupDetailsProvider,
                              PostImagesPreviewProvider,
                              SingleVideoShowProvider>(
                          builder: (context,
                              profileDetailsProvider,
                              createGroupPost,
                              groupPostProvider,
                              groupDetailsProvider,
                              postImageProvider,
                              singleVideoShowProvider,
                              child) {
                        return Padding(
                          padding: EdgeInsets.only(
                              left: width * 0.02, right: width * 0.022),
                          child: SingleChildScrollView(
                            physics: const ScrollPhysics(),
                            child: Column(
                              children: [
                                PostWidget(
                                    writingContoller: writePostController,
                                    photoPost: () {
                                      createGroupPost.pickImage();
                                    },
                                    userProfilePhoto:
                                        "${profileDetailsProvider.userprofileData.profileImage}",
                                    videoPost: () {
                                      createGroupPost.pickVideo();
                                    },
                                    share: () {
                                      if (writePostController.text.isNotEmpty) {
                                        createGroupPost.createPost(
                                            writePostController.text);
                                        if (createGroupPost.success == true) {
                                          writePostController.text = '';
                                          refresh();
                                          writePostController.text = '';
                                          createGroupPost.image = [];
                                          createGroupPost.video = null;
                                        }
                                      } else {
                                        Fluttertoast.showToast(
                                            msg:
                                                "Please write somthing to post");
                                      }
                                    }),

                                /*----------------------------------------Newsfeed---------------------------------*/
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        groupPostProvider.groupPosts!.length,
                                    itemBuilder: ((context, index) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    (groupDetailsProvider
                                                                .groupDetails ==
                                                            null)
                                                        ? ""
                                                        : groupDetailsProvider
                                                            .groupDetails
                                                            .coverPhoto),
                                                radius: 27,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: width * 0.058,
                                                      top: height * 0.02),
                                                  child: CircleAvatar(
                                                    backgroundImage:
                                                        NetworkImage(
                                                            groupPostProvider
                                                                .groupPosts![
                                                                    index]
                                                                .author
                                                                .profileImage),
                                                    radius: 19,
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  
                                                  Text(groupPostProvider
                                                      .groupPosts![index]
                                                      .author
                                                      .fullName,
                                                      style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(groupPostProvider
                                                      .groupPosts![index]
                                                      .timestamp)
                                                ],
                                              )
                                            ],
                                          ),
                                          Text(groupPostProvider
                                              .groupPosts![index].description),
                                          SizedBox(
                                            height: (groupPostProvider
                                                        .groupPosts![index]
                                                        .totalImage !=
                                                    0)
                                                ? 200
                                                : 0,
                                            child: (groupPostProvider
                                                        .groupPosts![index]
                                                        .totalImage ==
                                                    0)
                                                ? Container()
                                                : (groupPostProvider
                                                            .groupPosts![index]
                                                            .totalImage ==
                                                        1)
                                                    ? Center(
                                                        child: InkWell(
                                                          onTap: () {
                                                            postImageProvider
                                                                .iamges = [];
                                                            for (int i = 0;
                                                                i <
                                                                    groupPostProvider
                                                                        .groupPosts![
                                                                            index]
                                                                        .images
                                                                        .length;
                                                                i++) {
                                                              postImageProvider
                                                                  .iamges
                                                                  .add(groupPostProvider
                                                                      .groupPosts![
                                                                          index]
                                                                      .images[0]
                                                                      .image);
                                                              Get.to(() =>
                                                                  const PostImagesPreview());
                                                            }
                                                          },
                                                          child: Container(
                                                              color:
                                                                  Colors.white,
                                                              height: 150,
                                                              width: width,
                                                              child:
                                                                  Image.network(
                                                                groupPostProvider
                                                                    .groupPosts![
                                                                        index]
                                                                    .images[0]
                                                                    .image,
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
                                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount: 1,
                                                            crossAxisSpacing:
                                                                5.0,
                                                            mainAxisSpacing:
                                                                5.0,
                                                          ),
                                                          itemCount:
                                                              groupPostProvider
                                                                  .groupPosts![
                                                                      index]
                                                                  .totalImage,
                                                          itemBuilder: (context,
                                                              index2) {
                                                            return InkWell(
                                                              onTap: () {
                                                                postImageProvider
                                                                    .iamges = [];
                                                                for (int i = 0;
                                                                    i <
                                                                        groupPostProvider
                                                                            .groupPosts![index]
                                                                            .images
                                                                            .length;
                                                                    i++) {
                                                                  postImageProvider
                                                                      .iamges
                                                                      .add(groupPostProvider
                                                                          .groupPosts![
                                                                              index]
                                                                          .images[
                                                                              index2]
                                                                          .image);
                                                                  Get.to(() =>
                                                                      const PostImagesPreview());
                                                                }
                                                              },
                                                              child: Expanded(
                                                                child: Image
                                                                    .network(
                                                                  groupPostProvider
                                                                      .groupPosts![
                                                                          index]
                                                                      .images[
                                                                          index2]
                                                                      .image,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          (groupPostProvider.groupPosts![index]
                                                      .totalVideo !=
                                                  0)
                                              ? InkWell(
                                                  onTap: () {
                                                    singleVideoShowProvider
                                                            .videoUrl =
                                                        groupPostProvider
                                                            .groupPosts![index]
                                                            .videos[0]
                                                            .video;
                                                    Get.to(() =>
                                                        const ShowVideoPage());
                                                  },
                                                  child: Container(
                                                    height: 150,
                                                    width: width,
                                                    child: Image.asset(
                                                        "assets/background/video_pause.jpg"),
                                                    color: Colors.black,
                                                  ),
                                                )
                                              : Container(),
                                          Consumer<ProfileDetailsProvider>(
                                              builder: (context,
                                                  profileDetailsProvider,
                                                  child) {
                                            return LikeCommentCount(
                                              editOnPressed: (groupPostProvider
                                                          .groupPosts![index]
                                                          .author
                                                          .id ==
                                                      profileDetailsProvider
                                                          .userId)
                                                  ? () {
                                                      createGroupPost.groupId =
                                                          groupDetailsProvider
                                                              .groupDetails.id;

                                                      createGroupPost.postId =
                                                          groupPostProvider
                                                              .groupPosts![
                                                                  index]
                                                              .id;
                                                      createGroupPost
                                                              .description =
                                                          groupPostProvider
                                                              .groupPosts![
                                                                  index]
                                                              .description;
                                                      Get.to(() =>
                                                          const EditGroupPostScreen());
                                                    }
                                                  : () {
                                                      Get.to(() =>
                                                          const ReportPagePostScreen());
                                                    },
                                              editText: (groupPostProvider
                                                          .groupPosts![index]
                                                          .author
                                                          .id ==
                                                      profileDetailsProvider
                                                          .userId)
                                                  ? "Edit"
                                                  : "Report this post",
                                              likeText: (groupPostProvider
                                                          .groupPosts![index]
                                                          .like ==
                                                      true)
                                                  ? "Liked"
                                                  : "Like",
                                              likeCount: groupPostProvider
                                                  .groupPosts![index].totalLike,
                                              commentCount: groupPostProvider
                                                  .groupPosts![index]
                                                  .totalComment,
                                              likeCountColor: (groupPostProvider
                                                          .groupPosts![index]
                                                          .like ==
                                                      false)
                                                  ? Colors.black
                                                  : Colors.red,
                                            );
                                          }),
                                          Consumer3<
                                                  GroupPostLikeCommentProvider,
                                                  GroupDetailsProvider,
                                                  GroupPostProvider>(
                                              builder: (context,
                                                  likeComment,
                                                  groupDetailsProvider,
                                                  groupPostProvider,
                                                  child) {
                                            return LikeCommentShare(
                                              likeText: "Liked",
                                              like: () {
                                                likeComment.groupId =
                                                    groupDetailsProvider
                                                        .groupDetails.id;
                                                likeComment.postId =
                                                    groupPostProvider
                                                        .groupPosts![index].id
                                                        .toString();
                                                likeComment.like();
                                                refresh();
                                              },
                                              comment: () {
                                                likeComment.groupId =
                                                    groupDetailsProvider
                                                        .groupDetails.id;
                                                likeComment.postId =
                                                    groupPostProvider
                                                        .groupPosts![index].id
                                                        .toString();
                                                Get.to(
                                                    const GroupCommentsScreen());
                                              },
                                              share: () {
                                                // likeComment.pageId =
                                                //     groupPostProvider
                                                //         .pagePosts![index]
                                                //         .page
                                                //         .id;
                                                // likeComment.postId =
                                                //     groupPostProvider
                                                //         .pagePosts![index].id
                                                //         .toString();
                                                // Get.to(
                                                //     const PagePostShareScreen());
                                              },
                                              likeIconColor: (groupPostProvider
                                                          .groupPosts![index]
                                                          .like ==
                                                      false)
                                                  ? Colors.black
                                                  : Colors.red,
                                            );
                                          })
                                        ],
                                      );
                                    })),
                              ],
                            ),
                          ),
                        );
                      })
                    ],
                  ),
                  const GroupImagesTab(), //vedios
                  const GroupvideosTab(), //photos
                  const GroupMembersTab(), //photos
                ],
              )),
        ));
  }
}
