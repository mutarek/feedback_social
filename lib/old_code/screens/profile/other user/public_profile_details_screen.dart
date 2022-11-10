import 'package:als_frontend/old_code/const/palette.dart';
import 'package:als_frontend/old_code/provider/provider.dart';
import 'package:als_frontend/old_code/screens/profile/user_photos_tab.dart';
import 'package:als_frontend/old_code/screens/profile/user_videos_tab.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../widgets/widgets.dart';
import '../../screens.dart';

class PublicProfileDetailsScreen extends StatefulWidget {
  const PublicProfileDetailsScreen({Key? key}) : super(key: key);

  @override
  State<PublicProfileDetailsScreen> createState() => _PublicProfileDetailsScreenState();
}

class _PublicProfileDetailsScreenState extends State<PublicProfileDetailsScreen> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    final publicNewsfeedPostProvider = Provider.of<PublicNewsfeedPostProvider>(context, listen: false);
    publicNewsfeedPostProvider.authorPostResults = [];
    final value = Provider.of<PublicProfileDetailsProvider>(context, listen: false);
    value.getUserData();
    final profileImages = Provider.of<ProfileImagesProvider>(context, listen: false);
    profileImages.userId = value.id;

    final profileVideo = Provider.of<ProfileVideosProvider>(context, listen: false);
    profileVideo.userId = value.id;

    final userNewsFeed = Provider.of<PublicNewsfeedPostProvider>(context, listen: false);
    userNewsFeed.getData();
    controller.addListener(() {
      if (controller.offset >= controller.position.maxScrollExtent && !controller.position.outOfRange) {
        userNewsFeed.getData();
      }
    });
    super.initState();
  }

  void refresh() {
    final value = Provider.of<PublicProfileDetailsProvider>(context, listen: false);
    value.getUserData();
    final userNewsFeed = Provider.of<PublicNewsfeedPostProvider>(context, listen: false);
    userNewsFeed.getData();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Palette.scaffold,
        body: DefaultTabController(
          length: 3,
          child: NestedScrollView(
            controller: controller,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            // Setting floatHeaderSlivers to true is required in order to float
            // the outer slivers over the inner scrollable.
            floatHeaderSlivers: true,

            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverList(
                    delegate: SliverChildListDelegate([
                  SafeArea(child: Consumer2<PublicProfileDetailsProvider, ProfileImagesProvider>(
                      builder: (context, provider, profileImageProvider, child) {
                    return (provider.loading == false)
                        ? const Center(child: CupertinoActivityIndicator())
                        : SingleChildScrollView(
                            child: Column(children: [
                            SizedBox(
                              height: height * 0.33,
                              child: Stack(
                                children: [
                                  CoverPhotoWidget(
                                      isTrue: false,
                                      back: () {
                                        Get.back();
                                      },
                                      viewCoverPhoto: () {
                                        profileImageProvider.imageUrl = provider.userprofileData!.coverImage!;
                                        Get.to(() => const SingleImageView());
                                      },
                                      coverPhoto: (provider.userprofileData! != null)
                                          ? provider.userprofileData!.coverImage!
                                          : "https://meektecbacekend.s3.amazonaws.com/media/profile/default.jpeg",
                                      coverPhotoChange: () {}),
                                  Positioned(
                                    top: height * 0.23,
                                    child: Container(
                                      height: height * 0.1,
                                      width: width,
                                      decoration: const BoxDecoration(
                                        color: Palette.scaffold,
                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(left: width * 0.05, right: width * 0.05, bottom: height * 0.01),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${provider.userprofileData!.firstName!} ${provider.userprofileData!.lastName!}",
                                              style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.w700),
                                            ),
                                            const Spacer(),
                                            Consumer3<AddFriendProvider, UnFriendProvider, ConfirmFriendRequestProvider>(
                                                builder: (context, addProvider, unfriendProvider, confirmFriendRequest, child) {
                                              return Padding(
                                                  padding: EdgeInsets.only(top: height * 0.06, left: width * 0.02),
                                                  child: (provider.userprofileData!.isFriend == false)
                                                      ? (provider.userprofileData!.friendRequestSent == true)
                                                          ? ElevatedButton(
                                                              child: const Text("Friend request sent"),
                                                              onPressed: () {
                                                                confirmFriendRequest.id = provider.userprofileData!.friendRequestSentId;
                                                                confirmFriendRequest.unSendRequest();
                                                                refresh();
                                                              },
                                                            )
                                                          : (provider.userprofileData!.friendRequestAccept == true)
                                                              ? ElevatedButton(
                                                                  child: const Text("Accept friend request"),
                                                                  onPressed: () {
                                                                    confirmFriendRequest.id =
                                                                        provider.userprofileData!.friendRquestAcceptId;

                                                                    confirmFriendRequest.confirmRequest();

                                                                    refresh();
                                                                  },
                                                                )
                                                              : ElevatedButton(
                                                                  child: const Text("Add friend"),
                                                                  onPressed: () {
                                                                    addProvider.id = provider.userprofileData!.id;
                                                                    addProvider.addSuggestedFriend();
                                                                    refresh();
                                                                  },
                                                                )
                                                      : ElevatedButton(
                                                          child: const Text("Unfriend"),
                                                          onPressed: () {
                                                            unfriendProvider.id = provider.userprofileData!.id;
                                                            unfriendProvider.unFriend();
                                                            refresh();
                                                          },
                                                        ));
                                            })
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  ProfilePhotoWidget(
                                    viewProfilePhoto: () {
                                      profileImageProvider.imageUrl = provider.userprofileData!.profileImage!;
                                      Get.to(() => const SingleImageView());
                                    },
                                    isTrue: false,

                                    profileImage: (provider.userprofileData != null)
                                        ? provider.userprofileData!.profileImage!
                                        : "https://meektecbacekend.s3.amazonaws.com/media/profile/default.jpeg",
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: height * 0.043,
                              width: width * 0.92,
                              decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(4))),
                              child: Padding(
                                padding: EdgeInsets.only(left: width * 0.1),
                                child: Row(
                                  children: [
                                    Text(
                                      "${provider.userprofileData!.friends!.length}",
                                      style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w500, color: Palette.notificationColor),
                                    ),
                                    Text(" Friends", style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w500)),
                                    SizedBox(
                                      width: width * 0.2,
                                    ),
                                    Text(
                                      "${provider.userprofileData!.followers!.length}",
                                      style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w500, color: Palette.notificationColor),
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
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Container(
                              color: Colors.white,
                              width: width * .92,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Visibility(
                                      visible: provider.userprofileData!.presentCompany == "" ? false : true,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                FontAwesomeIcons.briefcase,
                                                size: height * 0.019,
                                              ),
                                              SizedBox(
                                                width: width * 0.03,
                                              ),
                                              Text(
                                                "Company Name: ",
                                                style: GoogleFonts.lato(
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Text(
                                                provider.userprofileData!.presentCompany.toString(),
                                                style: GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.w700),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: height * 0.009,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Visibility(
                                      visible: provider.userprofileData!.presentEducation == "" ? false : true,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                FontAwesomeIcons.graduationCap,
                                                size: height * 0.019,
                                              ),
                                              SizedBox(
                                                width: width * 0.03,
                                              ),
                                              Text(
                                                "Education: ",
                                                style: GoogleFonts.lato(
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Text(
                                                provider.userprofileData!.presentEducation.toString(),
                                                style: GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.w700),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: height * 0.009,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Visibility(
                                      visible: provider.userprofileData!.gender == "" ? false : true,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                FontAwesomeIcons.user,
                                                size: height * 0.019,
                                              ),
                                              SizedBox(
                                                width: width * 0.03,
                                              ),
                                              Text(
                                                "Gender: ",
                                                style: GoogleFonts.lato(
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Text(
                                                provider.userprofileData!.gender.toString(),
                                                style: GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.w700),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: height * 0.009,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Visibility(
                                      visible: provider.userprofileData!.religion == "" ? false : true,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                FontAwesomeIcons.personPraying,
                                                size: height * 0.019,
                                              ),
                                              SizedBox(
                                                width: width * 0.03,
                                              ),
                                              Text(
                                                "Religion: ",
                                                style: GoogleFonts.lato(
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Text(
                                                provider.userprofileData!.religion.toString(),
                                                style: GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.w700),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: height * 0.009,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Visibility(
                                      visible: provider.userprofileData!.livesInAddress == "" ? false : true,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                FontAwesomeIcons.locationDot,
                                                size: height * 0.019,
                                              ),
                                              SizedBox(
                                                width: width * 0.03,
                                              ),
                                              Text(
                                                "Lives in: ",
                                                style: GoogleFonts.lato(
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Text(
                                                provider.userprofileData!.livesInAddress.toString(),
                                                style: GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.w700),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: height * 0.009,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Visibility(
                                      visible: provider.userprofileData!.fromAddress == "" ? false : true,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                FontAwesomeIcons.house,
                                                size: height * 0.019,
                                              ),
                                              SizedBox(
                                                width: width * 0.03,
                                              ),
                                              Text(
                                                "Home town: ",
                                                style: GoogleFonts.lato(
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Text(
                                                provider.userprofileData!.fromAddress.toString(),
                                                style: GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.w700),
                                              ),
                                              SizedBox(
                                                height: height * 0.009,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: height * 0.035,
                                width: width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Colors.white60,
                                ),
                                child: TabBar(labelColor: Colors.black, tabs: [
                                  Text(
                                    "Posts",
                                    style: TextStyle(fontSize: height * 0.013),
                                  ),
                                  Text(
                                    "Photos",
                                    style: TextStyle(fontSize: height * 0.013),
                                  ),
                                  Text(
                                    "videos",
                                    style: TextStyle(fontSize: height * 0.013),
                                  ),
                                ]),
                              ),
                            )
                          ]));
                  })),
                ]))
              ];
            },
            body: TabBarView(
              children: [
                // OtherUserPostTab(height: height,),
                SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: Consumer3<PublicNewsfeedPostProvider, PostImagesPreviewProvider, SingleVideoShowProvider>(
                      builder: (context, userPostProvider, postImageProvider, singleVideoShowProvider, child) {
                    return Column(
                      children: [
                        /*----------------------------------------Newsfeed---------------------------------*/
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: userPostProvider.authorPostResults.length + 1,
                            itemBuilder: ((context, index) {
                              if (index < userPostProvider.authorPostResults.length) {
                                return (userPostProvider.authorPostResults.isEmpty)
                                    ? const Center(child: Text("Loading..."))
                                    : Padding(
                                        padding: EdgeInsets.only(left: width * 0.04, right: width * 0.04),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            PostHeader(
                                                moreOnPressed: () {},
                                                postType: "timeline",
                                                delete: () {},
                                                edit: () {},
                                                reportThisPost: () {},
                                                name: userPostProvider.authorPostResults[index].author!.fullName,
                                                time: userPostProvider.authorPostResults[index].timestamp,
                                                profileImage: userPostProvider.authorPostResults[index].author!.profileImage,
                                                onProfileTap: () {}),
                                            Text(userPostProvider.authorPostResults[index].description!),
                                            SizedBox(
                                                height: (userPostProvider.authorPostResults[index].totalImage != 0)
                                                    ? (userPostProvider.authorPostResults[index].totalImage == 1)
                                                        ? height * 0.35
                                                        : ((userPostProvider.authorPostResults[index].totalImage == 2))
                                                            ? height * 0.2
                                                            : height * 0.5
                                                    : 0,
                                                child: (userPostProvider.authorPostResults[index].totalImage == 1)
                                                    ? InkWell(
                                                        onTap: () {
                                                          postImageProvider.iamges = [];

                                                          postImageProvider.iamges
                                                              .add(userPostProvider.authorPostResults[index].images![0].image);
                                                          Get.to(() => const PostImagesPreview());
                                                        },
                                                        child: CachedNetworkImage(
                                                            imageUrl: userPostProvider.authorPostResults[index].images![0].image!,
                                                            imageBuilder: (context, imageProvider) => Container(
                                                                height: height * 0.35,
                                                                decoration: BoxDecoration(
                                                                    image: DecorationImage(image: imageProvider, fit: BoxFit.scaleDown))),
                                                            placeholder: ((context, url) => Container(
                                                                  alignment: Alignment.center,
                                                                  child: const CupertinoActivityIndicator(),
                                                                ))),
                                                      )
                                                    : GridView.builder(
                                                        physics: const NeverScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount:
                                                              (userPostProvider.authorPostResults[index].totalImage == 1) ? 1 : 2,
                                                          crossAxisSpacing: 2.0,
                                                          mainAxisSpacing: 2.0,
                                                        ),
                                                        itemCount: (userPostProvider.authorPostResults[index].totalImage!.toInt() < 4)
                                                            ? userPostProvider.authorPostResults[index].totalImage!.toInt()
                                                            : 4,
                                                        itemBuilder: (context, index2) {
                                                          return InkWell(
                                                            onTap: () {
                                                              postImageProvider.iamges = [];
                                                              for (int i = 0;
                                                                  i < userPostProvider.authorPostResults[index].images!.length;
                                                                  i++) {
                                                                postImageProvider.iamges
                                                                    .add(userPostProvider.authorPostResults[index].images![i].image);
                                                                Get.to(() => const PostImagesPreview());
                                                              }
                                                            },
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                (userPostProvider.authorPostResults[index].totalImage! > 4 && index2 == 3)
                                                                    ? Container(
                                                                        height: height * 0.22,
                                                                        child: Center(
                                                                          child: Text(
                                                                            "+${userPostProvider.authorPostResults[index].totalImage!}",
                                                                            style: const TextStyle(
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 26,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        decoration: BoxDecoration(
                                                                            image: DecorationImage(
                                                                          image: NetworkImage(userPostProvider
                                                                              .authorPostResults[index].images![index2].image!),
                                                                          fit: BoxFit.scaleDown,
                                                                        )),
                                                                      )
                                                                    : CachedNetworkImage(
                                                                        imageUrl: userPostProvider
                                                                            .authorPostResults[index].images![index2].image!,
                                                                        imageBuilder: (context, imageProvider) => Container(
                                                                            width: 400,
                                                                            height: height * 0.22,
                                                                            decoration: BoxDecoration(
                                                                                image: DecorationImage(
                                                                                    image: imageProvider, fit: BoxFit.scaleDown))),
                                                                        placeholder: ((context, url) => Container(
                                                                              alignment: Alignment.center,
                                                                              child: const CupertinoActivityIndicator(),
                                                                            )))
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      )),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            (userPostProvider.authorPostResults[index].totalVideo != 0)
                                                ? InkWell(
                                                    onTap: () {
                                                      singleVideoShowProvider.videoUrl =
                                                          userPostProvider.authorPostResults[index].videos![0].video!;
                                                      Get.to(() => const VideoDetailsScreen());
                                                    },
                                                    child: Container(
                                                      height: 150,
                                                      width: width,
                                                      child: (userPostProvider.authorPostResults[index].videos![0].thumbnail != null)
                                                          ? Container(
                                                              child: const Icon(
                                                                Icons.play_circle_fill,
                                                                size: 60,
                                                                color: Colors.grey,
                                                              ),
                                                              decoration: BoxDecoration(
                                                                  image: DecorationImage(
                                                                      image: NetworkImage(userPostProvider
                                                                          .authorPostResults[index].videos![0].thumbnail!))),
                                                            )
                                                          : Image.asset("assets/background/video_pause.jpg"),
                                                      color: Colors.black,
                                                    ),
                                                  )
                                                : Container(),
                                            LikeCommentCount(
                                              editOnPressed: () {
                                                Get.to(() => const ReportPagePostScreen());
                                              },
                                              editText: const Icon(
                                                Icons.report,
                                                color: Colors.orange,
                                              ),
                                              likeCount: userPostProvider.authorPostResults[index].totalLike!.toInt(),
                                              commentCount: userPostProvider.authorPostResults[index].totalComment!.toInt(),
                                              likeCountColor:
                                                  (userPostProvider.authorPostResults[index].like == false) ? Colors.black : Colors.red,
                                              likeText: (userPostProvider.authorPostResults[index].like == true) ? "Liked" : "like",
                                            ),
                                            Consumer<LikeCommentShareProvider>(builder: (context, likeComment, child) {
                                              return LikeCommentShare(
                                                likeText: "Liked",
                                                index: index,
                                                like: () {
                                                  likeComment.postId = userPostProvider.authorPostResults[index].id.toString();
                                                  likeComment.like();
                                                  refresh();
                                                },
                                                comment: () {
                                                  likeComment.postId = userPostProvider.authorPostResults[index].id.toString();
                                                  userPostProvider.index = index;
                                                  // Get.to(CommentsScreen(index,userPostProvider.authorPostResults[index].id as int));
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
                                                likeIconColor:
                                                    (userPostProvider.authorPostResults[index].like == false) ? Colors.black : Colors.red,
                                              );
                                            })
                                          ],
                                        ),
                                      );
                              } else {
                                return Center(
                                    child: (userPostProvider.hasdata)
                                        ? const CupertinoActivityIndicator()
                                        : const Text("No more data to post"));
                              }
                            }))
                      ],
                    );
                  }),
                ),
                const UserPhotosTab(),
                const UserVideoTab(), //vedios
                //photos
                //photos
              ],
            ),
          ),
        ));
  }
}
