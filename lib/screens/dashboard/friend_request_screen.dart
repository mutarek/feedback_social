import 'package:als_frontend/data/model/response/send_friend_request_model.dart';
import 'package:als_frontend/data/model/response/suggested_friend_model.dart';
import 'package:als_frontend/provider/profile_provider.dart';
import 'package:als_frontend/provider/public_profile_provider.dart';
import 'package:als_frontend/screens/dashboard/Widget/custom_friend_request_widget.dart';
import 'package:als_frontend/screens/dashboard/Widget/custom_suggested_friend_widget.dart';
import 'package:als_frontend/screens/profile/public_profile_screen.dart';
import 'package:als_frontend/screens/profile/shimmer_effect/friend_req_shimmer_widget.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FriendRequestSuggestionScreen extends StatefulWidget {
  const FriendRequestSuggestionScreen({Key? key}) : super(key: key);

  @override
  State<FriendRequestSuggestionScreen> createState() => _FriendRequestSuggestionScreenState();
}

class _FriendRequestSuggestionScreenState extends State<FriendRequestSuggestionScreen> {
  ScrollController controller = ScrollController();
  ScrollController confirmFriendRequestController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<ProfileProvider>(context, listen: false).callForgetAllFriendRequest();
    controller.addListener(() {
      if (controller.offset >= controller.position.maxScrollExtent &&
          !controller.position.outOfRange &&
          Provider.of<ProfileProvider>(context, listen: false).hasNextData) {
        Provider.of<ProfileProvider>(context, listen: false).updateSuggestedPageNo();
      }
    });

    // TODO: implement confirm friend req
    confirmFriendRequestController.addListener(() {
      if (confirmFriendRequestController.offset >= confirmFriendRequestController.position.maxScrollExtent &&
          !confirmFriendRequestController.position.outOfRange &&
          Provider.of<ProfileProvider>(context, listen: false).hasNextDataFriendRequest) {
        Provider.of<ProfileProvider>(context, listen: false).updateUpcomingFriendsRequest();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: AppColors.scaffold,
          body: Consumer2<ProfileProvider, PublicProfileProvider>(
            builder: (context, profileProvider, publicProvider, child) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      height: height * 0.055,
                      decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(25)),
                      child:
                          TabBar(indicator: BoxDecoration(color: AppColors.feedback, borderRadius: BorderRadius.circular(25)), tabs: const [
                        CustomText(title: "Friend request"),
                        CustomText(title: "Suggested friend"),
                      ]),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(children: [
                      profileProvider.isLoading
                          ? const FriendReqShimmerWidget()
                          : profileProvider.sendFriendRequestLists.isEmpty
                              ? const Center(child: CustomText(title: "you have no friend request"))
                              : ListView(
                                  physics: const BouncingScrollPhysics(),
                                  controller: confirmFriendRequestController,
                                  children: [
                                    ListView.builder(
                                        physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: profileProvider.sendFriendRequestLists.length,
                                        itemBuilder: (context, index) {
                                          SendFriendRequestModel sendFriendRequestModel = profileProvider.sendFriendRequestLists[index];

                                          return CustomFriendRequestWidget(
                                            imgUrl: sendFriendRequestModel.fromUser!.profileImage!,
                                            userName:
                                                "${sendFriendRequestModel.fromUser!.firstName}${sendFriendRequestModel.fromUser!.lastName}",
                                            gotoProfileScreen: () {
                                              Navigator.of(context).push(MaterialPageRoute(
                                                  builder: (_) => PublicProfileScreen(sendFriendRequestModel.fromUser!.id.toString(),
                                                      index: index, isFromFriendRequestScreen: true)));
                                            },
                                            cancelButtonTap: () {
                                              profileProvider.removeRequestAfterCancelRequest(index);
                                            },
                                            confirmButtonTap: () {
                                              profileProvider.sendFriendRequestLists.removeAt(index);
                                              profileProvider.acceptFriendRequest(sendFriendRequestModel.id.toString(), index);
                                            },
                                          );
                                        }),
                                    profileProvider.isBottomLoadingFriendRequest
                                        ? Container(
                                            width: MediaQuery.of(context).size.width,
                                            height: 100,
                                            alignment: Alignment.center,
                                            child: const CupertinoActivityIndicator())
                                        : const SizedBox.shrink(),
                                  ],
                                ),

                      //Todo: Suggested friend

                      profileProvider.isLoadingSuggestedFriend
                          ? const FriendReqShimmerWidget()
                          : ListView(
                              physics: const BouncingScrollPhysics(),
                              controller: controller,
                              children: [
                                ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: profileProvider.suggestFriendRequestList.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      SuggestFriendModel suggestFriendRequestModel = profileProvider.suggestFriendRequestList[index];
                                      return CustomSuggestedFriendsWidget(
                                        imgUrl: suggestFriendRequestModel.profileImage!,
                                        gotoProfileScreen: () {
                                          Navigator.of(context).push(MaterialPageRoute(
                                              builder: (_) => PublicProfileScreen(suggestFriendRequestModel.id.toString(),
                                                  index: index, isFromFriendRequestScreen: true)));
                                        },
                                        userName: "${suggestFriendRequestModel.firstName} ${suggestFriendRequestModel.lastName}",
                                        addFriendButtonTap: () {
                                          profileProvider.removeSuggestionFriend(index);
                                          publicProvider.addFriend(suggestFriendRequestModel.id.toString());
                                        },
                                      );
                                    }),
                                profileProvider.isBottomLoading
                                    ? Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 100,
                                        alignment: Alignment.center,
                                        child: const CupertinoActivityIndicator())
                                    : const SizedBox.shrink(),
                              ],
                            )
                    ]),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
