import 'package:als_frontend/const/palette.dart';
import 'package:als_frontend/provider/provider.dart';
import 'package:als_frontend/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

import '../../widgets/widgets.dart';

class FriendRequest extends StatefulWidget {
  const FriendRequest({Key? key}) : super(key: key);

  @override
  State<FriendRequest> createState() => _FriendRequestState();
}

class _FriendRequestState extends State<FriendRequest> {
  @override
  void initState() {
    final value = Provider.of<FriendRequestProvider>(context, listen: false);
    value.getData();
    value.getSuggetionsData();
    final notification =
        Provider.of<NotificationsProvider>(context, listen: false);
    notification.getData();
    notification.check();
    super.initState();
  }

  Future<void> _refresh() async {
    final data = Provider.of<FriendRequestProvider>(context, listen: false);
    data.getData();
    data.getSuggetionsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Text(
          "Friends",
          style: TextStyle(
              fontSize: 28,
              color: Palette.primary,
              fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () => _refresh(),
        child: Consumer5<
                ConfirmFriendRequestProvider,
                FriendRequestProvider,
                AddFriendProvider,
                PublicProfileDetailsProvider,
                UserNewsfeedPostProvider>(
            builder: (context, provider2, provider, addProvider,
                userNewsfeedPostProvider, publicProfileProvider, child) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Container(
                  height: 70,
                  width: double.maxFinite,
                  color: Colors.white,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomElevatedButton(
                          onPressed: () {
                            _refresh();
                            provider.friendRequest();
                          },
                          text: "Friend request",
                          buttonColor: (provider.showSuggetions == false)
                              ? Palette.primary
                              : Colors.white,
                          textColor: (provider.showSuggetions == false)
                              ? Colors.white
                              : Palette.primary,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomElevatedButton(
                          onPressed: () {
                            _refresh();
                            provider.friendSuggestion();
                          },
                          text: "Suggetions",
                          buttonColor: (provider.showSuggetions == true)
                              ? Palette.primary
                              : Colors.white,
                          textColor: (provider.showSuggetions == true)
                              ? Colors.white
                              : Palette.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: (provider.showSuggetions == false)
                    ? (provider.hasData == false)
                        ? const Center(
                            child: Text("You have no friend request"),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return FrindRequestCard(
                                ontap: () {
                                  publicProfileProvider.id = provider
                                      .friendRequests[index].fromUser.id;

                                  Get.to(
                                      () => const PublicProfileDetailsScreen());
                                },
                                ontapconfrim: () {
                                  provider2.id =
                                      provider.friendRequests[index].id;
                                  provider2.confirmRequest();
                                  _refresh();
                                },
                                ontapdelete: () {
                                  provider2.id =
                                      provider.friendRequests[index].id;
                                  provider2.cancelRequest();
                                  _refresh();
                                },
                                picture: provider.friendRequests[index].fromUser
                                    .profileImage,
                                name:
                                    "${provider.friendRequests[index].fromUser.firstName} ${provider.friendRequests[index].fromUser.lastName}",
                              );
                            },
                            itemCount: provider.friendRequests.length,
                          )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return FrindRequestCard(
                            ontap: () {
                              userNewsfeedPostProvider.id =
                                  provider.friendsSuggetions[index].id;
                              publicProfileProvider.id =
                                  provider.friendsSuggetions[index].id;

                              Get.to(() => const PublicProfileDetailsScreen());
                            },
                            ontapconfrim: () {
                              _refresh();
                              addProvider.id =
                                  provider.friendsSuggetions[index].id;
                              addProvider.addSuggestedFriend();
                            },
                            confirmText: "Add friend",
                            deleteText: "Cancel",
                            ontapdelete: () {
                              _refresh();
                            },
                            picture:
                                provider.friendsSuggetions[index].profileImage,
                            name:
                                "${provider.friendsSuggetions[index].firstName} ${provider.friendsSuggetions[index].lastName}",
                          );
                        },
                        itemCount: provider.friendsSuggetions.length,
                      ),
              )
            ],
          );
        }),
      ),
    );
  }
}
