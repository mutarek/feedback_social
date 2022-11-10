import 'package:als_frontend/data/model/response/followers_model.dart';
import 'package:als_frontend/provider/profile_provider.dart';
import 'package:als_frontend/screens/dashboard/Widget/castom_friend_req.dart';
import 'package:als_frontend/screens/home/widget/profile_avatar.dart';
import 'package:als_frontend/screens/profile/public_profile_screen.dart';
import 'package:als_frontend/screens/profile/shimmer_effect/friend_req_shimmer_widget.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class FollowersPage extends StatefulWidget {
  @override
  State<FollowersPage> createState() => _FollowersPageState();
}

class _FollowersPageState extends State<FollowersPage> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    Provider.of<ProfileProvider>(context, listen: false).callForGetAllFollowersPagination();

    controller.addListener(() {
      if (controller.offset >= controller.position.maxScrollExtent &&
          !controller.position.outOfRange &&
          Provider.of<ProfileProvider>(context, listen: false).hasNextData) {
        Provider.of<ProfileProvider>(context, listen: false).updateAllFllowersPage();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Get.back();
            }),
        title: CustomText(
            title: 'All Followers', color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
          return profileProvider.isLoading
              ? FriendReqShimmerWidget()
              : ListView(
                  controller: controller,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  children: [
                    Center(
                        child: CustomText(
                      title: 'You Have (${profileProvider.followersModelList.length}) Followers ',
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
                            userName: followersModel.full_name.toString(),
                            firstButtonName: followersModel.is_friend! ? "Friend" : "Confrim",
                            secondButtonName: followersModel.is_friend! ? "Unfriend" : "Remove",
                            firstButtonOnTab: () {
                              // called for accept friend request
                              if (!followersModel.is_friend!) {
                                profileProvider.acceptFriendRequest(
                                    followersModel.id.toString(), index);
                              } else {
                                //Called for public profile view
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => PublicProfileScreen(
                                        followersModel.id.toString(),
                                        index: index,
                                        isFromFriendRequestScreen: true)));
                              }
                            },
                            secondButtonOnTab: () {
                              if (followersModel.is_friend!) {
                                // call when you clicked on unfriend button
                              } else {
                                //call when you clicked on remove button
                              }
                            },
                            gotoProfileScreen: () {},
                            firstButtonColor: Colors.blue,
                            imgUrl: '',
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
