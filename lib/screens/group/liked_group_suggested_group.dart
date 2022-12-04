
import 'package:als_frontend/localization/language_constrants.dart';
import 'package:als_frontend/provider/group_provider.dart';
import 'package:als_frontend/screens/group/create_group_screen.dart';
import 'package:als_frontend/screens/group/public_group_screen.dart';
import 'package:als_frontend/screens/group/user_group_screen_copy.dart';
import 'package:als_frontend/screens/group/widget/joined_group.dart';
import 'package:als_frontend/screens/group/widget/my_group.dart';
import 'package:als_frontend/screens/page/public_page_screen.dart';
import 'package:als_frontend/screens/page/user_page_screen.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';

class LikedGroupSuggestedGroup extends StatefulWidget {
  const LikedGroupSuggestedGroup({Key? key}) : super(key: key);

  @override
  State<LikedGroupSuggestedGroup> createState() => _LikedGroupSuggestedGroupState();
}

class _LikedGroupSuggestedGroupState extends State<LikedGroupSuggestedGroup> {
  @override
  void initState() {
    _pageController = PageController();
    super.initState();
    Provider.of<GroupProvider>(context, listen: false).initializeMyGroup();
    Provider.of<GroupProvider>(context, listen: false).initializeSuggestGroup();
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
        child: Consumer<GroupProvider>(builder: (context, groupProvider, child) {
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
                    getTranslated('Groups', context),
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
                      groupProvider.changeMenuValue(0);
                    },
                    child: Container(
                      height: height * 0.035,
                      width: width * 0.24,
                      decoration: groupProvider.menuValue == 0
                          ? BoxDecoration(
                          color: const Color(0xff090D2A),
                          borderRadius: BorderRadius.circular(4))
                          : BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 1)),
                      child: Center(
                          child: Text(
                            getTranslated("My Group", context),
                            style: latoStyle200ExtraLight.copyWith(
                                color: groupProvider.menuValue == 0 ? Colors.white : Colors.black,
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
                      groupProvider.changeMenuValue(1);
                    },
                    child: Container(
                      height: height * 0.035,
                      width: width * 0.24,
                      decoration: groupProvider.menuValue == 1
                          ? BoxDecoration(
                          color: const Color(0xff090D2A),
                          borderRadius: BorderRadius.circular(4))
                          : BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 1)),
                      child: Center(
                          child: Text(
                            getTranslated("Suggestion", context),
                            style: latoStyle200ExtraLight.copyWith(
                                color: groupProvider.menuValue == 0 ? Colors.black : Colors.white,
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

                    groupProvider.changeMenuValue(i);
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
                              Text(getTranslated("My Groups", context), style: latoStyle700Bold),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: InkWell(
                                    onTap: () {
                                      Get.to(const MyGroup());
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
                            child: groupProvider.authorGroupList.isEmpty
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
                                itemCount: 5 > groupProvider.authorGroupList.length
                                    ? groupProvider.authorGroupList.length
                                    : 5,
                                itemBuilder: (BuildContext ctx, index) {
                                  return InkWell(
                                    onTap: () {
                                      Get.to(UserGroupScreen(
                                          groupProvider.authorGroupList[index].id.toString(),
                                          index));
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          radius: 24,
                                          backgroundColor: Colors.black12,
                                          backgroundImage: NetworkImage(
                                              groupProvider.authorGroupList[index].coverPhoto),
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
                                            Text(groupProvider.authorGroupList[index].name,
                                                style: latoStyle700Bold),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                                "${groupProvider.authorGroupList[index].totalMember.toString()} ${getTranslated(" Members", context)}",
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
                              Text(getTranslated("Group you liked", context),
                                  style: latoStyle700Bold),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: InkWell(
                                  onTap: () {
                                    Get.to(const JoinedGroup());
                                  },
                                  child: Text(getTranslated("See all", context),
                                      style:  latoStyle300Light.copyWith(fontSize: 10,color: Colors.black)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.26,
                          child: groupProvider.myGroupList.isEmpty
                              ? Center(
                              child:  Text(
                                getTranslated("you don,t like any group", context),

                                style: latoStyle500Medium,
                              ))
                              : ListView.builder(
                              itemCount: 2 > groupProvider.myGroupList.length
                                  ? groupProvider.myGroupList.length
                                  : 2,
                              // > 2
                              // ? pageProvider.allSuggestPageList.length
                              // : 2,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    Get.to(PublicGroupScreen(
                                        groupProvider.myGroupList[index].id.toString()));
                                  },
                                  child: ListTile(
                                      leading: CircleAvatar(
                                        radius: 24,
                                        backgroundColor: Colors.black12,
                                        backgroundImage: NetworkImage(
                                            groupProvider.myGroupList[index].coverPhoto),
                                      ),
                                      trailing: Container(
                                        height: height * 0.027,
                                        width: width * 0.15,
                                        decoration: BoxDecoration(
                                            color: const Color(0xff090D2A),
                                            borderRadius: BorderRadius.circular(4)),
                                        child: Center(
                                            child: Text(
                                              getTranslated("joined", context),
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
                                          Text(groupProvider.myGroupList[index].name,
                                              style: latoStyle700Bold),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                              "${groupProvider.myGroupList[index].totalMember.toString()} ${getTranslated("Members", context)}",
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
                              Get.to(const CreateGroupScreen());
                            },
                            child: const Icon(CupertinoIcons.plus),
                          ),
                        ),
                      ],
                    ),
                    ListView.builder(
                        itemCount: groupProvider.allSuggestGroupList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Get.to(PublicGroupScreen(
                                  groupProvider.allSuggestGroupList[index].id.toString()));
                            },
                            child: ListTile(
                                leading: CircleAvatar(
                                  radius: 24,
                                  backgroundColor: Colors.black12,
                                  backgroundImage:
                                  NetworkImage(groupProvider.allSuggestGroupList[index].coverPhoto),
                                ),
                                trailing: Container(
                                  height: height * 0.027,
                                  width: width * 0.15,
                                  decoration: BoxDecoration(
                                      color: const Color(0xff090D2A),
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Center(
                                      child: Text(
                                        getTranslated("join", context),
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
                                    Text(groupProvider.allSuggestGroupList[index].name,
                                        style: latoStyle700Bold),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                        "${groupProvider.allSuggestGroupList[index].totalMember.toString()} ${getTranslated("Followers", context)}",
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