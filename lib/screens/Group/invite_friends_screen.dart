import 'package:als_frontend/service/friends/search_group_friend_list._service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../provider/provider.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class InviteFriendScreen extends StatefulWidget {
  const InviteFriendScreen({Key? key}) : super(key: key);

  @override
  State<InviteFriendScreen> createState() => _InviteFriendScreenState();
}

class _InviteFriendScreenState extends State<InviteFriendScreen> {
  TextEditingController searchController = TextEditingController();
  int value = 0;
  @override
  void initState() {
    value = 0;
    final friendList =
        Provider.of<GroupInviteFriendListProvider>(context, listen: false);
    friendList.getData();
    super.initState();
  }

  void refresh() {
    final friendList =
        Provider.of<GroupInviteFriendListProvider>(context, listen: false);
    friendList.getData();
    // final searchList =
    //     Provider.of<SearchGroupFriendListService>(context, listen: false);
    // searchList.getFriendsList();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  child: Container(
                    height: height * 0.055,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5))),
                    child: TextFormField(
                        controller: searchController,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: "search",
                          hintStyle: GoogleFonts.lato(),
                          border: InputBorder.none,
                          fillColor: Colors.white24,
                          labelStyle: const TextStyle(color: Colors.black),
                          filled: true,
                        )),
                  ),
                ),
                Consumer2<GroupFriendSearchProvider,
                        GroupInviteFriendListProvider>(
                    builder: (context, searchProvider,
                        groupInviteFriendListProvider, child) {
                  return SizedBox(
                    height: height * 0.055,
                    width: width * 0.18,
                    child: ElevatedButton(
                        onPressed: () {
                          searchProvider.friendsList = [];
                          searchProvider.groupId =
                              groupInviteFriendListProvider.groupId;
                          searchProvider.value = searchController.text;
                          searchProvider.getData();
                          if (searchController.text.isNotEmpty) {
                            setState(() {
                              value = 1;
                            });
                          } else {
                            Fluttertoast.showToast(
                                msg: "Insert a name to search");
                          }
                        },
                        child: const Icon(Icons.search)),
                  );
                }),
              ],
            ),
            (value == 0)
                ? Consumer3<GroupInviteFriendListProvider,
                        PublicProfileDetailsProvider, GroupInviteProvider>(
                    builder: (context, friendsListProvider, publicProvider,
                        groupInviteProvider, child) {
                    return (friendsListProvider.isLoaded == false)
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : SingleChildScrollView(
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount:
                                    friendsListProvider.friendsList.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      publicProvider.id = friendsListProvider
                                          .friendsList[index].id;
                                      Get.to(() =>
                                          const PublicProfileDetailsScreen());
                                    },
                                    child: FriendListCard(
                                        verb: "Invite",
                                        onPressed: () {
                                          groupInviteProvider.userId =
                                              friendsListProvider
                                                  .friendsList[index].id;
                                          groupInviteProvider.sendInvitation();
                                          refresh();
                                        },
                                        width: width,
                                        height: height,
                                        name: friendsListProvider
                                            .friendsList[index].fullName,
                                        image: friendsListProvider
                                            .friendsList[index].profileImage),
                                  );
                                }),
                          );
                  })
                : Consumer4<
                        GroupFriendSearchProvider,
                        PublicProfileDetailsProvider,
                        GroupInviteProvider,
                        GroupFriendSearchProvider>(
                    builder: (context, groupfriendsListProvider, publicProvider,
                        groupInviteProvider, groupFriendSearchProvider, child) {
                    return SingleChildScrollView(
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount:
                              groupFriendSearchProvider.friendsList.length,
                          itemBuilder: (context, index) {
                            return (groupFriendSearchProvider
                                    .friendsList.isNotEmpty)
                                ? InkWell(
                                    onTap: () {
                                      publicProvider.id =
                                          groupfriendsListProvider
                                              .friendsList[index].id;
                                      Get.to(() =>
                                          const PublicProfileDetailsScreen());
                                    },
                                    child: FriendListCard(
                                        verb: "Invite",
                                        onPressed: () {
                                          groupInviteProvider.userId =
                                              groupfriendsListProvider
                                                  .friendsList[index].id;
                                          groupInviteProvider.sendInvitation();
                                          refresh();
                                        },
                                        width: width,
                                        height: height,
                                        name: groupFriendSearchProvider
                                            .friendsList[index].fullName,
                                        image: groupFriendSearchProvider
                                            .friendsList[index].profileImage),
                                  )
                                : const Center(
                                    child: Text("No result found"),
                                  );
                          }),
                    );
                    // : const Text("no results found");
                  })
          ],
        ),
      ),
    );
  }
}
