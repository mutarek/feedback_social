import 'package:als_frontend/provider/page_provider.dart';
import 'package:als_frontend/screens/group/widget/custom_group_page_button.dart.dart';
import 'package:als_frontend/screens/page/public_page_screen.dart';
import 'package:als_frontend/screens/page/user_page_screen.dart';
import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/palette.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FlagPageView extends StatelessWidget {
  const FlagPageView({required this.height, required this.width, Key? key}) : super(key: key);
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Consumer<PageProvider>(
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
                                    title: LocaleKeys.personal_Page.tr(), textStyle: latoStyle700Bold.copyWith(fontSize: 16, color: Palette.primary)),
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
                        (provider.authorPageLists.isEmpty)
                            ? CustomText(title: LocaleKeys.you_HaveNot_any_Personal_Page.tr(), textStyle: latoStyle400Regular.copyWith(fontSize: 16))
                            : Container(
                                height: 90,
                                alignment: Alignment.centerLeft,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  //physics: const NeverScrollableScrollPhysics(),
                                  itemCount: provider.authorPageLists.length,
                                  itemBuilder: (context, index2) {
                                    return InkWell(
                                      onTap: () {
                                        provider.loadingStart();
                                        Helper.toScreen(UserPageScreen(provider.authorPageLists[index2].id.toString(), index2));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              radius: 25,
                                              backgroundColor: Palette.notificationColor,
                                              child:
                                              CircleAvatar(
                                                radius: 22,
                                                backgroundColor: Palette.primary,
                                                backgroundImage: NetworkImage(provider.authorPageLists[index2].coverPhoto),
                                              ),
                                            ),
                                            const SizedBox(height: 3),
                                            Text(
                                              provider.authorPageLists[index2].name,
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
                                    title: LocaleKeys.suggested_Page.tr(), textStyle: latoStyle700Bold.copyWith(fontSize: 16, color: Palette.primary)),
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
                            itemCount: provider.allSuggestPageList.length,
                            itemBuilder: (context, index) {
                              return CustomPageGroupButton(
                                  onTap: () {
                                    provider.loadingStart();
                                    Helper.toScreen(PublicPageScreen(provider.authorPageLists[index].id.toString()));
                                  },
                                  goToGroupOrPage: () {},
                                  groupOrPageImage: provider.allSuggestPageList[index].coverPhoto,
                                  groupOrPageName: provider.allSuggestPageList[index].name,
                                  groupOrPageLikes: "${provider.allSuggestPageList[index].followers} ${LocaleKeys.likes.tr()} ");
                            }),
                      ],
                    ),
                  )),
            ));
  }
}
