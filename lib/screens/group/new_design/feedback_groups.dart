
import 'package:als_frontend/provider/group_provider.dart';
import 'package:als_frontend/screens/group/widget/group_view_card.dart';
import 'package:als_frontend/screens/page/find_page.dart';
import 'package:als_frontend/screens/page/page_dashboard.dart';
import 'package:als_frontend/screens/page/widget/like_invite_find.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/image.dart';
import 'package:als_frontend/util/palette.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
                            radius: 20, backgroundColor: Colors.black, child: SvgPicture.asset("assets/svg/your_feed_icon.svg",height: 22,width: 25,)),
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
                Container(
                  decoration: BoxDecoration(color: const Color(0xffF0F2F5), borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                            radius: 20, backgroundColor: Colors.white, child: SvgPicture.asset("assets/svg/your_group_icon.svg",height: 22,width: 25),),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Your Group", style: robotoStyle700Bold.copyWith(fontSize: 20)),
                              const SizedBox(height: 2),
                              Text("View the all group that you manage.",
                                  style: robotoStyle400Regular.copyWith(fontSize: 10))
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: AppColors.primaryColorLight,
                          child: InkWell(
                              onTap: () {
                                groupProvider.changeYourGroupStatus();
                              },
                              child: groupProvider.yourGroup != true
                                  ? const Icon(Icons.arrow_drop_down, color: Colors.white)
                                  : const Icon(Icons.arrow_drop_up, color: Colors.white)),
                        )
                      ],
                    ),
                  ),
                ),
                groupProvider.yourGroup
                    ? SizedBox(
                    height: 250,
                    child: ListView.builder(
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return GroupViewCard(ontap: () {
                            //Helper.toScreen(const PublicPageScreen2());
                          }, name: 'City Travels', icon: Icons.favorite, message: 'Last active 50 minutes ago');
                        }))
                    : const SizedBox.shrink(),
                const SizedBox(height: 5),
                Container(
                  decoration: BoxDecoration(color: const Color(0xffF0F2F5), borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 20, backgroundColor: Colors.white, child: SvgPicture.asset("assets/svg/joined_groups_icon.svg",height: 22,width: 25),),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Joined Groups", style: robotoStyle700Bold.copyWith(fontSize: 20)),
                              const SizedBox(height: 2),
                              Text("You have been added to these groups.",
                                  style: robotoStyle400Regular.copyWith(fontSize: 10))
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: AppColors.primaryColorLight,
                          child: InkWell(
                              onTap: () {
                                groupProvider.changeJoinedGroupStatus();
                              },
                              child: groupProvider.joinedGroup != true
                                  ? const Icon(Icons.arrow_drop_down, color: Colors.white)
                                  : const Icon(Icons.arrow_drop_up, color: Colors.white)),
                        )
                      ],
                    ),
                  ),
                ),
                groupProvider.joinedGroup
              ? SizedBox(
              height: 250,
              child: ListView.builder(
                  itemCount:3,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          margin: const EdgeInsets.only(top: 6, bottom: 6),
                          decoration: BoxDecoration(
                              color: const Color(0xffFAFAFA),
                              boxShadow: [BoxShadow(color: Colors.grey.withOpacity(.2), blurRadius: 10.0, spreadRadius: 3.0, offset: const Offset(0.0, 0.0))],
                              borderRadius: BorderRadius.circular(15)),
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(width: 10,),
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Center(child: Image.asset("assets/background/profile_placeholder.jpg",height: 36,width: 36,))),
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
                                  onTap: (){
                                    groupProvider.changeEachJoinedGroupStatus();
                                  },
                                  child: groupProvider.eachJoinedGroup?
                                  SvgPicture.asset("assets/svg/play_up_vector.svg",height: 15,width: 15,)
                                      :SvgPicture.asset("assets/svg/play_down_vector.svg",height: 15,width: 15,)
                              ),
                              SizedBox(width: 10,)
                            ],
                          ),
                        ),
                        groupProvider.eachJoinedGroup?
                            Row(
                              children: [
                                Container(
                                  height: 47,
                                  width: 293,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)
                                    ),
                                    child : PopupMenuButton(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset("assets/svg/joined_svgs.svg",height: 12,width: 12,),
                                          SizedBox(width: 2,),
                                          Text('Joined',style: GoogleFonts.roboto(fontWeight: FontWeight.w700, fontSize: 15, color: AppColors.primaryColorLight),),
                                          SizedBox(width: 2,),
                                          SvgPicture.asset("assets/svg/up_arrow.svg",height: 5,width: 10,),
                                        ],
                                      ),
                                      itemBuilder: (context) => [
                                        // PopupMenuItem 1
                                        PopupMenuItem(
                                          child: Container(
                                            width: 150,
                                            height: 120,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const SizedBox(height: 10,),
                                                    SvgPicture.asset("assets/svg/notification_icon_svg.svg",height: 20,width: 20,),
                                                    const SizedBox(
                                                      width: 4,
                                                    ),
                                                    Text(
                                                      "Manage Notifications",
                                                      style:
                                                      GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 12, color: AppColors.primaryColorLight),
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  children: [
                                                    const SizedBox(height: 10,),
                                                    SvgPicture.asset("assets/svg/unfollow_svg.svg",height: 20,width: 15,),
                                                    const SizedBox(
                                                      width: 4,
                                                    ),
                                                    Text(
                                                      "Unfollow Group",
                                                      style:
                                                      GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 12, color: AppColors.primaryColorLight),
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  children: [
                                                    const SizedBox(height: 10,),
                                                    SvgPicture.asset("assets/svg/leave_group_svg.svg",height: 20,width: 20,),
                                                    const SizedBox(
                                                      width: 4,
                                                    ),
                                                    Text(
                                                      "Leave From Group",
                                                      style:
                                                      GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 12, color: AppColors.primaryColorLight),
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
                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 47,
                                  width: 93,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)
                                    ),
                                    child:
                                    PopupMenuButton(
                                      child: Container(
                                        height: 24,
                                        width: 30,
                                        color: const Color(0x00e4e6eb),
                                        child: const Icon(Icons.more_horiz),
                                      ),
                                      itemBuilder: (context) => [
                                        // PopupMenuItem 1
                                        PopupMenuItem(
                                          child: Container(
                                            width: 130,
                                            height: 110,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const SizedBox(height: 10,),
                                                    SvgPicture.asset("assets/svg/pins_group_icon.svg",height: 20,width: 20,),
                                                    const SizedBox(
                                                      width: 4,
                                                    ),
                                                    Text(
                                                      "Pin Group",
                                                      style:
                                                      GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 12, color: AppColors.primaryColorLight),
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(height: 10,),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset("assets/svg/share.svg",height: 15,width: 15,),
                                                    const SizedBox(
                                                      width: 4,
                                                    ),
                                                    Text(
                                                      "Share",
                                                      style:
                                                      GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 12, color: AppColors.primaryColorLight),
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(height: 10,),
                                                Row(
                                                  children: [
                                                    const SizedBox(height: 10,),
                                                    const Icon(Icons.copy,size: 15,),
                                                    const SizedBox(
                                                      width: 4,
                                                    ),
                                                    Text(
                                                      "Copy Link",
                                                      style:
                                                      GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 12, color: AppColors.primaryColorLight),
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(height: 10,),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset("assets/svg/leave_group_svg.svg",height: 15,width: 15,),
                                                    const SizedBox(
                                                      width: 4,
                                                    ),
                                                    Text(
                                                      "Leave",
                                                      style:
                                                      GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 12, color: AppColors.primaryColorLight),
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(height: 10,),
                                              ],
                                            ),
                                          ),
                                        ),
                                        // PopupMenuItem 2
                                      ],
                                      offset: const Offset(0, 58),
                                      color: Colors.white,
                                      elevation: 4,
                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                    ),
                                  ),
                                ),
                              ],
                            ): const SizedBox.shrink(),
                      ],
                    );
                  }))
              : const SizedBox.shrink(),
                const SizedBox(height: 5),
                Container(
                  decoration: BoxDecoration(color: const Color(0xffF0F2F5), borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 20, backgroundColor: Colors.white, child: SvgPicture.asset("assets/svg/suggested_group_icon.svg",height: 22,width: 25),),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Suggested Group", style: robotoStyle700Bold.copyWith(fontSize: 20)),
                              const SizedBox(height: 2),
                              Text("You might be interested in the following groups.",
                                  style: robotoStyle400Regular.copyWith(fontSize: 10))
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: AppColors.primaryColorLight,
                          child: InkWell(
                              onTap: () {
                                groupProvider.changeSuggestedGroupStatus();
                              },
                              child: groupProvider.suggestedGroup != true
                                  ? const Icon(Icons.arrow_drop_down, color: Colors.white)
                                  : const Icon(Icons.arrow_drop_up, color: Colors.white)),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                groupProvider.suggestedGroup?
                    SizedBox(
                      height: 500,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2
                        ),
                        itemCount: 6,
                        itemBuilder: (_,index){
                          return Card(
                            elevation: 1,
                            child: Container(
                              height: 130,
                              width: 194,
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8),
                                    ),
                                    child: Image.network('https://wander-lush.org/wp-content/uploads/2022/03/Beautiful-places-in-Bangladesh-WMC-hero.jpg',
                                    height: 84,
                                    fit: BoxFit.fitWidth,width: double.infinity,),
                                  ),
                                  SizedBox(height: 5,),
                                  Row(
                                    children: [
                                     const SizedBox(width: 5,),
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text('City Travels',style: GoogleFonts.roboto(fontWeight: FontWeight.w700, fontSize: 18, color: AppColors.primaryColorLight),)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(width: 5,),
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text('570K Members - 10+ Post a Day',style: GoogleFonts.roboto(fontWeight: FontWeight.w700, fontSize: 10, color: AppColors.primaryColorLight),)),
                                    ],
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 19,
                                          width: 120,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                              color: Color(0xffE7F3FF)
                                          ),
                                          child: Center(
                                            child: Text('Join Group',style: GoogleFonts.roboto(fontWeight: FontWeight.w700, fontSize: 10, color: AppColors.primaryColorLight)),
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          height: 19,
                                          width: 30,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            color: Color(0xffE7F3FF)
                                          ),
                                          child: Center(
                                            child: Icon(Icons.more_horiz,size: 15,),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ):
                    SizedBox.shrink(),
                const SizedBox(height: 10),
                InkWell(
                  onTap: (){
                    //Helper.toScreen(const CreatePageScreen());
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
                const LikeInviteFindWidget(icon: ImagesModel.pins_the_group, name: "Pins Group",),
                const SizedBox(height: 10),
                LikeInviteFindWidget(icon: ImagesModel.inviteFriendIcons, name: "Invite Group", extraArguments: " 25 new invites",
                  onTap: (){
                    Helper.toScreen(const PageDashboard());
                  },),
                const SizedBox(height: 10),
                LikeInviteFindWidget(icon: ImagesModel.findPageIcons, name: "Find Group",onTap: (){
                  Helper.toScreen(const FindPage());
                },),
              ],
            ),
          );
        }),
      ),
    );
  }
}