import 'package:als_frontend/provider/group_provider.dart';
import 'package:als_frontend/provider/profile_provider.dart';
import 'package:als_frontend/screens/page/page_dashboard.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/image.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/network_image.dart';
import 'package:als_frontend/widgets/snackbar_message.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class GroupAccessView extends StatelessWidget {
  final bool isFromPage;

  const GroupAccessView(this.isFromPage, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<GroupProvider, ProfileProvider>(
        builder: (context, groupProvider, profileProvider, child) => Column(
              children: [
                dashboardWidget("Group Access", ImagesModel.groupAccess, true, () {
                  groupProvider.changeAdminAccessExpanded();
                }, expandedCondition: groupProvider.adminAccessPage),
                groupProvider.adminAccessPage == true
                    ? SizedBox(
                        height: groupProvider.adminSectionAccess || groupProvider.moderatorSectionAccess ? 500 : 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //TODO: FOR ADMIN SECTION

                            SizedBox(
                              width: screenWeight() * 0.7,
                              height: 48,
                              child: dashboardWidget("Admin Section", ImagesModel.groupAccess, true, () {
                                groupProvider.changeAdminSectionAccessExpanded(isFromPage);
                              }, expandedCondition: groupProvider.adminSectionAccess, fontSize: 14),
                            ),

                            groupProvider.adminSectionAccess
                                ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 21,
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        decoration:
                                            BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.primaryColorLight),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('Admin List', style: robotoStyle500Medium.copyWith(fontSize: 12, color: Colors.white)),
                                          ],
                                        ),
                                      ),
                                      groupProvider.isLoadingAdminModerator || groupProvider.adminModeratorLists.isEmpty
                                          ? Container(
                                              height: 100,
                                              alignment: Alignment.center,
                                              width: screenWeight(),
                                              child: groupProvider.isLoadingAdminModerator
                                                  ? const CircularProgressIndicator()
                                                  : Text('Admin Not Available in this ${isFromPage ? 'page' : 'group'}',
                                                      style: robotoStyle500Medium))
                                          : ListView.builder(
                                              itemCount: groupProvider.adminModeratorLists.length,
                                              shrinkWrap: true,
                                              physics: const NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  padding: const EdgeInsets.all(4),
                                                  width: screenWeight() * 0.6,
                                                  margin: const EdgeInsets.only(bottom: 10),
                                                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                                                  child: Row(
                                                    children: [
                                                      circularImage(groupProvider.adminModeratorLists[index].profileImage!, 20, 20),
                                                      const SizedBox(width: 10),
                                                      Expanded(
                                                          child: Text(groupProvider.adminModeratorLists[index].fullName!,
                                                              style: robotoStyle700Bold.copyWith(fontSize: 11, color: Colors.black))),
                                                      const CircleAvatar(
                                                          backgroundColor: Colors.white, child: Icon(Icons.more_horiz, color: Colors.black))
                                                    ],
                                                  ),
                                                );
                                              }),
                                      InkWell(
                                        onTap: () {
                                          bool value = groupProvider.changeAddNewContentSection();
                                          if (value == true) {
                                            profileProvider.callForGetAllFriendsPagination();
                                          }
                                        },
                                        child: Container(
                                          width: 120,
                                          height: 21,
                                          margin: const EdgeInsets.only(bottom: 7),
                                          decoration:
                                              BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.primaryColorLight),
                                          child: Center(
                                              child: Text(!groupProvider.addNewContent ? 'Add New Admin' : 'Close',
                                                  style: robotoStyle500Medium.copyWith(
                                                      fontSize: 12, color: !groupProvider.addNewContent ? Colors.white : Colors.red))),
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox.shrink(),
                            groupProvider.addNewContent && groupProvider.adminSectionAccess
                                ? buildExpanded(profileProvider, groupProvider, true)
                                : const SizedBox.shrink(),

                            SizedBox(
                              width: screenWeight() * 0.7,
                              height: 48,
                              child: dashboardWidget("Moderator Section", ImagesModel.groupAccess, true, () {
                                groupProvider.changeModeratorSectionAccessExpanded(isFromPage);
                              }, expandedCondition: groupProvider.moderatorSectionAccess, fontSize: 14),
                            ),

                            groupProvider.moderatorSectionAccess
                                ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 86,
                                        height: 21,
                                        decoration:
                                            BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.primaryColorLight),
                                        child: Center(
                                          child: Text('Moderator List',
                                              style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 12, color: Colors.white)),
                                        ),
                                      ),
                                      groupProvider.isLoadingAdminModerator || groupProvider.adminModeratorLists.isEmpty
                                          ? Container(
                                              height: 100,
                                              alignment: Alignment.center,
                                              width: screenWeight(),
                                              child: groupProvider.isLoadingAdminModerator
                                                  ? const CircularProgressIndicator()
                                                  : Text('Moderator Not Available in this ${isFromPage?'page':'group'}', style: robotoStyle500Medium))
                                          : ListView.builder(
                                              itemCount: groupProvider.adminModeratorLists.length,
                                              shrinkWrap: true,
                                              physics: const NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  padding: const EdgeInsets.all(4),
                                                  width: screenWeight() * 0.6,
                                                  margin: const EdgeInsets.only(bottom: 5, top: 5),
                                                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                                                  child: Row(
                                                    children: [
                                                      circularImage(groupProvider.adminModeratorLists[index].profileImage!, 20, 20),
                                                      const SizedBox(width: 10),
                                                      Expanded(
                                                          child: Text(groupProvider.adminModeratorLists[index].fullName!,
                                                              style: robotoStyle700Bold.copyWith(fontSize: 11, color: Colors.black))),
                                                      const CircleAvatar(
                                                          backgroundColor: Colors.white, child: Icon(Icons.more_horiz, color: Colors.black))
                                                    ],
                                                  ),
                                                );
                                              }),
                                      InkWell(
                                        onTap: () {
                                          bool value = groupProvider.changeAddNewContentSection();
                                          if (value == true) {
                                            profileProvider.callForGetAllFriendsPagination();
                                          }
                                        },
                                        child: Container(
                                          width: 120,
                                          height: 21,
                                          margin: const EdgeInsets.only(bottom: 7),
                                          decoration:
                                              BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.primaryColorLight),
                                          child: Center(
                                              child: Text(!groupProvider.addNewContent ? 'Add New Moderator' : 'Close',
                                                  style: robotoStyle500Medium.copyWith(
                                                      fontSize: 12, color: !groupProvider.addNewContent ? Colors.white : Colors.red))),
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox.shrink(),

                            groupProvider.addNewContent && groupProvider.moderatorSectionAccess
                                ? buildExpanded(profileProvider, groupProvider, false)
                                : const SizedBox.shrink(),
                          ],
                        ))
                    : const SizedBox.shrink(),
              ],
            ));
  }

  Expanded buildExpanded(ProfileProvider profileProvider, GroupProvider groupProvider, bool isAdmin) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
            child: Column(
              children: [
                Expanded(
                  child: profileProvider.isLoadingSuggestedFriend
                      ? const Center(child: CircularProgressIndicator())
                      : profileProvider.myFriendLists.isEmpty
                          ? const Center(child: Text("Ops You have no friends"))
                          : ListView.builder(
                              itemCount: profileProvider.myFriendLists.length,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, position) {
                                return Row(
                                  children: [
                                    SizedBox(
                                        width: 30,
                                        height: 30,
                                        child: circularImage(profileProvider.myFriendLists[position].profileImage!, 30, 30)),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(profileProvider.myFriendLists[position].fullName!,
                                          style: robotoStyle500Medium.copyWith(fontSize: 12)),
                                    ),
                                    Checkbox(
                                      value: profileProvider.makeAdminFriendsSelect[position],
                                      onChanged: (value) {
                                        profileProvider.changeAddAdminSelectionValue(position, value!);
                                      },
                                    )
                                  ],
                                );
                              }),
                ),
                const SizedBox(height: 5),
                profileProvider.isBottomLoading
                    ? const CircularProgressIndicator()
                    : profileProvider.hasNextData
                        ? InkWell(
                            onTap: () {
                              profileProvider.updateAllFriendsPage();
                            },
                            child: Container(
                              height: 30,
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                              decoration: BoxDecoration(border: Border.all(color: colorText), borderRadius: BorderRadius.circular(22)),
                              child: Text('Load more Friend', style: robotoStyle500Medium.copyWith(color: colorText)),
                            ),
                          )
                        : const SizedBox.shrink(),
                const SizedBox(height: 5),
                InkWell(
                  onTap: () {
                    bool isSelectAtLeastOne = false;
                    List<int> userIds = [];
                    for (int i = 0; i < profileProvider.myFriendLists.length; i++) {
                      if (profileProvider.makeAdminFriendsSelect[i] == true) {
                        isSelectAtLeastOne = true;
                        userIds.add(profileProvider.myFriendLists[i].id as int);
                      }
                    }
                    if (isSelectAtLeastOne == true) {
                      groupProvider.makeAdminModerator(userIds, isAdmin, isFromPage);
                    } else {
                      showMessage(message: 'Please Select at least one Friend');
                    }
                  },
                  child: groupProvider.isLoadingAdminModerator2
                      ? const Center(child: CircularProgressIndicator())
                      : Container(
                          height: 25,
                          width: screenWeight() * 0.7,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(45), color: AppColors.primaryColorLight),
                          child: Center(
                            child: Text('Make ${isAdmin ? "Admin" : "Moderator"}',
                                style: robotoStyle700Bold.copyWith(fontSize: 13, color: Colors.white)),
                          ),
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
