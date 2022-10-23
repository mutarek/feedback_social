import 'package:als_frontend/old_code/const/palette.dart';
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
import 'package:als_frontend/widgets/single_image_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<GroupProvider>(context, listen: false).callForGetAllGroupInformation(widget.groupID);
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          body: SafeArea(
            child: Consumer2<GroupProvider, AuthProvider>(
                builder: (context, groupProvider, authProvider, child) => (groupProvider.isLoading)
                    ? const MyGroupShimmerWidget(): NestedScrollView(
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        // Setting floatHeaderSlivers to true is required in order to float
                        // the outer slivers over the inner scrollable.
                        floatHeaderSlivers: true,
                        headerSliverBuilder: (context, innerBoxIsScrolled) {
                          return [
                            SliverList(
                                delegate: SliverChildListDelegate([
                              Container(
                                height: 270,
                                width: width,
                                color: Palette.scaffold,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Stack(
                                        children: [
                                          SizedBox(
                                            width: width,
                                            child: CoverPhotoWidget(
                                              isTrue: false,
                                              coverPhotoChange: () {},
                                              back: () {
                                                Get.back();
                                              },
                                              coverPhoto: groupProvider.groupDetailsModel.coverPhoto!,
                                              viewCoverPhoto: () {
                                                Get.to(() => SingleImageView(imageURL: groupProvider.groupDetailsModel.coverPhoto!));
                                              },
                                            ),
                                          ),
                                          Positioned(
                                            top: height * 0.21,
                                            child: Container(
                                              height: height * 0.14,
                                              width: width,
                                              decoration: const BoxDecoration(
                                                  color: Palette.scaffold, borderRadius: BorderRadius.all(Radius.circular(15))),
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
                                                    Text(groupProvider.groupDetailsModel.name!,
                                                        style: TextStyle(fontSize: height * 0.03, fontWeight: FontWeight.bold)),
                                                    Padding(
                                                        padding: EdgeInsets.only(right: width * 0.227),
                                                        child: Text(groupProvider.groupDetailsModel.category!)),
                                                    SizedBox(height: height * 0.01),
                                                    InkWell(
                                                      onTap: () {
                                                        // groupFriendListProvider.friendsList = [];
                                                        // groupInviteProvider.groupId = groupProvider.groupDetails!.id as int;
                                                        // groupFriendListProvider.groupId = groupProvider.groupDetails!.id as int;
                                                        Get.to(() => InviteGroupScreen(int.parse(widget.groupID)));
                                                      },
                                                      child: CircleAvatar(
                                                        backgroundColor: Palette.notificationColor,
                                                        radius: 20,
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            const Icon(FontAwesomeIcons.plus, size: 8, color: Colors.white),
                                                            Text("Invite", style: GoogleFonts.lato(fontSize: 10, color: Colors.white))
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
                                                      const Text("Members"),
                                                      SizedBox(height: height * 0.014),
                                                      InkWell(
                                                        onTap: () {
                                                          Provider.of<OtherProvider>(context, listen: false).clearImage();
                                                          Navigator.of(context).pop();
                                                          Navigator.of(context).push(MaterialPageRoute(
                                                              builder: (_) => CreateGroupScreen(
                                                                  authorGroup: groupProvider.groupDetailsModel,
                                                                  isUpdateGroup: true,
                                                                  index: widget.index)));

                                                          // editGroupProvider.groupId = groupProvider.groupDetails!.id as int;
                                                          // Get.to(() => const EditGroup());
                                                        },
                                                        child: Container(
                                                          height: height * 0.036,
                                                          width: width * 0.2,
                                                          decoration: BoxDecoration(
                                                              color: Palette.primary, borderRadius: BorderRadius.circular(10)),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              const Icon(FontAwesomeIcons.penToSquare, size: 14, color: Colors.white),
                                                              SizedBox(width: width * 0.007),
                                                              Text("Edit Group",
                                                                  style: TextStyle(fontSize: height * 0.012, color: Colors.white))
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
                                          SizedBox(height: height * 0.02),
                                        ],
                                      ),
                                      Container(
                                        height: height * 0.03,
                                        color: Colors.white,
                                        child: TabBar(tabs: [
                                          Text("Discussion", style: TextStyle(fontSize: height * 0.013, color: Colors.black)),
                                          Text("Photos", style: TextStyle(fontSize: height * 0.013, color: Colors.black)),
                                          Text("Videos", style: TextStyle(fontSize: height * 0.013, color: Colors.black)),
                                          Text("Members", style: TextStyle(fontSize: height * 0.013, color: Colors.black)),
                                        ]),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ]))
                          ];
                        },
                        body: TabBarView(
                          children: [
                            SingleChildScrollView(
                              physics: const ScrollPhysics(),
                              child: Column(
                                children: [
                                  createPostWidget(context, authProvider, isForGroup: true, groupID: int.parse(widget.groupID)),

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
                                                isGroup: true, groupID: int.parse(widget.groupID)));
                                      }),
                                ],
                              ),
                            ),
                            GroupImageVideoView(int.parse(widget.groupID)),
                            GroupImageVideoView(int.parse(widget.groupID), isForImage: false),
                            const GroupMemberView(),
                          ],
                        ),
                      )),
          ),
        ));
  }
}
