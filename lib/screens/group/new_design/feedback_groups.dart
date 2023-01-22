
import 'package:als_frontend/new_page_degsin/widget/Page_view_card.dart';
import 'package:als_frontend/new_page_degsin/widget/like_invite_find.dart';
import 'package:als_frontend/provider/group_provider.dart';
import 'package:als_frontend/screens/page/find_page.dart';
import 'package:als_frontend/screens/page/page_dashboard.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/image.dart';
import 'package:als_frontend/util/palette.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                          return PageviewCard(ontap: () {
                            //Helper.toScreen(const PublicPageScreen2());
                          }, name: 'Your Pages', icon: Icons.favorite, message: '20 message');
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
                const LikeInviteFindWidget(icon: ImagesModel.pinsIcon, name: "Pins Group",),
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