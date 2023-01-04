import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/provider/group_provider.dart';
import 'package:als_frontend/screens/group/create_group_screen.dart';
import 'package:als_frontend/screens/group/invite_group_screen.dart';
import 'package:als_frontend/screens/group/shimmer_effect/my_group_shimmer_effect.dart';
import 'package:als_frontend/screens/group/view/group_image_video_view.dart';
import 'package:als_frontend/screens/group/view/group_member_view.dart';
import 'package:als_frontend/screens/home/widget/create_post_widget.dart';
import 'package:als_frontend/screens/home/widget/timeline_widget.dart';
import 'package:als_frontend/screens/page/widget/cover_photo_widget.dart';
import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/palette.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:als_frontend/widgets/single_image_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../provider/other_provider.dart';

class UserGroupScreen extends StatefulWidget {
  final String groupID;
  final int index;

  const UserGroupScreen(this.groupID, this.index, {Key? key}) : super(key: key);

  @override
  State<UserGroupScreen> createState() => _UserGroupScreenState();
}

class _UserGroupScreenState extends State<UserGroupScreen> {
  final TextEditingController writePostController = TextEditingController();

  ScrollController controller = ScrollController();
  PageController pageController = PageController();

  Future<void> _refresh(BuildContext context) async {
    Provider.of<GroupProvider>(context, listen: false).callForGetAllGroupPosts(widget.groupID, isFirstTime: false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController();
    Provider.of<GroupProvider>(context, listen: false).callForGetAllGroupInformation(widget.groupID);
    Provider.of<GroupProvider>(context, listen: false).callForGetAllGroupPosts(widget.groupID);
    controller.addListener(() {
      if (controller.offset >= controller.position.maxScrollExtent &&
          !controller.position.outOfRange &&
          Provider.of<GroupProvider>(context, listen: false).hasNextData) {
        Provider.of<GroupProvider>(context, listen: false).updatePageNo(widget.groupID);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Consumer2<GroupProvider, AuthProvider>(
        builder: (context, groupProvider, authProvider, c) => Scaffold(
              body: SafeArea(
                child: (groupProvider.isLoading)
                    ? const MyGroupShimmerWidget()
                    : RefreshIndicator(
                        onRefresh: () {
                          return _refresh(context);
                        },
                        child: PageView(
                          controller: pageController,
                          onPageChanged: (value) {
                            groupProvider.changeMenuValue(value);
                          },
                          children: [
                            ListView(
                              controller: controller,
                              children: [
                                menuRow(width, groupProvider, height, context),
                                Column(
                                  children: [
                                    createPostWidget(context, authProvider, isForGroup: true, groupPageID: int.parse(widget.groupID)),

                                    /*----------------------------------------Newsfeed---------------------------------*/
                                    const SizedBox(height: 15),
                                    ListView.builder(
                                        physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: groupProvider.groupAllPosts.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                              margin: const EdgeInsets.only(bottom: 10),
                                              child: TimeLineWidget(groupProvider.groupAllPosts[index], index, groupProvider,
                                                  isGroup: true, groupPageID: int.parse(widget.groupID)));
                                        }),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: [
                                menuRow(width, groupProvider, height, context),
                                GroupImageVideoView(int.parse(widget.groupID)),
                              ],
                            ),
                            Column(
                              children: [
                                menuRow(width, groupProvider, height, context),
                                GroupImageVideoView(int.parse(widget.groupID), isForImage: false),
                              ],
                            ),
                            Column(
                              children: [
                                menuRow(width, groupProvider, height, context),
                                const GroupMemberView(),
                              ],
                            ),
                          ],
                        ),
                      ),
              ),
            ));
  }

  Widget menuRow(double width, GroupProvider groupProvider, double height, BuildContext context) {
    return Container(
      height: 290,
      width: width,
      color: Palette.scaffold,
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                width: width,
                child: CoverPhotoWidget(
                  isTrue: true,
                  coverPhotoChange: () {

                  },
                  back: () {
                    Helper.back();
                  },
                  coverPhoto: groupProvider.groupDetailsModel.coverPhoto!,
                  viewCoverPhoto: () {
                    Helper.toScreen(SingleImageView(imageURL: groupProvider.groupDetailsModel.coverPhoto!));
                  },
                ),
              ),
              Positioned(
                top: height * 0.21,
                child: Container(
                  height: height * 0.14,
                  width: width,
                  decoration: const BoxDecoration(color: Palette.scaffold, borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: height * 0.22, left: width * 0.03),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(groupProvider.groupDetailsModel.name!, style: TextStyle(fontSize: height * 0.03, fontWeight: FontWeight.bold)),
                        Padding(padding: EdgeInsets.only(right: width * 0.227), child: Text(groupProvider.groupDetailsModel.category!)),
                        SizedBox(height: height * 0.01),
                        InkWell(
                          onTap: () {
                            Helper.toScreen(InviteGroupScreen(int.parse(widget.groupID)));
                          },
                          child: CircleAvatar(
                            backgroundColor: Palette.notificationColor,
                            radius: 20,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(FontAwesomeIcons.plus, size: 8, color: Colors.white),
                                Text(LocaleKeys.invite.tr(), style: GoogleFonts.lato(fontSize: 10, color: Colors.white))
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(groupProvider.groupDetailsModel.totalMember.toString(),
                              style: TextStyle(fontSize: height * 0.03, fontWeight: FontWeight.bold)),
                          Text(LocaleKeys.members.tr()),
                          SizedBox(height: height * 0.014),
                          InkWell(
                            onTap: () {
                              Provider.of<OtherProvider>(context, listen: false).clearImage();
                              Navigator.of(context).pop();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => CreateGroupScreen(
                                      authorGroup: groupProvider.groupDetailsModel, isUpdateGroup: true, index: widget.index)));

                              // editGroupProvider.groupId = groupProvider.groupDetails!.id as int;
                              // Get.to(() => const EditGroup());
                            },
                            child: Container(
                              height: height * 0.036,
                              width: width * 0.2,
                              decoration: BoxDecoration(color: Palette.primary, borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(FontAwesomeIcons.penToSquare, size: 14, color: Colors.white),
                                  SizedBox(width: width * 0.007),
                                  Text(LocaleKeys.edit_Group.tr(), style: TextStyle(fontSize: height * 0.012, color: Colors.white))
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
            ],
          ),
          Container(
            height: 25,
            color: Colors.white,
            child: Row(children: [
              MenuButtonWidget(LocaleKeys.discussion.tr(), 0, groupProvider, pageController),
              MenuButtonWidget(LocaleKeys.photos.tr(), 1, groupProvider, pageController),
              MenuButtonWidget(LocaleKeys.videos.tr(), 2, groupProvider, pageController),
              MenuButtonWidget(LocaleKeys.members.tr(), 3, groupProvider, pageController),
            ]),
          ),
        ],
      ),
    );
  }
}

class MenuButtonWidget extends StatelessWidget {
  final String title;
  final int value;
  final GroupProvider groupProvider;
  final PageController pageController;

  const MenuButtonWidget(this.title, this.value, this.groupProvider, this.pageController, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          groupProvider.changeMenuValue(value);
          pageController.jumpToPage(value);
        },
        child: Column(
          children: [
            CustomText(title: title, color: Colors.black),
            const SizedBox(height: 5),
            Container(
              height: 2,
              color: groupProvider.menuValue == value ? Colors.red : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}
