import 'package:als_frontend/provider/group_provider.dart';
import 'package:als_frontend/screens/group/blocked_group_screen.dart';
import 'package:als_frontend/screens/group/new_design/create_group1.dart';
import 'package:als_frontend/screens/group/new_design/find_group.dart';
import 'package:als_frontend/screens/group/new_design/invite_group.dart';
import 'package:als_frontend/screens/group/new_design/pins_group.dart';
import 'package:als_frontend/screens/group/widget/group_view_card.dart';
import 'package:als_frontend/screens/group/widget/suggested_group_view_card.dart';
import 'package:als_frontend/screens/page/page_dashboard.dart';
import 'package:als_frontend/screens/page/widget/like_invite_find.dart';
import 'package:als_frontend/screens/page/widget/popup_menu_widget.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/image.dart';
import 'package:als_frontend/util/palette.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'group_details_page.dart';

class FeedBackGroups extends StatelessWidget {
  const FeedBackGroups({Key? key}) : super(key: key);

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
                    const SizedBox(height: 6),
                    PopUpMenuWidget(ImagesModel.blocksIcons, 'Block Group List', () {
                      Helper.back();
                      Helper.toScreen(const BlockedGroupScreen());
                    }),
                    const SizedBox(height: 6),
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
                            child: SvgPicture.asset(ImagesModel.yourFeedIcons, height: 22, width: 25)),
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
                dashboardWidget("Your Group", ImagesModel.yourGroupIcon, true, () {
                  groupProvider.changeYourGroupStatus();
                }, expandedCondition: groupProvider.yourGroup, isShowSubtitle: true, subTitle: 'View the all group that you manage.'),
                groupProvider.yourGroup
                    ? SizedBox(
                        height: 290,
                        child: groupProvider.isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : groupProvider.authorGroupLists.isNotEmpty
                                ? Column(
                                    children: [
                                      Expanded(
                                        child: ListView.builder(
                                            itemCount: groupProvider.authorGroupLists.length,
                                            physics: const BouncingScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              var group = groupProvider.authorGroupLists[index];
                                              return GroupViewCard(
                                                  ontap: () {
                                                    Helper.toScreen(GroupDetailsPage(group.id.toString(), index: index));
                                                  },
                                                  name: group.name!,
                                                  photo: group.coverPhoto!,
                                                  message: 'Last active 0 minutes ago');
                                            }),
                                      ),
                                      loadMoreGroup(groupProvider.hasNextData, groupProvider.isBottomLoading, () {
                                        groupProvider.updateAuthorPageNo();
                                      }, 'Load more Groups')
                                    ],
                                  )
                                : const Center(child: Text("You Don't Have Any Group Yet")))
                    : const SizedBox.shrink(),
                dashboardWidget("Joined Groups", ImagesModel.joinedGroupIcon, true, () {
                  groupProvider.changeJoinedGroupStatus();
                }, expandedCondition: groupProvider.joinedGroup, isShowSubtitle: true, subTitle: 'You have been added to these groups.'),
                groupProvider.joinedGroup
                    ? SizedBox(
                        height: 290,
                        child: groupProvider.isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : groupProvider.joinedGroupList.isNotEmpty
                                ? Column(
                                    children: [
                                      Expanded(
                                        child: ListView.builder(
                                            physics: const BouncingScrollPhysics(),
                                            itemCount: groupProvider.joinedGroupList.length,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  groupProvider.trackJoinGroup(1);
                                                  Helper.toScreen(
                                                      GroupDetailsPage(groupProvider.joinedGroupList[index].id.toString(), index: index));
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets.all(8.0),
                                                  margin: const EdgeInsets.only(bottom: 9, left: 5, right: 5),
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
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          ClipRRect(
                                                              borderRadius: BorderRadius.circular(20),
                                                              child: Center(
                                                                  child: circularImage(
                                                                      groupProvider.joinedGroupList[index].coverPhoto!, 30, 30))),
                                                          const SizedBox(width: 5),
                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(groupProvider.joinedGroupList[index].name!,
                                                                  style: robotoStyle600SemiBold.copyWith(fontSize: 14)),
                                                              Text(
                                                                  '${groupProvider.joinedGroupList[index].totalMember!.toString()} members',
                                                                  style: robotoStyle400Regular.copyWith(fontSize: 13)),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(width: 10)
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                      ),
                                      loadMoreGroup(groupProvider.hasNextData, groupProvider.isBottomLoading, () {
                                        groupProvider.updateJoinedPageNo();
                                      }, 'Load more Groups')
                                    ],
                                  )
                                : Center(
                                    child: Text("You Don't Have Any Joined Group Yet",
                                        style: robotoStyle500Medium.copyWith(color: Colors.black, fontSize: 12))))
                    : const SizedBox.shrink(),
                dashboardWidget("Suggested Group", ImagesModel.suggestedGroupIcon, true, () {
                  groupProvider.changeSuggestedGroupStatus();
                },
                    expandedCondition: groupProvider.suggestedGroup,
                    isShowSubtitle: true,
                    subTitle: 'You might be interested in the following groups.'),
                const SizedBox(height: 10),
                groupProvider.suggestedGroup
                    ? SizedBox(
                        height: 300,
                        child: groupProvider.isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : groupProvider.suggestedGroupList.isNotEmpty
                                ? Column(
                                    children: [
                                      Expanded(
                                        child: GridView.builder(
                                          physics: const BouncingScrollPhysics(),
                                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                                          itemCount: groupProvider.suggestedGroupList.length,
                                          itemBuilder: (_, index) {
                                            return SuggestedGroupViewCard(groupProvider.suggestedGroupList[index], index);
                                          },
                                        ),
                                      ),
                                      loadMoreGroup(groupProvider.hasNextData, groupProvider.isBottomLoading, () {
                                        groupProvider.updateSuggestedPageNo();
                                      }, 'Load more Groups')
                                    ],
                                  )
                                : Center(
                                    child: Text("You Don't Have Suggested Joined Group Yet",
                                        style: robotoStyle500Medium.copyWith(color: Colors.black, fontSize: 12))))
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
                    groupProvider.resetTrackJoinGroup();
                    Helper.toScreen(const PinsGroup());
                  },
                ),
                const SizedBox(height: 10),
                LikeInviteFindWidget(
                  icon: ImagesModel.inviteFriendIcons,
                  name: "Invite Group",
                  extraArguments: "1+ new invites",
                  onTap: () {
                    groupProvider.resetTrackJoinGroup();
                    Helper.toScreen(const InvitesGroup());
                  },
                ),
                const SizedBox(height: 10),
                LikeInviteFindWidget(
                  icon: ImagesModel.findPageIcons,
                  name: "Find Group",
                  onTap: () {
                    groupProvider.resetTrackJoinGroup();
                    Helper.toScreen(const FindGroup());
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

Widget loadMoreGroup(bool hasNextData, bool isBottomLoading, Function onTap, String title) {
  return Column(
    children: [
      SizedBox(height: hasNextData || isBottomLoading ? 5 : 0),
      isBottomLoading
          ? const CupertinoActivityIndicator()
          : hasNextData
              ? InkWell(
                  onTap: () {
                    onTap();
                  },
                  child: Container(
                    height: 30,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                    decoration: BoxDecoration(border: Border.all(color: colorText), borderRadius: BorderRadius.circular(22)),
                    child: Text(title, style: robotoStyle500Medium.copyWith(color: colorText)),
                  ),
                )
              : const SizedBox.shrink(),
      SizedBox(height: hasNextData || isBottomLoading ? 10 : 0),
    ],
  );
}
