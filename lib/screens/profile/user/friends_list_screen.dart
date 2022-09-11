import 'package:als_frontend/const/palette.dart';
import 'package:als_frontend/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../provider/provider.dart';
import '../../../widgets/widgets.dart';

class FriendListScreen extends StatefulWidget {
  const FriendListScreen({Key? key}) : super(key: key);

  @override
  State<FriendListScreen> createState() => _FriendListScreenState();
}

class _FriendListScreenState extends State<FriendListScreen> {
  @override
  void initState() {
    final value = Provider.of<FriendsListProvider>(context, listen: false);
    value.getData();
    super.initState();
  }

  refresh() {
    final value = Provider.of<FriendsListProvider>(context, listen: false);
    value.getData();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
          title: Consumer<FriendsListProvider>(
              builder: (context, provider, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Friends",
                  style: GoogleFonts.lato(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                (provider.isLoaded == false)
                    ? Text(
                        "${0} friends",
                        style: GoogleFonts.lato(color: Colors.black),
                      )
                    : Text(
                        "${provider.friendsList.length} friends",
                        style: const TextStyle(color: Colors.black),
                      )
              ],
            );
          }),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Consumer4<FriendsListProvider, PublicProfileDetailsProvider,
                UnFriendProvider, UserNewsfeedPostProvider>(
            builder: (context, friendsListProvider, publicProvider,
                unfriendProvider, newssFeedPostProvider, child) {
          return (friendsListProvider.isLoaded == false)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: friendsListProvider.friendsList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        publicProvider.id =
                            friendsListProvider.friendsList[index].id;
                        newssFeedPostProvider.id =
                            friendsListProvider.friendsList[index].id;
                        Get.to(() => const PublicProfileDetailsScreen());
                      },
                      child: FriendListCard(
                          verb: "Unfriend",
                          onPressed: () {
                            unfriendProvider.id =
                                friendsListProvider.friendsList[index].id;
                            
                            unfriendProvider.unFriend();
                            refresh();
                          },
                          width: width,
                          height: height,
                          name: friendsListProvider.friendsList[index].fullName,
                          image: friendsListProvider
                              .friendsList[index].profileImage),
                    );
                  });
        }));
  }
}
