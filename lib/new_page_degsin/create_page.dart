import 'package:als_frontend/new_page_degsin/widget/Page_view_card.dart';
import 'package:als_frontend/new_page_degsin/widget/like_invite_find.dart';
import 'package:als_frontend/provider/page_provider.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/image.dart';
import 'package:als_frontend/util/palette.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../screens/page/new_design/create_page.dart';

class CreatePage extends StatelessWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text("Feedback Pages", style: robotoStyle700Bold.copyWith(fontSize: 24)),
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
        child: Consumer<PageProvider>(builder: (context, pageProvider, child) {
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
                            radius: 20, backgroundColor: Colors.white, child: Image.asset(ImagesModel.pageIconsPng, width: 29, height: 29)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Your Pages", style: robotoStyle700Bold.copyWith(fontSize: 20)),
                              const SizedBox(height: 2),
                              Text("You can manage them by click on page switch mode button.",
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
                                pageProvider.changeExpended();
                                showLog(pageProvider.pageExpended);
                              },
                              child: pageProvider.pageExpended != true
                                  ? const Icon(Icons.arrow_drop_down, color: Colors.white)
                                  : const Icon(Icons.arrow_drop_up, color: Colors.white)),
                        )
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                pageProvider.pageExpended == true
                    ? SizedBox(
                        height: 250,
                        child: ListView.builder(
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return PageviewCard(ontap: () {}, name: 'Your Pages', icon: Icons.favorite, message: '20 message');
                            }))
                    : const SizedBox.shrink(),
                const SizedBox(height: 10),
                InkWell(
                  onTap: (){
                    Helper.toScreen(CreatePageScreen());
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
                        Text("Create a new Pages", style: robotoStyle500Medium.copyWith(fontSize: 18))
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                const Divider(height: 1, color: Colors.black45),
                const SizedBox(height: 5),
                const LikeInviteFindWidget(icon: ImagesModel.likeIcons, name: "Your liked pages", extraArguments: " 30 pages"),
                const SizedBox(height: 10),
                const LikeInviteFindWidget(icon: ImagesModel.inviteFriendIcons, name: "Invite Pages", extraArguments: " 25 new invites"),
                const SizedBox(height: 10),
                const LikeInviteFindWidget(icon: ImagesModel.findPageIcons, name: "Find pages"),
              ],
            ),
          );
        }),
      ),
    );
  }
}
