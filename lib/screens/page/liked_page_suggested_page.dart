import 'package:als_frontend/localization/language_constrants.dart';
import 'package:als_frontend/provider/page_provider.dart';
import 'package:als_frontend/screens/page/create_page_screen.dart';
import 'package:als_frontend/screens/page/public_page_screen.dart';
import 'package:als_frontend/screens/page/user_page_screen.dart';
import 'package:als_frontend/screens/page/widget/my_page.dart';
import 'package:als_frontend/screens/page/widget/your_liked_page.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
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
                        Get.back();
                      },
                      icon: const Icon(Icons.arrow_back_ios)),
                  SizedBox(
                    width: width * 0.26,
                  ),
                  Text(
                    getTranslated('Pages', context),
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
                      _pageController.animateToPage(0, duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
                      pageProvider.changeMenuValue(0);
                    },
                    child: Container(
                      height: height * 0.035,
                      width: width * 0.24,
                      decoration: pageProvider.menuValue == 0
                          ? BoxDecoration(color: const Color(0xff090D2A), borderRadius: BorderRadius.circular(4))
                          : BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.white,
                              border: Border.all(color: Colors.black, width: 1)),
                      child: Center(
                          child: Text(
                        getTranslated("My page", context),
                        style: latoStyle200ExtraLight.copyWith(
                            color: pageProvider.menuValue == 0 ? Colors.white : Colors.black, fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.03,
                  ),
                  InkWell(
                    onTap: () {
                      _pageController.animateToPage(1, duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
                      pageProvider.changeMenuValue(1);
                    },
                    child: Container(
                      height: height * 0.035,
                      width: width * 0.24,
                      decoration: pageProvider.menuValue == 1
                          ? BoxDecoration(color: const Color(0xff090D2A), borderRadius: BorderRadius.circular(4))
                          : BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.white,
                              border: Border.all(color: Colors.black, width: 1)),
                      child: Center(
                          child: Text(
                        getTranslated("Suggestion", context),
                        style: latoStyle200ExtraLight.copyWith(
                            color: pageProvider.menuValue == 0 ? Colors.black : Colors.white, fontWeight: FontWeight.bold),
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
                              Text(getTranslated("My pages", context), style: latoStyle700Bold),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: InkWell(
                                    onTap: () {
                                      Get.to(const MyPage());
                                    },
                                    child: Text("See all", style: latoStyle100Thin.copyWith(fontSize: 10))),
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
                                    getTranslated("Sorry you don't have any page", context),
                                    style: latoStyle700Bold,
                                  ))
                                : GridView.builder(
                                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 150,
                                      childAspectRatio: 2.7,
                                      crossAxisSpacing: 10,
                                    ),
                                    itemCount: pageProvider.authorPageLists.length < 5 ? pageProvider.authorPageLists.length : 5,
                                    itemBuilder: (BuildContext ctx, index) {
                                      return InkWell(
                                        onTap: () {
                                          Get.to(UserPageScreen(pageProvider.authorPageLists[index].id.toString(), index));
                                        },
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CircleAvatar(
                                              radius: 24,
                                              backgroundColor: Colors.black12,
                                              backgroundImage: NetworkImage(pageProvider.authorPageLists[index].avatar),
                                            ),
                                            SizedBox(
                                              width: width * 0.01,
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: height * 0.01,
                                                ),
                                                Text(pageProvider.authorPageLists[index].name, style: latoStyle700Bold),
                                                const SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                    "${pageProvider.authorPageLists[index].followers.toString()} ${getTranslated("Followers", context)}",
                                                    style: latoStyle100Thin.copyWith(fontSize: 10)),
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
                              Text(getTranslated("Page you liked", context), style: latoStyle700Bold),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: InkWell(
                                  onTap: () {
                                    Get.to(const YourLikedPage());
                                  },
                                  child: Text(getTranslated("See all", context), style: latoStyle100Thin.copyWith(fontSize: 10)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.26,
                          child: pageProvider.likedPageLists.isEmpty
                              ? Center(
                                  child: Text(
                                  getTranslated("you don,t like any page", context),
                                  style: latoStyle500Medium,
                                ))
                              : ListView.builder(
                                  itemCount: 2 > pageProvider.likedPageLists.length ? pageProvider.likedPageLists.length : 2,
                                  // > 2
                                  // ? pageProvider.allSuggestPageList.length
                                  // : 2,
                                  itemBuilder: (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: () {
                                        Get.to(PublicPageScreen(pageProvider.likedPageLists[index].id.toString()));
                                      },
                                      child: ListTile(
                                          leading: CircleAvatar(
                                            radius: 24,
                                            backgroundColor: Colors.black12,
                                            backgroundImage: NetworkImage(pageProvider.likedPageLists[index].avatar),
                                          ),
                                          trailing: Container(
                                            height: height * 0.027,
                                            width: width * 0.15,
                                            decoration:
                                                BoxDecoration(color: const Color(0xff090D2A), borderRadius: BorderRadius.circular(4)),
                                            child: Center(
                                                child: Text(
                                              getTranslated("Follow", context),
                                              style: latoStyle600SemiBold.copyWith(color: Colors.white, fontSize: 10),
                                            )),
                                          ),
                                          title: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: height * 0.01,
                                              ),
                                              Text(pageProvider.likedPageLists[index].name, style: latoStyle700Bold),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                  "${pageProvider.likedPageLists[index].followers.toString()} ${getTranslated("Followers", context)}",
                                                  style: latoStyle100Thin.copyWith(fontSize: 10)),
                                            ],
                                          )),
                                    );
                                  }),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 250, top: 50),
                          child: FloatingActionButton(
                            onPressed: () {
                              Get.to(const CreatePageScreen());
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
                              Get.to(PublicPageScreen(pageProvider.allSuggestPageList[index].id.toString()));
                            },
                            child: ListTile(
                                leading: CircleAvatar(
                                  radius: 24,
                                  backgroundColor: Colors.black12,
                                  backgroundImage: NetworkImage(pageProvider.allSuggestPageList[index].avatar),
                                ),
                                trailing: Container(
                                  height: height * 0.027,
                                  width: width * 0.15,
                                  decoration: BoxDecoration(color: const Color(0xff090D2A), borderRadius: BorderRadius.circular(4)),
                                  child: Center(
                                      child: Text(
                                    getTranslated("Follow", context),
                                    style: latoStyle600SemiBold.copyWith(color: Colors.white, fontSize: 10),
                                  )),
                                ),
                                title: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    Text(pageProvider.allSuggestPageList[index].name, style: latoStyle700Bold),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                        "${pageProvider.allSuggestPageList[index].followers.toString()} ${getTranslated("Followers", context)}",
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
