import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/palette.dart';
import 'package:als_frontend/provider/group_provider.dart';
import 'package:als_frontend/screens/group/public_group_screen.dart';
import 'package:als_frontend/screens/group/user_group_screen.dart';
import 'package:als_frontend/screens/group/widget/custom_group_page_button.dart.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FlagGroupView extends StatelessWidget {
  const FlagGroupView({required this.height, required this.width, Key? key}) : super(key: key);
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Consumer<GroupProvider>(
        builder: (context, provider, child) => SingleChildScrollView(
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
                                    title: 'Personal Group', textStyle: latoStyle700Bold.copyWith(fontSize: 16, color: Palette.primary)),
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
                            ? CustomText(title: "You Haven't any Personal Group", textStyle: latoStyle400Regular.copyWith(fontSize: 16))
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
                                        Helper.toScreen(UserGroupScreen(provider.authorGroupList[index2].id.toString(), index2));

                                      },

                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              radius: 25,
                                              backgroundColor: Palette.notificationColor,
                                              child:
                                              //Todo: this page is not used
                                              CircleAvatar(
                                                radius: 22,
                                                backgroundColor: Palette.primary,
                                                backgroundImage: NetworkImage(provider.authorGroupList[index2].coverPhoto),
                                              ),
                                            ),
                                            const SizedBox(height: 3),
                                            Text(
                                              provider.authorGroupList[index2].name,
                                              style: GoogleFonts.lato(fontSize: height * 0.02, fontWeight: FontWeight.w600),
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
                                    title: 'Suggested Groups', textStyle: latoStyle700Bold.copyWith(fontSize: 16, color: Palette.primary)),
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
                            itemCount: provider.allSuggestGroupList.length,
                            itemBuilder: (context, index) {
                              return CustomPageGroupButton(
                                  onTap: () {
                                    provider.loadingStart();
                                    Helper.toScreen(PublicGroupScreen(provider.allSuggestGroupList[index].id.toString()));

                                  },
                                  goToGroupOrPage: () {},
                                  groupOrPageImage: provider.allSuggestGroupList[index].coverPhoto,
                                  groupOrPageName: provider.allSuggestGroupList[index].name,
                                  groupOrPageLikes: "${provider.allSuggestGroupList[index].totalMember} Members");
                            }),
                      ],
                    ),
                  )),
            ));
  }
}
