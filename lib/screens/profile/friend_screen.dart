import 'package:als_frontend/data/model/response/friend_model.dart';
import 'package:als_frontend/provider/profile_provider.dart';
import 'package:als_frontend/screens/home/widget/profile_avatar.dart';
import 'package:als_frontend/screens/profile/public_profile_screen.dart';
import 'package:als_frontend/screens/profile/shimmer_effect/friend_req_shimmer_widget.dart';
import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FriendScreen extends StatefulWidget {
  const FriendScreen({Key? key}) : super(key: key);

  @override
  State<FriendScreen> createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    Provider.of<ProfileProvider>(context, listen: false).callForGetAllFriendsPagination();

    controller.addListener(() {
      if (controller.offset >= controller.position.maxScrollExtent &&
          !controller.position.outOfRange &&
          Provider.of<ProfileProvider>(context, listen: false).hasNextData) {
        Provider.of<ProfileProvider>(context, listen: false).updateAllFriendsPage();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Helper.back();
            }),
        title: CustomText(title: LocaleKeys.all_Friends.tr(), color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
          return profileProvider.isLoadingSuggestedFriend
              ? const FriendReqShimmerWidget()
              : ListView(
                  controller: controller,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  children: [
                    Center(
                        child: CustomText(
                      title: '${LocaleKeys.you_Have.tr()}(${profileProvider.paginationFriendLists.length}) ${LocaleKeys.friend.tr()}',
                      textStyle: latoStyle600SemiBold.copyWith(fontSize: 16),
                    )),
                    const SizedBox(height: 10),
                    ListView.builder(
                        itemCount: profileProvider.paginationFriendLists.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          FriendModel friendModel = profileProvider.paginationFriendLists[index];
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(.2), blurRadius: 10.0, spreadRadius: 3.0, offset: const Offset(0.0, 0.0))
                            ]),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (_) =>
                                              PublicProfileScreen(friendModel.id.toString(), index: index, isFromFriendScreen: true)));
                                    },
                                    child: Row(
                                      children: [
                                        ProfileAvatar(profileImageUrl: friendModel.profileImage!),
                                        const SizedBox(width: 8.0),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('${friendModel.fullName}', style: latoStyle600SemiBold.copyWith(fontSize: 12)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        })
                  ],
                );
        },
      ),
    );
  }
}
