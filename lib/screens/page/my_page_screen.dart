import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/palette.dart';
import 'package:als_frontend/provider/other_provider.dart';
import 'package:als_frontend/provider/page_provider.dart';
import 'package:als_frontend/screens/group/widget/custom_group_page_button.dart.dart';
import 'package:als_frontend/screens/page/create_page_screen.dart';
import 'package:als_frontend/screens/page/public_page_screen.dart';
import 'package:als_frontend/screens/page/user_page_screen.dart';
import 'package:als_frontend/screens/profile/shimmer_effect/friend_req_shimmer_widget.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:als_frontend/widgets/network_image.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({Key? key}) : super(key: key);

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
    Provider.of<PageProvider>(context, listen: false).initializeAuthorPageLists();
  }

  PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Consumer<PageProvider>(
          builder: (context, pageProvider, child) => CustomText(
            title: pageProvider.menuValue == 0 ? LocaleKeys.pages.tr() : LocaleKeys.suggested_Page.tr(),
            textStyle: latoStyle700Bold.copyWith(color: Palette.primary, fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: -1.2),
          ),
        ),
      ),
      floatingActionButton: Consumer<PageProvider>(
        builder: (context, pageProvider, child) => pageProvider.menuValue == 0
            ? FloatingActionButton(
                onPressed: () {
                  Provider.of<OtherProvider>(context, listen: false).clearImage();
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CreatePageScreen()));
                },
                backgroundColor: Colors.blue,
                child: const Icon(Icons.add, color: Colors.white),
              )
            : const SizedBox.shrink(),
      ),
      body: Consumer<PageProvider>(
          builder: (context, provider, child) => provider.isLoading
              ? const Center(child: FriendReqShimmerWidget())
              : Column(
                  children: [
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 50.0,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Color(0XFFE0E0E0),
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            expanded(context, provider, LocaleKeys.my_Page.tr(), 0),
                            expanded(context, provider, LocaleKeys.other_Page.tr(), 1),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: PageView(
                        controller: _pageController,
                        physics: const ClampingScrollPhysics(),
                        onPageChanged: (int i) {
                          FocusScope.of(context).requestFocus(FocusNode());

                          provider.changeMenuValue(i);
                        },
                        children: <Widget>[
                          myPageView(provider),
                          mySuggestedView(provider),
                        ],
                      ),
                    ),
                  ],
                )),
    );
  }

  Widget myPageView(PageProvider provider) {
    return ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 10),
                      titleMenuWidget(LocaleKeys.personal_Page.tr()),
                      Container(margin: const EdgeInsets.only(bottom: 10)),
                    ],
                  ),
                  (provider.authorPageLists.isEmpty)
                      ? CustomText(
                          title: LocaleKeys.you_HaveNot_any_Personal_Page.tr(),
                          textStyle: latoStyle400Regular.copyWith(fontSize: 16))
                      : Container(
                          height: 100,
                          alignment: Alignment.centerLeft,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: provider.authorPageLists.length,
                            itemBuilder: (context, index2) {
                              return InkWell(
                                onTap: () {
                                  provider.loadingStart();
                                  Helper.toScreen(UserPageScreen(provider.authorPageLists[index2].id.toString(), index2));
                                },
                                child: Container(
                                  width: 70,
                                  padding: const EdgeInsets.all(6.0),
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundColor: Palette.notificationColor,
                                        child: circularImage(provider.authorPageLists[index2].coverPhoto,40,40),
                                      ),
                                      const SizedBox(height: 3),
                                      CustomText(
                                        title: provider.authorPageLists[index2].name,
                                        color: Colors.black,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                  Column(
                    children: [
                      const SizedBox(height: 10),
                      titleMenuWidget(LocaleKeys.liked_page.tr()),
                      const SizedBox(height: 15),
                    ],
                  ),
                  provider.likedPageLists.isNotEmpty
                      ? ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: provider.likedPageLists.length,
                          itemBuilder: (context, index) {
                            return CustomPageGroupButton(
                                onTap: () {
                                  provider.loadingStart();
                                  Helper.toScreen(PublicPageScreen(provider.likedPageLists[index].id.toString(),
                                      isFromMyPageScreen: true, index: index));
                                },
                                goToGroupOrPage: () {},
                                groupOrPageImage: provider.likedPageLists[index].avatar,
                                groupOrPageName: provider.likedPageLists[index].name,
                                groupOrPageLikes: "${provider.likedPageLists[index].followers} ${LocaleKeys.likes.tr()} ");
                          })
                      : CustomText(
                          title: LocaleKeys.no_History_found.tr(), textStyle: latoStyle400Regular.copyWith(fontSize: 16)),
                ],
              ),
            )),
      ),
    );
  }

  Widget mySuggestedView(PageProvider provider) {
    return ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 15),
              itemCount: provider.allSuggestPageList.length,
              itemBuilder: (context, index) {
                return CustomPageGroupButton(
                    onTap: () {
                      provider.loadingStart();
                      Helper.toScreen(PublicPageScreen(provider.allSuggestPageList[index].id.toString(),
                          isFromMyPageScreen: true, index: index, isFromSuggestedPage: true));
                    },
                    goToGroupOrPage: () {},
                    groupOrPageImage: provider.allSuggestPageList[index].coverPhoto,
                    groupOrPageName: provider.allSuggestPageList[index].name,
                    groupOrPageLikes: "${provider.allSuggestPageList[index].followers} ${LocaleKeys.likes.tr()}");
              }),
    );
  }

  Widget titleMenuWidget(String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(.1), blurRadius: 10.0, spreadRadius: 3.0, offset: const Offset(0.0, 0.0))],
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(title: value, textStyle: latoStyle700Bold.copyWith(fontSize: 16, color: Palette.primary)),
          const Icon(Icons.arrow_forward_ios_rounded, color: Palette.primary)
        ],
      ),
    );
  }

  Widget expanded(BuildContext context, PageProvider groupProvider, String title, int value) {
    return Expanded(
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        onTap: () {
          _pageController.animateToPage(value, duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
          groupProvider.changeMenuValue(value);
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          decoration: (groupProvider.menuValue == value)
              ? const BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.all(Radius.circular(25)))
              : null,
          child: CustomText(title: title, color: (groupProvider.menuValue == value) ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
