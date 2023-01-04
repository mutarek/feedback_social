import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/provider/profile_provider.dart';
import 'package:als_frontend/screens/home/widget/timeline_widget.dart';
import 'package:als_frontend/screens/profile/followers_page.dart';
import 'package:als_frontend/screens/profile/friend_screen.dart';
import 'package:als_frontend/screens/profile/shimmer_effect/profile_post_%20shimmer_widget.dart';
import 'package:als_frontend/screens/profile/widget/profile_cover_photo_widget.dart';
import 'package:als_frontend/screens/profile/widget/profile_details_card.dart';
import 'package:als_frontend/screens/profile/widget/profile_photo_widget.dart';
import 'package:als_frontend/screens/profile/widget/update_cover_photo.dart';
import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/palette.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/widgets/single_image_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ScrollController controller = ScrollController();

  Future<void> _refresh(BuildContext context) async {
    Provider.of<ProfileProvider>(context, listen: false).initializeAllUserPostData((bool status) {}, isFirstTime: false);
    Provider.of<ProfileProvider>(context, listen: false).initializeUserData();
  }

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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Consumer2<AuthProvider, ProfileProvider>(
          builder: (context, authProvider, profileProvider, child) => profileProvider.isLoading || profileProvider.isProfileLoading
              ? const ProfilePostShimmerWidget()
              : RefreshIndicator(
                  onRefresh: () {
                    return _refresh(context);
                  },
                  child: SingleChildScrollView(
                    controller: controller,
                    physics: const ScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(height: 230, width: width, color: Colors.white),
                            ProfileCoverPhotoWidget(
                                back: () {
                                  Navigator.of(context).pop();
                                },
                                viewCoverPhoto: (() {
                                  Helper.toScreen(SingleImageView(imageURL: profileProvider.userprofileData.coverImage!));
                                }),
                                coverphoto: (profileProvider.isProfileLoading == false)
                                    ? profileProvider.userprofileData.coverImage!
                                    : "https://meektecbacekend.s3.amazonaws.com/media/profile/default.jpeg",
                                coverphotochange: (() {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (_) => const UpdateCoverPhoto(isCoverPhotoUpload: true)));
                                })),
                            Positioned(
                              bottom: 0,
                              left: 30,
                              child: ProfilePhotoWidget(
                                  profileImage: profileProvider.userprofileData.profileImage!,
                                  // (profileProvider.isProfileLoading == false)
                                  //     ? profileProvider.userprofileData.profileImage!
                                  //     : "https://meektecbacekend.s3.amazonaws.com/media/profile/default.jpeg",
                                  viewProfilePhoto: () {
                                    Helper.toScreen(SingleImageView(imageURL: profileProvider.userprofileData.profileImage!));
                                  }),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 2, left: width * 0.05),
                          child: Text(
                            "${profileProvider.userprofileData.firstName!} ${profileProvider.userprofileData.lastName!}",
                            style: GoogleFonts.lato(fontSize: width * 0.05, fontWeight: FontWeight.w700),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: height * 0.01, left: width * 0.04, right: width * 0.04),
                          child: Container(
                            height: height * 0.043,
                            decoration: const BoxDecoration(color: AppColors.scaffold, borderRadius: BorderRadius.all(Radius.circular(4))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const FriendScreen()));
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${profileProvider.userprofileData.friends!.length}",
                                          style: GoogleFonts.lato(
                                              fontSize: 16, fontWeight: FontWeight.w500, color: Palette.notificationColor),
                                        ),
                                        Text(LocaleKeys.friends.tr(), style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w500)),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: (){
                                      Helper.toScreen(const FollowersPage());
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${profileProvider.userprofileData.followers!.length}",
                                          style:
                                              GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w500, color: Palette.notificationColor),
                                        ),
                                        Text(LocaleKeys.followers.tr(), style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w500))
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        ProfileDetailsCard(userProfileModel: profileProvider.userprofileData),
                        const SizedBox(height: 10),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: profileProvider.newsFeedLists.length,
                            itemBuilder: ((context, index) {
                              return TimeLineWidget(profileProvider.newsFeedLists[index], index, profileProvider, isProfileScreen: true);
                            })),
                        profileProvider.isBottomLoading
                            ? Container(
                                width: MediaQuery.of(context).size.width,
                                height: 100,
                                alignment: Alignment.center,
                                child: const CupertinoActivityIndicator())
                            : const SizedBox.shrink()
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
