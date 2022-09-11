import 'package:als_frontend/const/palette.dart';
import 'package:als_frontend/screens/profile/user_photos_tab.dart';
import 'package:als_frontend/screens/profile/user_videos_tab.dart';
import 'package:als_frontend/screens/screens.dart';
import 'package:flutter/material.dart';

import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../provider/provider.dart';
import '../../../widgets/widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final bool togglevalue = false;

  @override
  void initState() {
    final value = Provider.of<UserProfileProvider>(context, listen: false);
    value.getUserData();
    final userNewsFeed =
        Provider.of<UserNewsfeedPostProvider>(context, listen: false);
    userNewsFeed.getData();
    final profileImages =
        Provider.of<ProfileImagesProvider>(context, listen: false);
    profileImages.userId = userNewsFeed.id;
    final profileVideo =
        Provider.of<ProfileVideosProvider>(context, listen: false);
    profileVideo.userId = userNewsFeed.id;
    super.initState();
  }

  void refresh(){
    final userNewsFeed =
        Provider.of<UserNewsfeedPostProvider>(context, listen: false);
    userNewsFeed.getData();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            body: DefaultTabController(
          length: 3,
          child: NestedScrollView(
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
                  SafeArea(child: Consumer4<UserProfileProvider,
                          UpdateProfileImageProvider, UpdateCoverPhotProvider,
                          ProfileImagesProvider>(
                      builder: (context, provider, profileImageProvider,
                          coverPhotoProvider, profileImages, child) {
                    return (provider.loading == true)
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                Container(
                                  height: height * 0.3,
                                  width: width,
                                  color: Palette.notificationColor,
                                  child: Stack(
                                    children: [
                                      CoverPhotoWidget(
                                          back: () {
                                            Get.to(const NavScreen());
                                          },
                                          viewCoverPhoto: () {
                                             profileImages.imageUrl = provider
                                                .userprofileData.coverImage!;
                                            Get.to(
                                                () => const SingleImageView());
                                          },
                                          coverphoto: (provider.loading ==
                                                  false)
                                              ? provider
                                                  .userprofileData.coverImage!
                                              : "https://meektecbacekend.s3.amazonaws.com/media/profile/default.jpeg",
                                          coverphotochange: () {
                                            coverPhotoProvider.imageUrl =
                                                provider.userprofileData
                                                    .coverImage!;
                                            Get.to(
                                                () => const UpdateCoverPhoto());
                                          }),
                                      Positioned(
                                        top: height * 0.21,
                                        child: Container(
                                          height: height * 0.1,
                                          width: width,
                                          decoration: const BoxDecoration(
                                            color: Palette.scaffold,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                          ),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: height * 0.045,
                                                          left: width * 0.02),
                                                      child: Text(
                                                        "${provider.userprofileData.firstName!} ${provider.userprofileData.lastName!}",
                                                        style: GoogleFonts.lato(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ), //name and lock bottun
                                            ],
                                          ),
                                        ),
                                      ),
                                      ProfilePhotowidget(
                                        viewProfilePhoto: () {
                                          profileImages.imageUrl =
                                              provider
                                              .userprofileData.profileImage!;
                                          Get.to(() => const SingleImageView());
                                        },
                                        profilePhotoChange: () {
                                          profileImageProvider.imageUrl =
                                              provider.userprofileData
                                                  .profileImage!;
                                          Get.to(
                                              () => const UpdateProfileImage());
                                        },
                                        profileImage: (provider.loading ==
                                                false)
                                            ? provider
                                                .userprofileData.profileImage!
                                            : "https://meektecbacekend.s3.amazonaws.com/media/profile/default.jpeg",
                                      ),
                                    ],
                                  ),
                                ),

                                Container(
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
                                ), //following
                                SizedBox(
                                  height: height * 0.009,
                                ),
                                const ProfileDetailsCard(),
                                Card(
                                  color: Palette.scaffold,
                                  child: Container(
                                    width: width * .92,
                                    color: Palette.scaffold,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: height * 0.035,
                                            width: width,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                              color: Colors.white60,
                                            ),
                                            child: TabBar(
                                                labelColor: Colors.black,
                                                tabs: [
                                                  Text(
                                                    "Posts",
                                                    style: TextStyle(
                                                        fontSize:
                                                            height * 0.013),
                                                  ),
                                                  Text(
                                                    "Photos",
                                                    style: TextStyle(
                                                        fontSize:
                                                            height * 0.013),
                                                  ),
                                                  Text(
                                                    "videos",
                                                    style: TextStyle(
                                                        fontSize:
                                                            height * 0.013),
                                                  ),
                                                ]),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                  })),
                ]))
              ];
            },
            body: TabBarView(
              children: [
                SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: Consumer5<UserNewsfeedPostProvider, PostImagesPreviewProvider, CreatePostProvider, SinglePostProvider, SingleVideoShowProvider>(
                      builder: (context, userPostProvider, postImageProvider, createPostProvider,singlePostProvider, singleVideoShowProvider, child) {
                    return Padding(
                      padding: EdgeInsets.only(left: width*0.04, right: width * 0.04),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /*----------------------------------------Newsfeed---------------------------------*/
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: userPostProvider.authorPosts!.length,
                              itemBuilder: ((context, index) {
                                return (userPostProvider.authorPosts!.isEmpty)
                                    ? const Center(child: Text("Loading..."))
                                    : Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          PostHeader(
                                            moreOnPressed: (){
                                              
                                            },
                                              postType: "timeline",
                                              delete: () {},
                                              edit: () {},
                                              reportThisPost: () {},
                                              name: userPostProvider
                                                  .authorPosts![index]
                                                  .author
                                                  .fullName,
                                              time: userPostProvider
                                                  .authorPosts![index].timestamp,
                                              profileImage: userPostProvider
                                                  .authorPosts![index]
                                                  .author
                                                  .profileImage,
                                              onProfileTap: () {}),
                                          Text(userPostProvider
                                              .authorPosts![index].description),
                                          SizedBox(
                                            height: (userPostProvider
                                                        .authorPosts![index]
                                                        .totalImage !=
                                                    0)
                                                ? 200
                                                : 0,
                                            child: (userPostProvider
                                                    .authorPosts![index]
                                                    .totalImage == 1)?
                                              InkWell(
                                                onTap: (){
                                                  postImageProvider.iamges =
                                                          [];

                                                      postImageProvider.iamges
                                                          .add(userPostProvider
                                                              .authorPosts![
                                                                  index]
                                                              .images[0]
                                                              .image);
                                                      Get.to(() =>
                                                          const PostImagesPreview());
                                                },
                                                child: Center(
                                                  child: Container(
                                                    color: Colors.white,
                                                    height: 200,
                                                    width: width,
                                                    child: Image.network(
                                                        userPostProvider
                                                            .authorPosts![index]
                                                            .images[0]
                                                            .image,
                                                        fit: BoxFit.contain,
                                                        )
                                                  ),
                                                ),
                                              )
                                                    
                                              :Expanded(
                                              child: GridView.builder(
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  crossAxisSpacing: 0.0,
                                                  mainAxisSpacing: 0.0,
                                                ),
                                                itemCount: userPostProvider
                                                    .authorPosts![index]
                                                    .totalImage,
                                                itemBuilder: (context, index2) {
                                                  return Column(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                                postImageProvider
                                                                    .iamges = [];
                                                                for (int i = 0;
                                                                    i <
                                                                        userPostProvider
                                                                            .authorPosts![index]
                                                                            .images
                                                                            .length;
                                                                    i++) {
                                                                  postImageProvider
                                                                      .iamges
                                                                      .add(userPostProvider
                                                                          .authorPosts![
                                                                              index]
                                                                          .images[
                                                                              i]
                                                                          .image);
                                                                  Get.to(() =>
                                                                      const PostImagesPreview());
                                                                }
                                                              },
                                                              child: Expanded(
                                                                child: SizedBox(
                                                                  height: 100,
                                                                  child: Image
                                                                      .network(
                                                                    userPostProvider
                                                                        .authorPosts![
                                                                            index]
                                                                        .images[
                                                                            index2]
                                                                        .image,
                                                                    fit: BoxFit
                                                                        .contain,
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        );
                                                      },
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10,),
                                          (userPostProvider
                                                        .authorPosts![index]
                                                        .totalVideo !=
                                                    0)?
                                          InkWell(
                                            onTap: (){
                                              singleVideoShowProvider.videoUrl =  userPostProvider.authorPosts![index].videos[0].video;
                                              Get.to(()=> const ShowVideoPage());
                                            },
                                            child: Container(
                                            height: 150,
                                            width: width,
                                            child: Image.asset("assets/background/video_pause.jpg"),
                                            color: Colors.black,
                                           ),
                                         )
                                          :Container(),
                                          LikeCommentCount(
                                            editOnPressed: (){
                                               singlePostProvider.description =
                                                  userPostProvider
                                                  .authorPosts![index]
                                                  .description;
                                              createPostProvider.postId =
                                                  userPostProvider
                                                      .authorPosts![index].id;
                                              Get.to(
                                                  () => const EditPostScreen());
                                            },
                                            editText: "Edit",
                                            likeCount: userPostProvider
                                                .authorPosts![index].totalLike,
                                            commentCount: userPostProvider
                                                .authorPosts![index].totalComment,
                                            likeCountColor: (userPostProvider
                                                        .authorPosts![index]
                                                        .like ==
                                                    false)
                                                ? Colors.black
                                                : Colors.red,
                                            likeText: (userPostProvider.authorPosts![index].like == true)?"Liked" : "Like",
                                          ),
                                          Consumer<LikeCommentShareProvider>(
                                              builder:
                                                  (context, likeComment, child) {
                                            return LikeCommentShare(
                                              likeText: "Liked",
                                              like: () {
                                                likeComment.postId =
                                                    userPostProvider
                                                        .authorPosts![index].id
                                                        .toString();
                                                likeComment.like();
                                                refresh();
                                              },
                                              comment: () {
                                                likeComment.postId =
                                                    userPostProvider
                                                        .authorPosts![index].id
                                                        .toString();
                                                userPostProvider.index = index;
                                                Get.to(
                                                    const UserPostCommentsScreen());
                                              },
                                              share: () {
                                                // likeComment.pageId =
                                                //     userPostProvider
                                                //         .authorPosts![index]
                                                //         .page
                                                //         .id;
                                                // likeComment.postId =
                                                //     userPostProvider
                                                //         .authorPosts![index].id
                                                //         .toString();
                                                // Get.to(
                                                //     const authorPostshareScreen());
                                              },
                                              likeIconColor: (userPostProvider
                                                          .authorPosts![index]
                                                          .like ==
                                                      false)
                                                  ? Colors.black
                                                  : Colors.red,
                                            );
                                          })
                                        ],
                                      );
                              }))
                        ],
                      ),
                    );
                  }),
                ),
                // UserPostTab(height: height),
                //  UserVideoTab(), //vedios //vedios
                const UserPhotosTab(), //photos
                // const Text("Photos Tab"),
                const UserVideoTab()
              ],
            ),
          ),
        )));
  }
}
