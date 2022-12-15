import 'package:als_frontend/data/model/response/followers_model.dart';
import 'package:als_frontend/localization/language_constrants.dart';
import 'package:als_frontend/provider/profile_provider.dart';
import 'package:als_frontend/provider/public_profile_provider.dart';
import 'package:als_frontend/screens/dashboard/Widget/castom_friend_req.dart';
import 'package:als_frontend/screens/profile/public_profile_screen.dart';
import 'package:als_frontend/screens/profile/shimmer_effect/friend_req_shimmer_widget.dart';
import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

class FollowersPage extends StatefulWidget {
  const FollowersPage({Key? key}) : super(key: key);

  @override
  State<FollowersPage> createState() => _FollowersPageState();
}

class _FollowersPageState extends State<FollowersPage> {
  ScrollController controller = ScrollController();
  final bool isFromFriendScreen = false;

  @override
  void initState() {
    Provider.of<ProfileProvider>(context, listen: false).callForGetAllFollowersPagination();
    controller.addListener(() {
      if (controller.offset >= controller.position.maxScrollExtent &&
          !controller.position.outOfRange &&
          Provider.of<ProfileProvider>(context, listen: false).hasNextData) {
        Provider.of<ProfileProvider>(context, listen: false).updateAllFollowersPage();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Get.back();
              }),
          title: CustomText(title: LocaleKeys.all_Followers.tr(), color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),
          backgroundColor: Colors.white,
          elevation: 0),
      body: Consumer2<ProfileProvider, PublicProfileProvider>(
        builder: (context, profileProvider, publicProfileProvider, child) {
          return profileProvider.isLoadingSuggestedFriend
              ? const FriendReqShimmerWidget()
              : ListView(
                  controller: controller,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  children: [
                    Center(
                        child: CustomText(
                      title: '${LocaleKeys.you_Have.tr()}(${profileProvider.followersModelList.length})${getTranslated("Followers", context)} ',
                      textStyle: latoStyle600SemiBold.copyWith(fontSize: 16),
                    )),
                    const SizedBox(height: 10),
                    ListView.builder(
                        itemCount: profileProvider.followersModelList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          FollowersModel followersModel = profileProvider.followersModelList[index];
                          return FriendRequestWidget(
                            width: width,
                            userName: followersModel.fullName.toString(),
                            firstButtonName: followersModel.isFriend! ? LocaleKeys.friend.tr() :LocaleKeys.confirm.tr(),
                            secondButtonName: followersModel.isFriend! ?LocaleKeys.unfriend.tr() :LocaleKeys.remove.tr(),
                            firstButtonOnTab: () {
                              // called for accept friend request
                              if (!followersModel.isFriend!) {
                                profileProvider.acceptFriendRequest(followersModel.id.toString(), index, isFromFollowers: true);
                              } else {
                                //Called for public profile view
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) =>
                                        PublicProfileScreen(followersModel.id.toString(), index: index, isFromFriendRequestScreen: true)));
                              }
                            },
                            secondButtonOnTab: () {
                              if (!followersModel.isFriend!) {
                                //Call when your clicked on Unfriend Button

                              } else {
                                //call when you clicked on remove button
                                Provider.of<PublicProfileProvider>(context, listen: false).unFriend((bool status) {
                                  if (status) {
                                    profileProvider.removeFollowers(index);
                                  }
                                });
                              }
                            },
                            gotoProfileScreen: () {},
                            firstButtonColor: Colors.blue,
                            imgUrl: followersModel.profileImage!,
                          );

                          //   Container(
                          //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          //   margin: const EdgeInsets.only(bottom: 10),
                          //   decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [
                          //     BoxShadow(
                          //         color: Colors.grey.withOpacity(.2), blurRadius: 10.0, spreadRadius: 3.0, offset: const Offset(0.0, 0.0))
                          //   ]),
                          //   child: Row(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Expanded(
                          //         child: InkWell(
                          //           onTap: () {
                          //             // Navigator.of(context).push(MaterialPageRoute(
                          //             //     builder: (_) =>
                          //             //         PublicProfileScreen(friendModel.id.toString(), index: index, isFromFriendScreen: true)));
                          //           },
                          //
                          //           child: Row(
                          //             children: [
                          //               ProfileAvatar(profileImageUrl: followersModel.profileImage!),
                          //               const SizedBox(width: 8.0),
                          //               Expanded(
                          //                 child: Column(
                          //                   crossAxisAlignment: CrossAxisAlignment.start,
                          //                   children: [
                          //                     Text('${followersModel.full_name}', style: latoStyle600SemiBold.copyWith(fontSize: 12)),
                          //                   ],
                          //                 ),
                          //               ),
                          //             ],
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // );
                        })
                  ],
                );
        },
      ),
    );
  }
}
