import 'package:als_frontend/old_code/const/palette.dart';
import 'package:als_frontend/provider/public_profile_provider.dart';
import 'package:als_frontend/screens/page/widget/cover_photo_widget.dart';
import 'package:als_frontend/screens/profile/widget/profile_details_card.dart';
import 'package:als_frontend/screens/profile/widget/profile_photo_widget.dart';
import 'package:als_frontend/widgets/single_image_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PublicProfileScreen extends StatefulWidget {
  final String userID;

  const PublicProfileScreen(this.userID, {Key? key}) : super(key: key);

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
    Provider.of<PublicProfileProvider>(context, listen: false).initializeAllUserPostData((bool status) {}, isFirstTime: true);
    controller.addListener(() {
      if (controller.offset >= controller.position.maxScrollExtent &&
          !controller.position.outOfRange &&
          Provider.of<PublicProfileProvider>(context, listen: false).hasNextData) {
        Provider.of<PublicProfileProvider>(context, listen: false).updatePageNo();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Palette.scaffold,
      body: Consumer<PublicProfileProvider>(
        builder: (context, provider, child) => DefaultTabController(
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
                  SafeArea(
                      child: (provider.isProfileLoading == true)
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
                                          Get.to(() => SingleImageView(imageURL: provider.publicProfileData.coverImage!));
                                        },
                                        coverphoto: (provider.publicProfileData.coverImage != null)
                                            ? provider.publicProfileData.coverImage!
                                            : "https://meektecbacekend.s3.amazonaws.com/media/profile/default.jpeg",
                                        coverphotochange: () {}),
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
                                                "${provider.publicProfileData.firstName!} ${provider.publicProfileData.lastName!}",
                                                style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.w700),
                                              ),
                                              const Spacer(),
                                              Padding(
                                                  padding: EdgeInsets.only(top: height * 0.06, left: width * 0.02),
                                                  child: (provider.publicProfileData.isFriend == false)
                                                      ? (provider.publicProfileData.friendRequestSent == true)
                                                          ? ElevatedButton(
                                                              child: const Text("Friend request sent"),
                                                              onPressed: () {
                                                                // confirmFriendRequest.id = provider.publicProfileData.friendRequestSentId;
                                                                // confirmFriendRequest.unSendRequest();
                                                                // refresh();
                                                              },
                                                            )
                                                          : (provider.publicProfileData.friendRequestAccept == true)
                                                              ? ElevatedButton(
                                                                  child: const Text("Accept friend request"),
                                                                  onPressed: () {
                                                                    // confirmFriendRequest.id =
                                                                    //     provider.publicProfileData.friendRquestAcceptId;
                                                                    //
                                                                    // confirmFriendRequest.confirmRequest();
                                                                    //
                                                                    // refresh();
                                                                  },
                                                                )
                                                              : ElevatedButton(
                                                                  child: const Text("Add friend"),
                                                                  onPressed: () {
                                                                    // addProvider.id = provider.publicProfileData.id;
                                                                    // addProvider.addSuggestedFriend();
                                                                    // refresh();
                                                                  },
                                                                )
                                                      : ElevatedButton(
                                                          child: const Text("Unfriend"),
                                                          onPressed: () {
                                                            // unfriendProvider.id = provider.publicProfileData.id;
                                                            // unfriendProvider.unFriend();
                                                            // refresh();
                                                          },
                                                        ))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    ProfilePhotowidget(
                                      viewProfilePhoto: () {
                                        Get.to(() => SingleImageView(imageURL: provider.publicProfileData.profileImage!));
                                      },
                                      isTrue: false,
                                      profilePhotoChange: () {},
                                      profileImage: (provider.publicProfileData.profileImage != null)
                                          ? provider.publicProfileData.profileImage!
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
                                        "${provider.publicProfileData.friends!.length}",
                                        style:
                                            GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w500, color: Palette.notificationColor),
                                      ),
                                      Text(" Friends", style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w500)),
                                      SizedBox(
                                        width: width * 0.2,
                                      ),
                                      Text(
                                        "${provider.publicProfileData.followers!.length}",
                                        style:
                                            GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w500, color: Palette.notificationColor),
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
                              ProfileDetailsCard(userProfileModel: provider.publicProfileData, isShowEditProfile: false),
                                SizedBox(height: height * 0.01),
                              Container(
                                height: 30,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 30,
                                    )
                                  ],
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
                            ]))),
                ]))
              ];
            },
            body: TabBarView(
              children: [
                Container(),
                Container(),
                Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
