import 'package:als_frontend/provider/page_provider.dart';
import 'package:als_frontend/screens/page/create_page_screen.dart';
import 'package:als_frontend/screens/page/public_page_screen.dart';
import 'package:als_frontend/screens/page/user_page_screen.dart';
import 'package:als_frontend/screens/page/widget/my_page.dart';
import 'package:als_frontend/screens/page/widget/your_liked_page.dart';
import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LikedPageSuggestedPage extends StatefulWidget {
  const LikedPageSuggestedPage({Key? key}) : super(key: key);

  @override
  State<LikedPageSuggestedPage> createState() => _LikedPageSuggestedPageState();
}

class _LikedPageSuggestedPageState extends State<LikedPageSuggestedPage> {
  @override
  void initState() {
    _pageController = PageController();
    super.initState();
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
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: height * 0.06, left: 10, right: 10),
        child: Consumer<PageProvider>(builder: (context, pageProvider, child) {
          return Column(
            children: [
              //ToDo: appbar started
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Helper.back();
                      },
                      icon: const Icon(Icons.arrow_back_ios)),
                  SizedBox(
                    width: width * 0.26,
                  ),
                  Text(
                    LocaleKeys.pages.tr(),
                    style: latoStyle500Medium,
                  )
                ],
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      _pageController.animateToPage(0,
                          duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
                      pageProvider.changeMenuValue(0);
                    },
                    child: Container(
                      height: height * 0.035,
                      width: width * 0.24,
                      decoration: pageProvider.menuValue == 0
                          ? BoxDecoration(
                              color: const Color(0xff090D2A),
                              borderRadius: BorderRadius.circular(4))
                          : BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.white,
                              border: Border.all(color: Colors.black, width: 1)),
                      child: Center(
                          child: Text(
                            LocaleKeys.my_Page.tr(),
                        style: latoStyle200ExtraLight.copyWith(
                            color: pageProvider.menuValue == 0 ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.03,
                  ),
                  InkWell(
                    onTap: () {
                      _pageController.animateToPage(1,
                          duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
                      pageProvider.changeMenuValue(1);
                    },
                    child: Container(
                      height: height * 0.035,
                      width: width * 0.24,
                      decoration: pageProvider.menuValue == 1
                          ? BoxDecoration(
                              color: const Color(0xff090D2A),
                              borderRadius: BorderRadius.circular(4))
                          : BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.white,
                              border: Border.all(color: Colors.black, width: 1)),
                      child: Center(
                          child: Text(LocaleKeys.suggestion.tr(),
                        style: latoStyle200ExtraLight.copyWith(
                            color: pageProvider.menuValue == 0 ? Colors.black : Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  )
                ],
              ),
              Expanded(
                flex: 2,
                child: PageView(
                  controller: _pageController,
                  physics: const ClampingScrollPhysics(),
                  onPageChanged: (int i) {
                    FocusScope.of(context).requestFocus(FocusNode());

                    pageProvider.changeMenuValue(i);
                  },
                  children: <Widget>[
                    Column(
                      children: [
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            children: [
                              Text(LocaleKeys.my_Page.tr(), style: latoStyle700Bold),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: InkWell(
                                    onTap: () {
                                      Helper.toScreen(const MyPage());
                                    },
                                    child: Text("See all",
                                        style: latoStyle300Light.copyWith(fontSize: 10,color: Colors.black))),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12, right: 12),
                          child: SizedBox(
                            height: height * 0.26,
                            child: pageProvider.authorPageLists.isEmpty
                                ? Center(
                                    child: Text(
                                      LocaleKeys.you_HaveNot_any_Personal_Page.tr(),
                                    style: latoStyle700Bold,
                                  ))
                                : GridView.builder(
                                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 150,
                                      childAspectRatio: 2.7,
                                      crossAxisSpacing: 10,
                                    ),
                                    itemCount: 5 > pageProvider.authorPageLists.length
                                        ? pageProvider.authorPageLists.length
                                        : 5,
                                    // > 5
                                    // ? pageProvider.authorPageLists.length
                                    // : 5,
                                    itemBuilder: (BuildContext ctx, index) {
                                      return InkWell(
                                        onTap: () {
                                          Helper.toScreen(UserPageScreen(pageProvider.authorPageLists[index].id.toString(),
                                              index));
                                        },
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CircleAvatar(
                                              radius: 24,
                                              backgroundColor: Colors.black12,
                                              backgroundImage:  CachedNetworkImageProvider(pageProvider.authorPageLists[index].avatar),

                                            ),
                                            SizedBox(
                                              width: width * 0.03,
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: height * 0.01,
                                                ),
                                                Text(pageProvider.authorPageLists[index].name,
                                                    style: latoStyle700Bold),
                                                const SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                    "${pageProvider.authorPageLists[index].followers.toString()} ${LocaleKeys.followers.tr()}",
                                                    style: latoStyle400Regular.copyWith(fontSize: 10,color: Colors.grey)),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    }),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            children: [
                              Text(LocaleKeys.page_you_liked.tr(),
                                  style: latoStyle700Bold),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: InkWell(
                                  onTap: () {
                                    Helper.toScreen(const YourLikedPage());
                                  },
                                  child: Text(LocaleKeys.see_all.tr(),
                                      style:  latoStyle300Light.copyWith(fontSize: 10,color: Colors.black)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.26,
                          child: pageProvider.likedPageLists.isEmpty
                              ? Center(
                                  child:  Text(
                                    LocaleKeys.you_doNot_like_any_page.tr(),

                                  style: latoStyle500Medium,
                                ))
                              : ListView.builder(
                                  itemCount: 2 > pageProvider.likedPageLists.length
                                      ? pageProvider.likedPageLists.length
                                      : 2,
                                  // > 2
                                  // ? pageProvider.allSuggestPageList.length
                                  // : 2,
                                  itemBuilder: (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: () {
                                        Helper.toScreen(PublicPageScreen(pageProvider.likedPageLists[index].id.toString()));
                                      },
                                      child: ListTile(
                                          leading: CircleAvatar(
                                            radius: 24,
                                            backgroundColor: Colors.black12,
                                            backgroundImage: CachedNetworkImageProvider(pageProvider.likedPageLists[index].avatar),
                                          ),
                                          trailing: Container(
                                            height: height * 0.027,
                                            width: width * 0.15,
                                            decoration: BoxDecoration(
                                                color: const Color(0xff090D2A),
                                                borderRadius: BorderRadius.circular(4)),
                                            child: Center(
                                                child: Text(
                                                  LocaleKeys.follow.tr(),
                                              style: latoStyle600SemiBold.copyWith(
                                                  color: Colors.white, fontSize: 10),
                                            )),
                                          ),
                                          title: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: height * 0.01,
                                              ),
                                              Text(pageProvider.likedPageLists[index].name,
                                                  style: latoStyle700Bold),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                  "${pageProvider.likedPageLists[index].followers.toString()} ${LocaleKeys.followers.tr()}",
                                                  style: latoStyle400Regular.copyWith(fontSize: 10,color: Colors.grey)),
                                            ],
                                          )),
                                    );
                                  }),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 250, top: 50),
                          child: FloatingActionButton(
                            onPressed: () {
                              Helper.toScreen(const CreatePageScreen());
                            },
                            child: const Icon(CupertinoIcons.plus),
                          ),
                        ),
                      ],
                    ),
                    ListView.builder(
                        itemCount: pageProvider.allSuggestPageList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Helper.toScreen(PublicPageScreen(pageProvider.allSuggestPageList[index].id.toString()));
                            },
                            child: ListTile(
                                leading: CircleAvatar(
                                  radius: 24,
                                  backgroundColor: Colors.black12,
                                  backgroundImage:
                                  CachedNetworkImageProvider(pageProvider.allSuggestPageList[index].avatar),
                                ),
                                trailing: Container(
                                  height: height * 0.027,
                                  width: width * 0.15,
                                  decoration: BoxDecoration(
                                      color: const Color(0xff090D2A),
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Center(
                                      child: Text(
                                        LocaleKeys.follow.tr(),
                                    style: latoStyle600SemiBold.copyWith(
                                        color: Colors.white, fontSize: 10),
                                  )),
                                ),
                                title: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    Text(pageProvider.allSuggestPageList[index].name,
                                        style: latoStyle700Bold),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                        "${pageProvider.allSuggestPageList[index].followers.toString()} ${LocaleKeys.followers.tr()}",
                                        style: latoStyle100Thin.copyWith(fontSize: 10)),
                                  ],
                                )),
                          );
                        }),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
