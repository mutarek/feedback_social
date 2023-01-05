import 'package:als_frontend/provider/group_provider.dart';
import 'package:als_frontend/provider/other_provider.dart';
import 'package:als_frontend/screens/group/create_group_screen.dart';
import 'package:als_frontend/screens/group/public_group_screen.dart';
import 'package:als_frontend/screens/group/user_group_screen.dart';
import 'package:als_frontend/screens/group/widget/custom_group_page_button.dart.dart';
import 'package:als_frontend/screens/profile/shimmer_effect/friend_req_shimmer_widget.dart';
import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/palette.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:als_frontend/widgets/network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyGroupScreen extends StatefulWidget {
  const MyGroupScreen({Key? key}) : super(key: key);

  @override
  State<MyGroupScreen> createState() => _MyGroupScreenState();
}

class _MyGroupScreenState extends State<MyGroupScreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
    Provider.of<GroupProvider>(context, listen: false).initializeMyGroup();
    Provider.of<GroupProvider>(context, listen: false).initializeSuggestGroup();
  }

  PageController _pageController = PageController();

  @override
  void dispose() {
    if(mounted){
      _pageController.dispose();
    }
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
        title: Consumer<GroupProvider>(
          builder: (context, groupProvider, child) => CustomText(
            title: groupProvider.menuValue == 0 ? "Group" : "Suggested Groups",
            textStyle: latoStyle700Bold.copyWith(color: Palette.primary, fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: -1.2),
          ),
        ),
      ),
      floatingActionButton: Consumer<GroupProvider>(
        builder: (context, groupProvider, child) => groupProvider.menuValue == 0
            ? FloatingActionButton(
                onPressed: () {
                  Provider.of<OtherProvider>(context, listen: false).clearImage();
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CreateGroupScreen()));
                },
                backgroundColor: Colors.blue,
                child: const Icon(Icons.add, color: Colors.white),
              )
            : const SizedBox.shrink(),
      ),
      body: Consumer<GroupProvider>(
          builder: (context, provider, child) => provider.isLoading || provider.isBottomLoading
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
                            expanded(context, provider, 'My Group', 0),
                            expanded(context, provider, 'Other Group', 1),
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
                        children: <Widget>[myGroupView(provider), mySuggestedView(provider)],
                      ),
                    ),
                  ],
                )),
    );
  }

  Widget myGroupView(GroupProvider provider) {
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
                      titleMenuWidget(LocaleKeys.personal_Groups.tr()),
                      Container(margin: const EdgeInsets.only(bottom: 10)),
                    ],
                  ),
                  (provider.isLoading)
                      ? CustomText(title: "You Haven't any Personal Group", textStyle: latoStyle400Regular.copyWith(fontSize: 16))
                      : Container(
                          height: 100,
                          alignment: Alignment.centerLeft,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            //physics: const NeverScrollableScrollPhysics(),
                            itemCount: provider.authorGroupList.length,
                            itemBuilder: (context, index2) {
                              return InkWell(
                                onTap: () {
                                  provider.loadingStart();
                                  Helper.toScreen(UserGroupScreen(provider.authorGroupList[index2].id.toString(), index2));
                                },
                                child: Container(
                                  width: 70,
                                  padding: const EdgeInsets.all(6.0),
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundColor: Palette.notificationColor,
                                        child: CircleAvatar(
                                          radius: 24,
                                          backgroundColor: Palette.primary,
                                          child: circularImage(provider.authorGroupList[index2].coverPhoto,40,40),

                                        ),
                                      ),
                                      const SizedBox(height: 3),
                                      CustomText(
                                        title: provider.authorGroupList[index2].name,
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
                      titleMenuWidget(LocaleKeys.joined_Group.tr()),
                      const SizedBox(height: 15),
                    ],
                  ),
                  provider.myGroupList.isNotEmpty
                      ? ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: provider.myGroupList.length,
                          itemBuilder: (context, index) {
                            return CustomPageGroupButton(
                                onTap: () {
                                  provider.loadingStart();
                                  Helper.toScreen(
                                      PublicGroupScreen(provider.myGroupList[index].id.toString(), index: index, isFromMYGroup: true));
                                },
                                goToGroupOrPage: () {},
                                groupOrPageImage: provider.myGroupList[index].coverPhoto,
                                groupOrPageName: provider.myGroupList[index].name,
                                groupOrPageLikes: "${provider.myGroupList[index].totalMember} Members");
                          })
                      : CustomText(title: LocaleKeys.no_Data_Found.tr(), textStyle: latoStyle400Regular.copyWith(fontSize: 16)),
                ],
              ),
            )),
      ),
    );
  }

  Widget mySuggestedView(GroupProvider provider) {
    return ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: provider.isLoadingSuggestedGroup
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 15),
              itemCount: provider.allSuggestGroupList.length,
              itemBuilder: (context, index) {
                return CustomPageGroupButton(
                    onTap: () {
                      provider.loadingStart();
                      Helper.toScreen(
                          PublicGroupScreen(provider.allSuggestGroupList[index].id.toString(), index: index, isFromMYGroup: true));
                    },
                    goToGroupOrPage: () {},
                    groupOrPageImage: provider.allSuggestGroupList[index].coverPhoto,
                    groupOrPageName: provider.allSuggestGroupList[index].name,
                    groupOrPageLikes: "${provider.allSuggestGroupList[index].totalMember} Members");
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

  Widget expanded(BuildContext context, GroupProvider groupProvider, String title, int value) {
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
