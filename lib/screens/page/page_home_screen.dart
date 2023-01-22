import 'package:als_frontend/provider/page_provider.dart';
import 'package:als_frontend/screens/page/find_page.dart';
import 'package:als_frontend/screens/page/new_design/new_my_liked_page_screen.dart';
import 'package:als_frontend/screens/page/new_design/new_suggested_page_screen.dart';
import 'package:als_frontend/screens/page/page_dashboard.dart';
import 'package:als_frontend/screens/page/widget/like_invite_find.dart';
import 'package:als_frontend/screens/page/widget/page_app_bar.dart';
import 'package:als_frontend/screens/page/widget/page_view_widget.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/image.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:als_frontend/widgets/snackbar_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'new_design/create_page1.dart';

class PageHomeScreen extends StatelessWidget {
  const PageHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PageAppBar(title: 'Feedback Pages', isOpenPageSettings: true, isBackButtonExist: false),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Consumer<PageProvider>(builder: (context, pageProvider, child) {
          return pageProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  children: [
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(color: const Color(0xffF0F2F5), borderRadius: BorderRadius.circular(30)),
                      child: InkWell(
                        onTap: () {
                          pageProvider.changeExpended();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.white,
                                  child: Image.asset(ImagesModel.pageIconsPng, width: 29, height: 29)),
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
                                child: pageProvider.pageExpended != true
                                    ? const Icon(Icons.arrow_drop_down, color: Colors.white)
                                    : const Icon(Icons.arrow_drop_up, color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    pageProvider.pageExpended == true
                        ? SizedBox(
                            height: 300,
                            child: pageProvider.authorPageLists.isNotEmpty
                                ? ListView.builder(
                                    itemCount: pageProvider.authorPageLists.length,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return PageViewWidget(authorPageModel: pageProvider.authorPageLists[index]);
                                    })
                                : const Center(child: CustomText(title: "You haven't any personal Page")))
                        : const SizedBox.shrink(),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        Helper.toScreen(const CreatePageScreen1());
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
                    LikeInviteFindWidget(
                        icon: ImagesModel.likeIcons,
                        name: "Your liked pages",
                        extraArguments: " ${pageProvider.likedPageLists.length} page${pageProvider.likedPageLists.length == 1 ? "" : "s"}",
                        onTap: () {
                          Helper.toScreen(const NewMyLikedPageScreen());
                        }),
                    const SizedBox(height: 10),
                    LikeInviteFindWidget(
                      icon: ImagesModel.inviteFriendIcons,
                      name: "Invite Pages",
                      extraArguments: " 25 new invites",
                      onTap: () {
                        showMessage(message: 'upcoming');
                        // Helper.toScreen(const NewMyLikedPageScreen());
                      },
                    ),
                    const SizedBox(height: 10),
                    LikeInviteFindWidget(
                      icon: ImagesModel.suggestPageIcons,
                      name: "Suggest Page",
                      onTap: () {
                        Helper.toScreen(const NewSuggestedPageScreen());
                      },
                    ),
                    const SizedBox(height: 10),
                    LikeInviteFindWidget(
                      icon: ImagesModel.findPageIcons,
                      name: "Find pages",
                      onTap: () {
                        Helper.toScreen(const FindPage());
                      },
                    ),
                  ],
                );
        }),
      ),
    );
  }
}
