import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/provider/group_provider.dart';
import 'package:als_frontend/provider/other_provider.dart';
import 'package:als_frontend/screens/group/new_design/group_dashboard.dart';
import 'package:als_frontend/screens/other/choose_image_and_crop_image_view.dart';
import 'package:als_frontend/screens/page/widget/popup_menu_widget.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/image.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:als_frontend/widgets/network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../data/model/response/author_group_model.dart';

class GroupHeaderWidget extends StatelessWidget {
  final int index;

  const GroupHeaderWidget(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<GroupProvider, OtherProvider>(
        builder: (context, groupProvider, otherProvider, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                        child: customNetworkImage(groupProvider.groupDetailsModel.coverPhoto.toString(), boxFit: BoxFit.fitWidth),
                      ),
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                            onTap: () {
                              Helper.back();
                            },
                            child: const Padding(padding: EdgeInsets.all(15), child: Icon(Icons.arrow_back, color: colorText)))),
                    !isMe(groupProvider.groupDetailsModel.creator!.id.toString())
                        ? const SizedBox.shrink()
                        : Positioned(
                            bottom: 5,
                            right: 5,
                            child: InkWell(
                              onTap: () {
                                otherProvider.clearImage();
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => ChooseImageAndCropImageView(
                                          16,
                                          9,
                                          640,
                                          210,
                                          isCover: true,
                                          isGroup: true,
                                          pageGroupID: groupProvider.groupDetailsModel.id! as int,
                                          index: index,
                                        )));
                              },
                              child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      height: 35,
                                      width: 35,
                                      decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primaryColorLight),
                                      child: const Icon(Icons.camera_alt, color: Colors.white),
                                    ),
                                  )),
                            ),
                          ),
                  ],
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                          title: groupProvider.groupDetailsModel.name,
                          maxLines: 1,
                          textStyle: robotoStyle500Medium.copyWith(fontSize: 20, color: AppColors.primaryColorLight)),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(ImagesModel.groupMemberIcon, height: 12, width: 20, color: AppColors.primaryColorLight),
                          const SizedBox(width: 5),
                          Text.rich(
                            TextSpan(
                              children: [
                                const TextSpan(text: 'Members: '),
                                TextSpan(
                                  text: groupProvider.groupDetailsModel.totalMember.toString(),
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          SvgPicture.asset(ImagesModel.publicGroupIcon, height: 12, width: 20, color: AppColors.primaryColorLight),
                          const SizedBox(width: 5),
                          Text(groupProvider.groupDetailsModel.isPrivate == true ? "Private Group" : "Public Group",
                              style: robotoStyle400Regular.copyWith(fontSize: 10)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          !isMe(groupProvider.groupDetailsModel.creator!.id.toString())
                              ? Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: SizedBox(
                                          height: 48,
                                          child: Card(
                                            color: const Color(0xff080C2F),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset("assets/svg/joined_svgs.svg", height: 12, width: 12, color: Colors.white),
                                                const SizedBox(width: 2),
                                                InkWell(
                                                  onTap: () {
                                                    AuthorGroupModel authorGroupModel = AuthorGroupModel();
                                                    authorGroupModel.id = groupProvider.groupDetailsModel.id;
                                                    Helper.toScreen(const GroupDashboard());
                                                  },
                                                  child: Text(
                                                    groupProvider.groupDetailsModel.isMember == true ? "Joined" : "Join",
                                                    style: robotoStyle700Bold.copyWith(fontSize: 15, color: Colors.white),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          height: 40,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: const Color(0xff080C2F)),
                                            borderRadius: BorderRadius.circular(8),
                                            color: const Color(0xffE7F3FF),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset("assets/svg/joined_svgs.svg", height: 12, width: 12),
                                              const SizedBox(width: 2),
                                              Text('Invite',
                                                  style: robotoStyle700Bold.copyWith(fontSize: 15, color: AppColors.primaryColorLight)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Expanded(
                                  child: SizedBox(
                                    height: 48,
                                    child: Card(
                                      color: const Color(0xff080C2F),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                      child: InkWell(
                                        onTap: () {
                                          Helper.toScreen(const GroupDashboard());
                                        },
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset("assets/svg/joined_svgs.svg", height: 12, width: 12, color: Colors.white),
                                            const SizedBox(width: 2),
                                            Text("Dashboard", style: robotoStyle700Bold.copyWith(fontSize: 15, color: Colors.white)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                          const SizedBox(width: 5),
                          PopupMenuButton(
                            itemBuilder: (context) => [
                              // PopupMenuItem 1
                              PopupMenuItem(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    PopUpMenuWidget(ImagesModel.pins_the_group, 'Pin Group', () {
                                      groupProvider.callForPinGroup();
                                      Navigator.of(context).pop();
                                    }, size: 18),
                                    const SizedBox(height: 13),
                                    PopUpMenuWidget(ImagesModel.shareIcons, 'Share', () {
                                      Navigator.of(context).pop();
                                    }, size: 11),
                                    const SizedBox(height: 13),
                                    PopUpMenuWidget(ImagesModel.copyIcons, 'Copy', () {
                                      Navigator.of(context).pop();
                                    }, size: 18),
                                    const SizedBox(height: 13),
                                    PopUpMenuWidget(ImagesModel.blocksIcons, "Block", () {
                                      groupProvider.createBlock().then((value) {
                                        if (value) {
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pop();
                                        }
                                      });
                                    }),
                                    const SizedBox(height: 13),
                                    !groupProvider.groupDetailsModel.isMember!
                                        ? const SizedBox.shrink()
                                        : PopUpMenuWidget(ImagesModel.leaveIcons, 'Leave ', () {
                                            groupProvider.leaveGroup(
                                              groupProvider.groupDetailsModel.id as int,
                                              int.parse(Provider.of<AuthProvider>(context, listen: false).userID),
                                              index: index,
                                            );
                                            Navigator.of(context).pop();
                                          }, size: 18),
                                    SizedBox(height: !groupProvider.groupDetailsModel.isMember! ? 0 : 5),
                                  ],
                                ),
                              ),
                              // PopupMenuItem 2
                            ],
                            offset: const Offset(0, 58),
                            color: Colors.white,
                            elevation: 4,
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  border: Border.all(color: const Color(0xff080C2F)),
                                  borderRadius: BorderRadius.circular(8),
                                  color: const Color(0xffE7F3FF)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [Icon(Icons.more_horiz, color: AppColors.primaryColorLight, size: 12)],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(thickness: 2, color: Color(0xffE4E6EB))
              ],
            ));
  }
}
