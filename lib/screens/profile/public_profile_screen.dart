import 'package:als_frontend/old_code/const/palette.dart';
import 'package:als_frontend/provider/chat_provider.dart';
import 'package:als_frontend/provider/newsfeed_provider.dart';
import 'package:als_frontend/provider/profile_provider.dart';
import 'package:als_frontend/provider/public_profile_provider.dart';
import 'package:als_frontend/screens/chat/message_screen.dart';
import 'package:als_frontend/screens/home/widget/timeline_widget.dart';
import 'package:als_frontend/screens/page/widget/cover_photo_widget.dart';
import 'package:als_frontend/screens/profile/shimmer_effect/profile_post_%20shimmer_widget.dart';
import 'package:als_frontend/screens/profile/view/public_photo_video_screen.dart';
import 'package:als_frontend/screens/profile/widget/profile_details_card.dart';
import 'package:als_frontend/screens/profile/widget/profile_photo_widget.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:als_frontend/widgets/single_image_view.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PublicProfileScreen extends StatefulWidget {
  final String userID;
  final int index;
  final bool isFromFriendRequestScreen;
  final bool isFromFriendScreen;

  const PublicProfileScreen(this.userID,
      {this.index = -1, this.isFromFriendRequestScreen = false, this.isFromFriendScreen = false, Key? key})
      : super(key: key);

  @override
  State<PublicProfileScreen> createState() => _PublicProfileScreenState();
}

