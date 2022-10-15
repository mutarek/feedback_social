import 'package:als_frontend/old_code/const/palette.dart';
import 'package:als_frontend/screens/home/widget/timeline_widget.dart';
import 'package:als_frontend/screens/profile/widget/profile_details_card.dart';
import 'package:als_frontend/screens/profile/widget/profile_photo_widget.dart';
import 'package:als_frontend/screens/profile/widget/profile_cover_photo_widget.dart';
import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/provider/profile_provider.dart';
import 'package:als_frontend/screens/auth/login_screen.dart';
import 'package:als_frontend/screens/profile/widget/update_cover_photo.dart';
import 'package:als_frontend/widgets/single_image_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ProfileProvider>(context, listen: false).initializeAllUserPostData((bool status) {}, isFirstTime: true);
    Provider.of<ProfileProvider>(context, listen: false).initializeUserData();
    controller.addListener(() {
      if (controller.offset >= controller.position.maxScrollExtent &&
          !controller.position.outOfRange &&
          Provider.of<ProfileProvider>(context, listen: false).hasNextData) {
        Provider.of<ProfileProvider>(context, listen: false).updatePageNo();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Palette.scaffold,
      body: SafeArea(
        child: Consumer2<AuthProvider, ProfileProvider>(
          builder: (context, authProvider, profileProvider, child) => profileProvider.isLoading || profileProvider.isProfileLoading
              ? const Center(
                  child: CupertinoActivityIndicator(),
                )
              : SingleChildScrollView(
                  controller: controller,
                  physics: const ScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(height: height * 0.26, width: width, color: Palette.scaffold),
                          ProfileCoverPhotoWidget(
                              back: () {
                                Navigator.of(context).pop();
                              },
                              viewCoverPhoto: (() {
                                Get.to(() => SingleImageView(imageURL: profileProvider.userprofileData.coverImage!));
                              }),
                              coverphoto: (profileProvider.isProfileLoading == false)
                                  ? profileProvider.userprofileData.coverImage!
                                  : "https://meektecbacekend.s3.amazonaws.com/media/profile/default.jpeg",
                              coverphotochange: (() {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (_) => const UpdateCoverPhoto(isCoverPhotoUpload: true)));
                              })),
                          ProfilePhotowidget(
                              profilePhotoChange: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (_) => const UpdateCoverPhoto(isCoverPhotoUpload: false)));
                              },
                              profileImage: (profileProvider.isProfileLoading == false)
                                  ? profileProvider.userprofileData.profileImage!
                                  : "https://meektecbacekend.s3.amazonaws.com/media/profile/default.jpeg",
                              viewProfilePhoto: () {
                                Get.to(() => SingleImageView(imageURL: profileProvider.userprofileData.profileImage!));
                              })
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: height * 0.01, left: width * 0.05),
                        child: Text(
                          "${profileProvider.userprofileData.firstName!} ${profileProvider.userprofileData.lastName!}",
                          style: GoogleFonts.lato(fontSize: width * 0.05, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: height * 0.01, left: width * 0.04, right: width * 0.04),
                        child: Container(
                          height: height * 0.043,
                          width: width * 0.92,
                          decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(4))),
                          child: Padding(
                            padding: EdgeInsets.only(left: width * 0.1),
                            child: Row(
                              children: [
                                Text(
                                  "${profileProvider.userprofileData.friends!.length}",
                                  style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w500, color: Palette.notificationColor),
                                ),
                                Text(" Friends", style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w500)),
                                SizedBox(
                                  width: width * 0.2,
                                ),
                                Text(
                                  "${profileProvider.userprofileData.followers!.length}",
                                  style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w500, color: Palette.notificationColor),
                                ),
                                Text(" Followers", style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w500))
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: height * 0.01, left: width * 0.04, right: width * 0.04),
                        child: const ProfileDetailsCard(),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: profileProvider.newsFeedLists.length,
                            itemBuilder: ((context, index) {
                              return TimeLineWidget(profileProvider.newsFeedLists[index], index, profileProvider, isProfileScreen: true);
                            })),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
