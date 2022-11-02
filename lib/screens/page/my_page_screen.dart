import 'package:als_frontend/old_code/const/palette.dart';
import 'package:als_frontend/provider/page_provider.dart';
import 'package:als_frontend/screens/group/widget/custom_group_page_button.dart.dart';
import 'package:als_frontend/screens/page/public_page_screen.dart';
import 'package:als_frontend/screens/page/user_page_screen.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
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
    Provider.of<PageProvider>(context, listen: false).initializeAuthorPageLists(isFromMyPage: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Page",
          style: TextStyle(color: Palette.primary, fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: -1.2),
        ),
      ),
      body: Consumer<PageProvider>(
          builder: (context, provider, child) => provider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                        title: 'Personal Page', textStyle: latoStyle700Bold.copyWith(fontSize: 16, color: Palette.primary)),
                                    const Icon(Icons.arrow_forward_ios_rounded, color: Palette.primary)
                                  ],
                                ),
                                Container(height: 3, margin: const EdgeInsets.only(bottom: 10)),
                              ],
                            ),
                            (provider.authorPageLists.isEmpty)
                                ? CustomText(title: 'You Haven\'t any Personal Page', textStyle: latoStyle400Regular.copyWith(fontSize: 16))
                                : Container(
                                    height: 90,
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
                                            Get.to(UserPageScreen(provider.authorPageLists[index2].id.toString(), index2));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Column(
                                              children: [
                                                CircleAvatar(
                                                  radius: 25,
                                                  backgroundColor: Palette.notificationColor,
                                                  child: CircleAvatar(
                                                    radius: 22,
                                                    backgroundColor: Palette.primary,
                                                    backgroundImage: NetworkImage(provider.authorPageLists[index2].coverPhoto),
                                                  ),
                                                ),
                                                const SizedBox(height: 3),
                                                Text(
                                                  provider.authorPageLists[index2].name,
                                                  style: GoogleFonts.lato(fontSize: 14, fontWeight: FontWeight.w600),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                            Container(height: 2, color: Colors.grey.withOpacity(.1), margin: const EdgeInsets.only(bottom: 10, top: 10)),
                            Column(
                              children: [
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                        title: 'Other Pages', textStyle: latoStyle700Bold.copyWith(fontSize: 16, color: Palette.primary)),
                                    const Icon(Icons.arrow_forward_ios_rounded, color: Palette.primary)
                                  ],
                                ),
                                // Container(height: 3,color: Colors.grey.withOpacity(.1),margin: EdgeInsets.only(bottom: 10)),
                                Container(height: 3, margin: const EdgeInsets.only(bottom: 15)),
                              ],
                            ),
                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: provider.likedPageLists.length,
                                itemBuilder: (context, index) {
                                  return CustomPageGroupButton(
                                      onTap: () {
                                        provider.loadingStart();
                                        Get.to(PublicPageScreen(provider.likedPageLists[index].id.toString(), index));
                                      },
                                      goToGroupOrPage: () {},
                                      groupOrPageImage: provider.likedPageLists[index].avatar,
                                      groupOrPageName: provider.likedPageLists[index].name,
                                      groupOrPageLikes: "${provider.likedPageLists[index].followers} Members");
                                }),
                          ],
                        ),
                      )),
                )),
    );
  }
}
