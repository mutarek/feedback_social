import 'package:als_frontend/data/model/response/send_friend_request_model.dart';
import 'package:als_frontend/helper/number_helper.dart';
import 'package:als_frontend/provider/profile_provider.dart';
import 'package:als_frontend/screens/home/widget/profile_avatar.dart';
import 'package:als_frontend/screens/profile/public_profile_screen.dart';
import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/palette.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_button.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SendFriendRequestScreen extends StatelessWidget {
  const SendFriendRequestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<ProfileProvider>(context, listen: false)
        .callForgetAllFriendRequest();
    return Scaffold(
      backgroundColor: Palette.scaffold,
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Helper.back();
            }),
        title: CustomText(
            title: LocaleKeys.all_Friends_Request.tr(),
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 16),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
          return profileProvider.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
                  padding: const EdgeInsets.all(15),
                  children: [
                    Center(
                        child: CustomText(
                      title:
                          '${LocaleKeys.you_Have.tr()} (${profileProvider.sendFriendRequestLists.length}) ${LocaleKeys.friend_Request.tr()}',
                      textStyle: latoStyle600SemiBold.copyWith(fontSize: 16),
                    )), //this text is added for test commit
                    const SizedBox(height: 10),
                    ListView.builder(
                        itemCount:
                            profileProvider.sendFriendRequestLists.length,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          SendFriendRequestModel sendFriendRequestModel =
                              profileProvider.sendFriendRequestLists[index];
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(.1),
                                      blurRadius: 10.0,
                                      spreadRadius: 3.0,
                                      offset: const Offset(0.0, 0.0))
                                ]),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  PublicProfileScreen(
                                                      sendFriendRequestModel
                                                          .fromUser!.id
                                                          .toString(),
                                                      index: index,
                                                      isFromFriendRequestScreen:
                                                          true)));
                                    },
                                    child: Row(
                                      children: [
                                        ProfileAvatar(
                                            profileImageUrl:
                                                sendFriendRequestModel
                                                    .fromUser!.profileImage!),
                                        const SizedBox(width: 8.0),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  '${sendFriendRequestModel.fromUser!.firstName} ${sendFriendRequestModel.fromUser!.lastName}',
                                                  style: latoStyle600SemiBold
                                                      .copyWith(fontSize: 12)),
                                              Text(
                                                  getDate(
                                                      sendFriendRequestModel
                                                          .timestamp!,
                                                      context),
                                                  style: latoStyle400Regular
                                                      .copyWith(fontSize: 12)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                        width: 95,
                                        height: 35,
                                        child: CustomButton(
                                          btnTxt: LocaleKeys.accept.tr(),
                                          textWhiteColor: true,
                                          backgroundColor: Colors.green,
                                          height: 30,
                                          onTap: () {
                                            profileProvider.acceptFriendRequest(
                                                sendFriendRequestModel.id
                                                    .toString(),
                                                index);
                                          },
                                        )),
                                    const SizedBox(height: 5),
                                    SizedBox(
                                        width: 95,
                                        height: 35,
                                        child: CustomButton(
                                          btnTxt: LocaleKeys.cancel.tr(),
                                          textWhiteColor: true,
                                          backgroundColor: Colors.red,
                                          height: 30,
                                          onTap: () {
                                            profileProvider.cancelFriendRequest(
                                                sendFriendRequestModel.id
                                                    .toString(),
                                                index);
                                          },
                                        )),
                                  ],
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
