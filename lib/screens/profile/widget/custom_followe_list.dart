import 'package:als_frontend/data/model/response/followers_model.dart';
import 'package:als_frontend/provider/profile_provider.dart';
import 'package:als_frontend/screens/home/widget/profile_avatar.dart';
import 'package:als_frontend/screens/video/widget/new_video_widgets.dart';
import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

class CustomFollowerList extends StatelessWidget {
  final FollowersModel followersModel;
  final int index;

  const CustomFollowerList(this.followersModel, this.index, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
      return Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                      // Navigator.of(context).push(
                      //     MaterialPageRoute(
                      //         builder: (_) =>
                      //             PublicProfileScreen(
                      //                 sendFriendRequestModel
                      //                     .fromUser!.id
                      //                     .toString(),
                      //                 index: index,
                      //                 isFromFriendRequestScreen:
                      //                 true)));
                    },
                    child: Row(
                      children: [
                        ProfileAvatar(
                            profileImageUrl:
                                followersModel.profileImage.toString()),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${followersModel.fullName} ',
                                  style: latoStyle600SemiBold.copyWith(
                                      fontSize: 12)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                        width: 95,
                        height: 35,
                        child: CustomButton(
                          btnTxt:
                              followersModel.isFriend! ? "Friend" : "Confirm",
                          textWhiteColor: true,
                          backgroundColor: Colors.green,
                          height: 30,
                          onTap: () {
                            if (followersModel.isFriend!) {
                            } else {
                              profileProvider.acceptFriendRequest(
                                  followersModel.id.toString(), index);
                            }
                          },
                        )),
                    const SizedBox(width: 5),
                    SizedBox(
                        width: 95,
                        height: 35,
                        child: CustomButton(
                          btnTxt:
                              followersModel.isFriend! ? "UnFriend" : "Remove",
                          textWhiteColor: true,
                          backgroundColor: Colors.red,
                          height: 30,
                          onTap: () {
                            profileProvider.cancelFriendRequest(
                                followersModel.id.toString(), index);
                          },
                        )),
                  ],
                ),
              ],
            ),
          ));
    });
  }
}
