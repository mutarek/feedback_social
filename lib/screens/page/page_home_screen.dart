import 'package:als_frontend/provider/page_provider.dart';
import 'package:als_frontend/screens/page/find_page_screen.dart';
import 'package:als_frontend/screens/page/invited_page.dart';
import 'package:als_frontend/screens/page/my_liked_page_screen.dart';
import 'package:als_frontend/screens/page/page_details_screen.dart';
import 'package:als_frontend/screens/page/suggested_page_screen.dart';
import 'package:als_frontend/screens/page/shimmer_effect/page_home_screen_shimmer_effect.dart';
import 'package:als_frontend/screens/page/widget/like_invite_find.dart';
import 'package:als_frontend/screens/page/widget/page_app_bar.dart';
import 'package:als_frontend/screens/page/widget/page_view_widget.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/image.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'create_page1.dart';

class PageHomeScreen extends StatefulWidget {
  const PageHomeScreen({Key? key}) : super(key: key);

  @override
  State<PageHomeScreen> createState() => _PageHomeScreenState();
}

class _PageHomeScreenState extends State<PageHomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<PageProvider>(context, listen: false).initializeAuthorPageLists(isFirstTime: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PageAppBar(title: 'Feedback Pages', isOpenPageSettings: true, isBackButtonExist: false),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Consumer<PageProvider>(builder: (context, pageProvider, child) {
          return pageProvider.isLoading
              ? const PageHomeScreenShimmer()
              : ListView(
                  children: [
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(color: const Color(0xffF0F2F5), borderRadius: BorderRadius.circular(30)),
                      child: InkWell(
                        onTap: () {
                          pageProvider.changeExpendedYourPages();
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
                                child: pageProvider.expandedYoursPages != true
                                    ? const Icon(Icons.arrow_drop_down, color: Colors.white)
                                    : const Icon(Icons.arrow_drop_up, color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    pageProvider.expandedYoursPages == true
                        ? SizedBox(
                            height: 300,
                            child: pageProvider.authorPageLists.isNotEmpty
                                ? Column(
                                    children: [
                                      Expanded(
                                        child: ListView.builder(
                                            itemCount: pageProvider.authorPageLists.length,
                                            physics: const BouncingScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              var data = pageProvider.authorPageLists[index];
                                              return PageViewWidget(
                                                  authorPageModel: data,
                                                  onTap: () {
                                                    Helper.toScreen(PageDetailsScreen(pageProvider.authorPageLists[index].id.toString(),
                                                        index: index));
                                                  });
                                            }),
                                      ),
                                      SizedBox(height: pageProvider.hasNextData || pageProvider.isBottomLoading ? 5 : 0),
                                      pageProvider.isBottomLoading
                                          ? const CircularProgressIndicator()
                                          : pageProvider.hasNextData
                                              ? InkWell(
                                                  onTap: () {
                                                    pageProvider.updateAuthorPageNo();
                                                  },
                                                  child: Container(
                                                    height: 30,
                                                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(color: colorText), borderRadius: BorderRadius.circular(22)),
                                                    child: Text('Load more Pages', style: robotoStyle500Medium.copyWith(color: colorText)),
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                    ],
                                  )
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
                        extraArguments: "${pageProvider.totalLikedPage} page${pageProvider.totalLikedPage <= 1 ? "" : "s"}",
                        onTap: () {
                          Helper.toScreen(const MyLikedPageScreen());
                        }),
                    const SizedBox(height: 10),
                    LikeInviteFindWidget(
                      icon: ImagesModel.inviteFriendIcons,
                      name: "Invite Pages",
                      extraArguments: "${pageProvider.totalInvitedPage} new invite${pageProvider.totalInvitedPage <= 1 ? "" : "s"}",
                      onTap: () {
                        Helper.toScreen(const InvitedPage());
                      },
                    ),
                    const SizedBox(height: 10),
                    LikeInviteFindWidget(
                      icon: ImagesModel.suggestPageIcons,
                      name: "Suggest Page",
                      onTap: () {
                        Helper.toScreen(const SuggestedPageScreen());
                      },
                    ),
                    const SizedBox(height: 10),
                    LikeInviteFindWidget(
                      icon: ImagesModel.findPageIcons,
                      name: "Find pages",
                      onTap: () {
                        Helper.toScreen(const FindPageScreen());
                      },
                    ),
                  ],
                );
        }),
      ),
    );
  }
}
