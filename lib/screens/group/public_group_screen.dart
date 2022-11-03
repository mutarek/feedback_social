import 'package:als_frontend/old_code/const/palette.dart';
import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/provider/group_provider.dart';
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

class PublicGroupScreen extends StatefulWidget {
  final String groupID;
  final int index;
  final bool isFromMYGroup;

  const PublicGroupScreen(this.groupID, {this.index = 0, this.isFromMYGroup = false, Key? key}) : super(key: key);

  @override
  State<PublicGroupScreen> createState() => _PublicGroupScreenState();
}

class _PublicGroupScreenState extends State<PublicGroupScreen> {
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
    return RefreshIndicator(
      onRefresh: () {
        return _refresh(context);
      },
      child: DefaultTabController(
          length: 4,
          child: Scaffold(
            body: SafeArea(
              child: Consumer2<GroupProvider, AuthProvider>(
                  builder: (context, groupProvider, authProvider, child) => (groupProvider.isLoading)
                      ? const MyGroupShimmerWidget()
                      : NestedScrollView(
                          scrollDirection: Axis.vertical,
                          // physics: const NeverScrollableScrollPhysics(),
                          floatHeaderSlivers: true,
                    controller: controller,
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
                                                            if (groupProvider.groupDetailsModel.isMember == false) {
                                                              groupProvider.memberJoin(int.parse(widget.groupID));
                                                            } else {
                                                              groupProvider.leaveGroup(int.parse(widget.groupID),
                                                                  index: widget.index, isFromMYGroup: widget.isFromMYGroup);
                                                            }
                                                          },
                                                          child: Container(
                                                            height: height * 0.036,
                                                            width: width * 0.2,
                                                            decoration: BoxDecoration(
                                                                color: (groupProvider.groupDetailsModel.isMember == false)
                                                                    ? Palette.primary
                                                                    : Colors.red,
                                                                borderRadius: BorderRadius.circular(10)),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Icon(
                                                                  (groupProvider.groupDetailsModel.isMember == false)
                                                                      ? FontAwesomeIcons.userGroup
                                                                      : FontAwesomeIcons.arrowRight,
                                                                  size: 14,
                                                                  color: Colors.white,
                                                                ),
                                                                SizedBox(
                                                                  width: width * 0.007,
                                                                ),
                                                                Text(
                                                                  (groupProvider.groupDetailsModel.isMember == false)
                                                                      ? "Join Group"
                                                                      : "Leave",
                                                                  style: TextStyle(fontSize: height * 0.012, color: Colors.white),
                                                                )
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
                                    groupProvider.groupDetailsModel.isMember == false
                                        ? const SizedBox.shrink()
                                        : createPostWidget(context, authProvider, isForGroup: true, groupPageID: int.parse(widget.groupID)),

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
                                ),
                              ),
                              GroupImageVideoView(int.parse(widget.groupID)),
                              GroupImageVideoView(int.parse(widget.groupID), isForImage: false),
                              const GroupMemberView(),
                            ],
                          ),
                        )),
            ),
          )),
    );
  }
}