class _PublicProfileScreenState extends State<PublicProfileScreen> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<PublicProfileProvider>(context, listen: false).callForPublicProfileData(widget.userID);

    Provider.of<PublicProfileProvider>(context, listen: false)
        .initializeAllUserPostData((bool status) {}, widget.userID, isFirstTime: true);
    controller.addListener(() {
      if (controller.offset >= controller.position.maxScrollExtent &&
          !controller.position.outOfRange &&
          Provider.of<PublicProfileProvider>(context, listen: false).hasNextData) {
        Provider.of<PublicProfileProvider>(context, listen: false).updatePageNo(widget.userID);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<PublicProfileProvider>(
        builder: (context, publicProvider, child) => SafeArea(
            child: (publicProvider.isProfileLoading == true || publicProvider.isLoading == true)
                ? const profilePostShimmerWidget()
                : SingleChildScrollView(
                    controller: controller,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(height: 230, width: width, color: Colors.white),
                          CoverPhotoWidget(
                              isTrue: false,
                              back: () {
                                Get.back();
                              },
                              viewCoverPhoto: () {
                                Get.to(() => SingleImageView(imageURL: publicProvider.publicProfileData.coverImage!));
                              },
                              coverPhoto: (publicProvider.publicProfileData.coverImage != null)
                                  ? publicProvider.publicProfileData.coverImage!
                                  : "https://meektecbacekend.s3.amazonaws.com/media/profile/default.jpeg",
                              coverPhotoChange: () {}),
                          Positioned(
                            bottom: 0,
                            left: 30,
                            child: ProfilePhotoWidget(
                              viewProfilePhoto: () {
                                Get.to(() => SingleImageView(imageURL: publicProvider.publicProfileData.profileImage!));
                              },
                              isTrue: false,
                              profileImage: (publicProvider.publicProfileData.profileImage != null)
                                  ? publicProvider.publicProfileData.profileImage!
                                  : "https://meektecbacekend.s3.amazonaws.com/media/profile/default.jpeg",
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 9),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: CustomText(
                          title: "${publicProvider.publicProfileData.firstName!} ${publicProvider.publicProfileData.lastName!}",
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      //TODO: for message Button section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              margin: const EdgeInsets.only(right: 15),
                              child: ElevatedButton(
                                child: const Text("Message"),
                                onPressed: () {
                                  Provider.of<ChatProvider>(context, listen: false).resetOneTime();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MessagesScreen(
                                                isFromProfile: true,
                                                customerID: int.parse(widget.userID),
                                                name:
                                                    '${publicProvider.publicProfileData.firstName!} ${publicProvider.publicProfileData.lastName!}',
                                                imageURL: (publicProvider.publicProfileData.profileImage != null)
                                                    ? publicProvider.publicProfileData.profileImage!
                                                    : "https://meektecbacekend.s3.amazonaws.com/media/profile/default.jpeg",
                                              )));
                                },
                              ),
                            ),
                            (publicProvider.publicProfileData.isFriend == false)
                                ? (publicProvider.publicProfileData.friendRequestSent == true)
                                    ? Expanded(
                                        child: ElevatedButton(
                                          child: const Text("Cancel Friend request"),
                                          onPressed: () {
                                            publicProvider.cancelFriendRequest((bool status) {
                                              if (status) {
                                                if (widget.isFromFriendRequestScreen) {
                                                  Provider.of<ProfileProvider>(context, listen: false)
                                                      .removeRequestAfterCancelRequest(widget.index);
                                                }
                                              }
                                            });
                                          },
                                        ),
                                      )
                                    : (publicProvider.publicProfileData.friendRequestAccept == true)
                                        ? Expanded(
                                            child: ElevatedButton(
                                              child: const Text("Accept friend request"),
                                              onPressed: () {
                                                Provider.of<ProfileProvider>(context, listen: false)
                                                    .acceptFriendRequest(
                                                        publicProvider.publicProfileData.friendRquestAcceptId.toString(), widget.index,
                                                        isFromFriendRequest: widget.isFromFriendRequestScreen)
                                                    .then((value) {
                                                  if (value) {
                                                    publicProvider.acceptFriendRequest();
                                                  }
                                                });

                                              },
                                            ),
                                          )
                                        : Expanded(
                                            child: ElevatedButton(
                                              child: const Text("Add friend"),
                                              onPressed: () {
                                                publicProvider.sendFriendRequest((bool status) {
                                                  if (status && widget.isFromFriendRequestScreen) {
                                                    Provider.of<ProfileProvider>(context, listen: false).callForgetAllFriendRequest();
                                                  }
                                                });
                                              },
                                            ),
                                          )
                                : Expanded(
                                    child: ElevatedButton(
                                      child: const Text("Unfriend"),
                                      onPressed: () {
                                        publicProvider.unFriend((bool status) {
                                          if (widget.isFromFriendScreen) {
                                            Provider.of<ProfileProvider>(context, listen: false).removeFriend(widget.index);
                                          }
                                        });
                                      },
                                    ),
                                  ),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              height: height * 0.047,
                              width: width * 0.1,
                              decoration: BoxDecoration(color: Colors.white60, borderRadius: BorderRadius.circular(7)),
                              child: Center(
                                child: IconButton(
                                    icon: const Icon(Icons.more_horiz),
                                    onPressed: () => showDialog(
                                          context: context,
                                          builder: (ctx) => publicProvider.isBlockLoading
                                              ? const Center(child: CircularProgressIndicator())
                                              : AlertDialog(
                                                  title: Text(
                                                    "Do you want to block this User ?",
                                                    style: latoStyle800ExtraBold,
                                                  ),
                                                  actions: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        ElevatedButton(
                                                            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                                                            onPressed: () {
                                                              Navigator.of(ctx).pop();
                                                            },
                                                            child: const Text("Cancel", style: button)),
                                                        const SizedBox(width: 15),
                                                        ElevatedButton(
                                                            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                                            onPressed: () {
                                                              publicProvider.blockUser(publicProvider.publicProfileData.id!).then((value) {
                                                                if (value) {
                                                                  Provider.of<NewsFeedProvider>(context, listen: false)
                                                                      .afterBlockRemoveUserPosts(publicProvider.publicProfileData.id!);

                                                                  Navigator.of(context).pop();
                                                                  Navigator.of(context).pop();
                                                                }
                                                              });
                                                            },
                                                            child: const Text("Block", style: button)),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                        )),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: height * 0.043,
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(4))),
                        child: Padding(
                          padding: EdgeInsets.only(left: width * 0.1),
                          child: Row(
                            children: [
                              Text(
                                "${publicProvider.publicProfileData.friends!.length}",
                                style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w500, color: Palette.notificationColor),
                              ),
                              Text(" Friends", style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w500)),
                              SizedBox(
                                width: width * 0.2,
                              ),
                              Text(
                                "${publicProvider.publicProfileData.followers!.length}",
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
                      SizedBox(height: height * 0.01),
                      ProfileDetailsCard(userProfileModel: publicProvider.publicProfileData, isShowEditProfile: false),
                      SizedBox(height: height * 0.01),
                      Container(
                        height: 35,
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [
                          BoxShadow(color: Colors.grey.withOpacity(.2), blurRadius: 10.0, spreadRadius: 3.0, offset: const Offset(0.0, 0.0))
                        ]),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => PublicPhotoViewScreen(widget.userID)));
                                },
                                child: Container(
                                  height: 35,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5))),
                                  child: CustomText(title: 'PHOTOS'),
                                ),
                              ),
                            ),
                            Container(
                                height: 35,
                                width: 2,
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10))),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (_) => PublicPhotoViewScreen(widget.userID, isForImage: false)));
                                },
                                child: Container(
                                  height: 35,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5))),
                                  child: CustomText(title: 'VIDEOS'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: publicProvider.publicNewsFeedLists.length,
                          itemBuilder: ((context, index) {
                            return TimeLineWidget(publicProvider.publicNewsFeedLists[index], index, publicProvider, isProfileScreen: true);
                          }))
                    ]))),
      ),
    );
  }
}
