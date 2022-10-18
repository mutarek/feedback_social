import 'package:als_frontend/old_code/const/palette.dart';
import 'package:als_frontend/provider/group_provider.dart';
import 'package:als_frontend/screens/group/public_group_screen.dart';
import 'package:als_frontend/screens/group/user_group_screen.dart';
import 'package:als_frontend/screens/group/widget/custom_group_page_button.dart.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MyGroupScreen extends StatelessWidget {
  const MyGroupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<GroupProvider>(context, listen: false).initializeMyGroup();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Group",
          style: TextStyle(color: Palette.primary, fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: -1.2),
        ),
      ),
      body: Consumer<GroupProvider>(
          builder: (context, provider, child) => provider.isLoading
              ? Center(child: CircularProgressIndicator())
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
                                        title: 'Personal Group',
                                        textStyle: latoStyle700Bold.copyWith(fontSize: 16, color: Palette.primary)),
                                    const Icon(Icons.arrow_forward_ios_rounded, color: Palette.primary)
                                  ],
                                ),
                                // Container(height: 3,color: Colors.grey.withOpacity(.1),margin: EdgeInsets.only(bottom: 10)),
                                Container(
                                  height: 3,
                                  margin: const EdgeInsets.only(bottom: 10),
                                ),
                              ],
                            ),
                            (provider.authorGroupList.isEmpty)
                                ? CustomText(
                                    title: 'You Haven\'t any Personal Group', textStyle: latoStyle400Regular.copyWith(fontSize: 16))
                                : Container(
                                    height: 90,
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
                                            Get.to(UserGroupScreen(provider.authorGroupList[index2].id.toString()));
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
                                                    backgroundImage: NetworkImage(provider.authorGroupList[index2].coverPhoto),
                                                  ),
                                                ),
                                                const SizedBox(height: 3),
                                                Text(
                                                  provider.authorGroupList[index2].name,
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
                                        title: 'Other Groups', textStyle: latoStyle700Bold.copyWith(fontSize: 16, color: Palette.primary)),
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
                                itemCount: provider.myGroupList.length,
                                itemBuilder: (context, index) {
                                  return CustomPageGroupButton(
                                      onTap: () {
                                        provider.loadingStart();
                                        Get.to(PublicGroupScreen(provider.myGroupList[index].id.toString(),
                                            index: index, isFromMYGroup: true));
                                      },
                                      goToGroupOrPage: () {},
                                      groupOrPageImage: provider.myGroupList[index].coverPhoto,
                                      groupOrPageName: provider.myGroupList[index].name,
                                      groupOrPageLikes: "${provider.myGroupList[index].totalMember} Members");
                                }),
                          ],
                        ),
                      )),
                )),
    );
  }
}
