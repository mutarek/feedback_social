import 'package:als_frontend/provider/group_provider.dart';
import 'package:als_frontend/screens/group/new_design/create_group1.dart';
import 'package:als_frontend/screens/group/new_design/find_group.dart';
import 'package:als_frontend/screens/group/new_design/invite_group.dart';
import 'package:als_frontend/screens/group/new_design/pins_group.dart';
import 'package:als_frontend/screens/group/widget/custom_expanded_widget.dart';
import 'package:als_frontend/screens/group/widget/group_view_card.dart';
import 'package:als_frontend/screens/group/widget/suggested_group_view_card.dart';
import 'package:als_frontend/screens/page/widget/like_invite_find.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/image.dart';
import 'package:als_frontend/util/palette.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'group_dashboard.dart';

class FeedBackGroups extends StatefulWidget {
  const FeedBackGroups({Key? key}) : super(key: key);

  @override
  State<FeedBackGroups> createState() => _FeedBackGroupsState();
}

class _FeedBackGroupsState extends State<FeedBackGroups> {
  ScrollController controller = ScrollController();
  @override
  void initState() {
    Provider.of<GroupProvider>(context, listen: false).initializeAuthorGroupLists();
    controller.addListener(() {
      if (controller.offset >= controller.position.maxScrollExtent &&
          !controller.position.outOfRange &&
          Provider.of<GroupProvider>(context, listen: false).hasNextData) {
        Provider.of<GroupProvider>(context, listen: false).updateAuthorPageNo();
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text("Feedback Groups", style: robotoStyle700Bold.copyWith(fontSize: 24)),
        actions: [
          PopupMenuButton(
            icon: const CircleAvatar(
                backgroundColor: AppColors.primaryColorLight, radius: 20, child: Icon(Icons.settings, color: Colors.white)),
            itemBuilder: (context) => [
              // PopupMenuItem 1
              PopupMenuItem(
                value: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Notifications Setting", style: latoStyle600SemiBold.copyWith(color: Palette.primary)),
                    Row(
                      children: [
                        SvgPicture.asset(ImagesModel.notificationIcons, width: 18, height: 18),
                        const SizedBox(width: 6),
                        Expanded(child: Text("Notifications", style: robotoStyle500Medium.copyWith(color: Palette.primary, fontSize: 12))),
                        SizedBox(
                            height: 30,
                            width: 30,
                            child: FittedBox(
                                fit: BoxFit.contain,
                                child: CupertinoSwitch(value: true, onChanged: (value) {}, activeColor: Palette.primary)))
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(ImagesModel.messageIcons, width: 18, height: 18),
                        const SizedBox(width: 6),
                        Expanded(child: Text("Message", style: robotoStyle500Medium.copyWith(color: Palette.primary, fontSize: 12))),
                        SizedBox(
                            height: 30,
                            width: 30,
                            child: FittedBox(
                                fit: BoxFit.contain,
                                child: CupertinoSwitch(value: true, onChanged: (value) {}, activeColor: Palette.primary)))
                      ],
                    ),
                  ],
                ),
              ),
              // PopupMenuItem 2
            ],
            offset: const Offset(0, 58),
            color: Colors.white,
            elevation: 4,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Consumer<GroupProvider>(builder: (context, groupProvider, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(color: const Color(0xffF0F2F5), borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.black,
                            child: SvgPicture.asset(
                              "assets/svg/your_feed_icon.svg",
                              height: 22,
                              width: 25,
                            )),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Your Feed", style: robotoStyle700Bold.copyWith(fontSize: 20)),
                              const SizedBox(height: 2),
                              Text("View the most recent activity of the groups you follow.",
                                  style: robotoStyle400Regular.copyWith(fontSize: 10))
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                CustomExpandedWidget(
                    ImagesModel.yourGroupIcon, "Your Group", "View the all group that you manage.", groupProvider.yourGroup ? true : false,
                    () {
                  groupProvider.changeYourGroupStatus();
                }),
                groupProvider.yourGroup
                    ? SizedBox(
                        height: 250,
                        child: ListView.builder(
                            itemCount: groupProvider.authorGroupLists.length,
                            itemBuilder: (context, index) {
                              var group = groupProvider.authorGroupLists[index];
                              return GroupViewCard(
                                  ontap: () {
                                    Helper.toScreen(const GroupDashboard());
                                  },
                                  name: group.name!,
                                  photo: group.coverPhoto!,
                                  message: 'Last active 50 minutes ago');
                            }))
                    : const SizedBox.shrink(),
                const SizedBox(height: 5),
                CustomExpandedWidget(ImagesModel.joinedGroupIcon, "Joined Groups", "You have been added to these groups.",
                    groupProvider.joinedGroup ? true : false, () {
                  groupProvider.changeJoinedGroupStatus();
                }),
                groupProvider.joinedGroup
                    ? SizedBox(
                        height: 250,
                        child: ListView.builder(
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8.0),
                                    margin: const EdgeInsets.only(top: 6, bottom: 6),
                                    decoration: BoxDecoration(
                                        color: const Color(0xffFAFAFA),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey.withOpacity(.2),
                                              blurRadius: 10.0,
                                              spreadRadius: 3.0,
                                              offset: const Offset(0.0, 0.0))
                                        ],
                                        borderRadius: BorderRadius.circular(15)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        ClipRRect(
                                            borderRadius: BorderRadius.circular(20),
                                            child: Center(
                                                child: Image.asset(
                                              "assets/background/profile_placeholder.jpg",
                                              height: 36,
                                              width: 36,
                                            ))),
                                        const SizedBox(width: 15),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Desh Travels', style: robotoStyle700Bold.copyWith(fontSize: 16)),
                                            const SizedBox(height: 5),
                                            Row(
                                              children: [
                                                SvgPicture.asset("assets/svg/last_minute_icon.svg", width: 14, height: 14),
                                                const SizedBox(width: 2),
                                                Text("My Message", style: robotoStyle500Medium.copyWith(fontSize: 9)),
                                              ],
                                            )
                                          ],
                                        ),
                                        const Spacer(),
                                        InkWell(
                                            onTap: () {
                                              groupProvider.changeEachJoinedGroupStatus();
                                            },
                                            child: groupProvider.eachJoinedGroup
                                                ? SvgPicture.asset(
                                                    "assets/svg/play_up_vector.svg",
                                                    height: 15,
                                                    width: 15,
                                                  )
                                                : SvgPicture.asset(
                                                    "assets/svg/play_down_vector.svg",
                                                    height: 15,
                                                    width: 15,
                                                  )),
                                        const SizedBox(
                                          width: 10,
                                        )
                                      ],
                                    ),
                                  ),
                                  groupProvider.eachJoinedGroup
                                      ? Row(
                                          children: [
                                            SizedBox(
                                              height: 47,
                                              width: 293,
                                              child: Card(
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                child: PopupMenuButton(
                                                  itemBuilder: (context) => [
                                                    // PopupMenuItem 1
                                                    PopupMenuItem(
                                                      child: SizedBox(
                                                        width: 150,
                                                        height: 120,
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                SvgPicture.asset(
                                                                  "assets/svg/notification_icon_svg.svg",
                                                                  height: 20,
                                                                  width: 20,
                                                                ),
                                                                const SizedBox(
                                                                  width: 4,
                                                                ),
                                                                Text(
                                                                  "Manage Notifications",
                                                                  style: robotoStyle500Medium.copyWith(
                                                                      fontSize: 12, color: AppColors.primaryColorLight),
                                                                )
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                            Row(
                                                              children: [
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                SvgPicture.asset(
                                                                  "assets/svg/unfollow_svg.svg",
                                                                  height: 15,
                                                                  width: 15,
                                                                ),
                                                                const SizedBox(
                                                                  width: 4,
                                                                ),
                                                                Text(
                                                                  "Unfollow Group",
                                                                  style: robotoStyle500Medium.copyWith(
                                                                      fontSize: 12, color: AppColors.primaryColorLight),
                                                                )
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                            Row(
                                                              children: [
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                SvgPicture.asset(
                                                                  "assets/svg/leave_group_svg.svg",
                                                                  height: 20,
                                                                  width: 20,
                                                                ),
                                                                const SizedBox(
                                                                  width: 4,
                                                                ),
                                                                Text(
                                                                  "Leave From Group",
                                                                  style: robotoStyle500Medium.copyWith(
                                                                      fontSize: 12, color: AppColors.primaryColorLight),
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    // PopupMenuItem 2
                                                  ],
                                                  offset: const Offset(0, 58),
                                                  color: Colors.white,
                                                  elevation: 4,
                                                  shape:
                                                      const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      SvgPicture.asset(
                                                        "assets/svg/joined_svgs.svg",
                                                        height: 12,
                                                        width: 12,
                                                      ),
                                                      const SizedBox(
                                                        width: 2,
                                                      ),
                                                      Text(
                                                        'Joined',
                                                        style:
                                                            robotoStyle700Bold.copyWith(fontSize: 15, color: AppColors.primaryColorLight),
                                                      ),
                                                      const SizedBox(
                                                        width: 2,
                                                      ),
                                                      SvgPicture.asset(
                                                        "assets/svg/up_arrow.svg",
                                                        height: 5,
                                                        width: 10,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 47,
                                              width: 93,
                                              child: Card(
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                child: PopupMenuButton(
                                                  itemBuilder: (context) => [
                                                    // PopupMenuItem 1
                                                    PopupMenuItem(
                                                      child: SizedBox(
                                                        width: 130,
                                                        height: 110,
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                SvgPicture.asset(
                                                                  "assets/svg/pins_group_icon.svg",
                                                                  height: 20,
                                                                  width: 20,
                                                                ),
                                                                const SizedBox(
                                                                  width: 4,
                                                                ),
                                                                Text(
                                                                  "Pin Group",
                                                                  style: robotoStyle500Medium.copyWith(
                                                                      fontSize: 12, color: AppColors.primaryColorLight),
                                                                )
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Row(
                                                              children: [
                                                                SvgPicture.asset(
                                                                  "assets/svg/share.svg",
                                                                  height: 15,
                                                                  width: 15,
                                                                ),
                                                                const SizedBox(
                                                                  width: 4,
                                                                ),
                                                                PopupMenuButton(
                                                                  itemBuilder: (context) => [
                                                                    // PopupMenuItem 1
                                                                    PopupMenuItem(
                                                                      child: Column(
                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          Row(
                                                                            children: [
                                                                              const Icon(Icons.pending_actions),
                                                                              const SizedBox(
                                                                                width: 4,
                                                                              ),
                                                                              Text(
                                                                                "Share on your timeline",
                                                                                style: robotoStyle500Medium.copyWith(
                                                                                    fontSize: 12, color: AppColors.primaryColorLight),
                                                                              )
                                                                            ],
                                                                          ),
                                                                          const SizedBox(
                                                                            height: 18,
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              // SvgPicture.asset("assets/svg/add.svg",height: 10,width:20,),
                                                                              SvgPicture.asset(
                                                                                "assets/svg/plane2.svg",
                                                                                height: 18,
                                                                                width: 18,
                                                                              ),
                                                                              const SizedBox(
                                                                                width: 4,
                                                                              ),
                                                                              Text(
                                                                                "Share via message",
                                                                                style: robotoStyle500Medium.copyWith(
                                                                                    fontSize: 12, color: AppColors.primaryColorLight),
                                                                              )
                                                                            ],
                                                                          ),
                                                                          const SizedBox(
                                                                            height: 18,
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              SvgPicture.asset(
                                                                                "assets/svg/twoPeople.svg",
                                                                                height: 13,
                                                                                width: 13,
                                                                              ),
                                                                              const SizedBox(
                                                                                width: 3,
                                                                              ),
                                                                              Text(
                                                                                "Share to friends timeline",
                                                                                style: robotoStyle500Medium.copyWith(
                                                                                    fontSize: 12, color: AppColors.primaryColorLight),
                                                                              )
                                                                            ],
                                                                          ),
                                                                          const SizedBox(
                                                                            height: 18,
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              SvgPicture.asset(
                                                                                "assets/svg/threePeople.svg",
                                                                                height: 13,
                                                                                width: 13,
                                                                              ),
                                                                              const SizedBox(
                                                                                width: 4,
                                                                              ),
                                                                              Text(
                                                                                "Share to a group",
                                                                                style: robotoStyle500Medium.copyWith(
                                                                                    fontSize: 12, color: AppColors.primaryColorLight),
                                                                              )
                                                                            ],
                                                                          ),
                                                                          const SizedBox(
                                                                            height: 18,
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              Image.asset(ImagesModel.pageIconsPng, width: 18, height: 18),
                                                                              const SizedBox(
                                                                                width: 4,
                                                                              ),
                                                                              Text(
                                                                                "Share to a page",
                                                                                style: robotoStyle500Medium.copyWith(
                                                                                    fontSize: 12, color: AppColors.primaryColorLight),
                                                                              )
                                                                            ],
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    // PopupMenuItem 2
                                                                  ],
                                                                  offset: const Offset(0, 58),
                                                                  color: Colors.white,
                                                                  elevation: 4,
                                                                  shape: const RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                                                  child: Text(
                                                                    "Share",
                                                                    style: robotoStyle500Medium.copyWith(
                                                                        fontSize: 12, color: AppColors.primaryColorLight),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Row(
                                                              children: [
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                const Icon(
                                                                  Icons.copy,
                                                                  size: 15,
                                                                ),
                                                                const SizedBox(
                                                                  width: 4,
                                                                ),
                                                                Text(
                                                                  "Copy Link",
                                                                  style: robotoStyle500Medium.copyWith(
                                                                      fontSize: 12, color: AppColors.primaryColorLight),
                                                                )
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Row(
                                                              children: [
                                                                SvgPicture.asset(
                                                                  "assets/svg/leave_group_svg.svg",
                                                                  height: 15,
                                                                  width: 15,
                                                                ),
                                                                const SizedBox(
                                                                  width: 4,
                                                                ),
                                                                Text(
                                                                  "Leave",
                                                                  style: robotoStyle500Medium.copyWith(
                                                                      fontSize: 12, color: AppColors.primaryColorLight),
                                                                )
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    // PopupMenuItem 2
                                                  ],
                                                  offset: const Offset(0, 58),
                                                  color: Colors.white,
                                                  elevation: 4,
                                                  shape:
                                                      const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                                  child: Container(
                                                    height: 24,
                                                    width: 30,
                                                    color: const Color(0x00e4e6eb),
                                                    child: const Icon(Icons.more_horiz),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : const SizedBox.shrink(),
                                ],
                              );
                            }))
                    : const SizedBox.shrink(),
                const SizedBox(height: 10),
                CustomExpandedWidget(ImagesModel.suggestedGroupIcon, "Suggested Group", "You might be interested in the following groups.",
                    groupProvider.suggestedGroup ? true : false, () {
                  groupProvider.changeSuggestedGroupStatus();
                }),
                const SizedBox(height: 10),
                groupProvider.suggestedGroup
                    ? SizedBox(
                        height: 500,
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                          itemCount: 6,
                          itemBuilder: (_, index) {
                            return SuggestedGroupViewCard("My Travels", "570K Members - 10+ Post a Day",
                                "https://wander-lush.org/wp-content/uploads/2022/03/Beautiful-places-in-Bangladesh-WMC-hero.jpg");
                          },
                        ),
                      )
                    : const SizedBox.shrink(),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    Helper.toScreen(const CreateGroup1());
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(color: kSecondaryColor, borderRadius: BorderRadius.circular(30)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.add_circle_outline, size: 22, color: AppColors.primaryColorLight),
                        const SizedBox(width: 5),
                        Text("Create a new Group", style: robotoStyle500Medium.copyWith(fontSize: 18))
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                const Divider(height: 1, color: Colors.black45),
                const SizedBox(height: 5),
                LikeInviteFindWidget(
                  icon: ImagesModel.pins_the_group,
                  name: "Pins Group",
                  onTap: () {
                    Helper.toScreen(const PinsGroup());
                  },
                ),
                const SizedBox(height: 10),
                LikeInviteFindWidget(
                  icon: ImagesModel.inviteFriendIcons,
                  name: "Invite Group",
                  extraArguments: " 25 new invites",
                  onTap: () {
                    Helper.toScreen(const InvitesGroup());
                  },
                ),
                const SizedBox(height: 10),
                LikeInviteFindWidget(
                  icon: ImagesModel.findPageIcons,
                  name: "Find Group",
                  onTap: () {
                    Helper.toScreen(const FindGroup());
                  },
                ),
                const SizedBox(height: 10),
                LikeInviteFindWidget(
                  icon: ImagesModel.findPageIcons,
                  name: "DashBoard",
                  onTap: () {
                    Helper.toScreen(const GroupDashboard());
                  },
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
