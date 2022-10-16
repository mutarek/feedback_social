import 'package:als_frontend/data/model/response/send_friend_request_model.dart';
import 'package:als_frontend/helper/number_helper.dart';
import 'package:als_frontend/old_code/const/palette.dart';
import 'package:als_frontend/provider/profile_provider.dart';
import 'package:als_frontend/screens/home/widget/profile_avatar.dart';
import 'package:als_frontend/screens/profile/public_profile_screen.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_button.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class SendFriendRequestScreen extends StatelessWidget {
  const SendFriendRequestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Provider.of<ProfileProvider>(context, listen: false).callForgetAllFriendRequest();
    return Scaffold(
      backgroundColor: Palette.scaffold,
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
            }),
        title: CustomText(title: 'All Friends Request', color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),
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
                  padding: EdgeInsets.all(15),
                  children: [
                    Center(
                        child: CustomText(
                      title: 'You Have (${profileProvider.sendFriendRequestLists.length}) Friend Request',
                      textStyle: latoStyle600SemiBold.copyWith(fontSize: 16),
                    )),
                    SizedBox(height: 10),
                    ListView.builder(
                        itemCount: profileProvider.sendFriendRequestLists.length,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          SendFriendRequestModel sendFriendRequestModel = profileProvider.sendFriendRequestLists[index];
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5), boxShadow: [
                              BoxShadow(color: Colors.grey.withOpacity(.1), blurRadius: 10.0, spreadRadius: 3.0, offset: Offset(0.0, 0.0))
                            ]),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (_) => PublicProfileScreen(sendFriendRequestModel.toUser!.id.toString(),
                                              index: index, isFromFriendRequestScreen: true)));
                                    },
                                    child: Row(
                                      children: [
                                        ProfileAvatar(profileImageUrl: sendFriendRequestModel.toUser!.profileImage!),
                                        const SizedBox(width: 8.0),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('${sendFriendRequestModel.toUser!.firstName} ${sendFriendRequestModel.toUser!.lastName}',
                                                  style: latoStyle600SemiBold.copyWith(fontSize: 12)),
                                              Text(getDate(sendFriendRequestModel.timestamp!, context),
                                                  style: latoStyle400Regular.copyWith(fontSize: 12)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    Container(
                                        width: 95,
                                        height: 35,
                                        child: CustomButton(
                                          btnTxt: 'Accept',
                                          textWhiteColor: true,
                                          backgroundColor: Colors.green,
                                          height: 30,
                                          onTap: () {
                                            profileProvider.acceptFriendRequest(sendFriendRequestModel.id.toString(), index);
                                          },
                                        )),
                                    SizedBox(height: 5),
                                    Container(
                                        width: 95,
                                        height: 35,
                                        child: CustomButton(
                                          btnTxt: 'Cancel',
                                          textWhiteColor: true,
                                          backgroundColor: Colors.red,
                                          height: 30,
                                          onTap: () {
                                            profileProvider.cancelFriendRequest(sendFriendRequestModel.id.toString(), index);
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
