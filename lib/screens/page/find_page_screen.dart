import 'package:als_frontend/provider/page_provider.dart';
import 'package:als_frontend/screens/page/new_design/new_page_details_screen.dart';
import 'package:als_frontend/screens/page/shimmer_effect/invite_page_shimmer.dart';
import 'package:als_frontend/screens/page/widget/page_app_bar.dart';
import 'package:als_frontend/screens/page/widget/popup_menu_widget.dart';
import 'package:als_frontend/screens/video/widget/new_video_widgets.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/image.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FindPageScreen extends StatefulWidget {
  const FindPageScreen({Key? key}) : super(key: key);

  @override
  State<FindPageScreen> createState() => _FindPageScreenState();
}

class _FindPageScreenState extends State<FindPageScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PageAppBar(title: 'Find Page'),
      backgroundColor: Colors.white,
      body: Consumer<PageProvider>(builder: (context, pageProvider, child) {
        return Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                height: 48.0,
                width: double.infinity,
                decoration: BoxDecoration(border: Border.all(color: colorText, width: 2), borderRadius: BorderRadius.circular(25)),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: "Search..",
                            hintStyle: TextStyle(color: Colors.black)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2),
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: AppColors.primaryColorLight),
                        height: 38,
                        width: 71,
                        child: Center(
                          child: InkWell(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                pageProvider.findPage(searchController.text);
                              },
                              child: Text('Search', style: robotoStyle300Light.copyWith(fontSize: 12, color: Colors.white))),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                child: ListView.builder(
                  itemCount: pageProvider.findPageModel.length,
                  itemBuilder: (_, index) {
                    return pageProvider.isLoadingFindPage?const InvitePageShimmer():InkWell(
                      onTap: () {
                        pageProvider.changeSearchView(2);
                        String id = pageProvider.findPageModel[index].likedUrl.replaceAll("/page/like/user/", "").replaceAll("/list/", "");
                        Helper.toScreen(NewPageDetailsScreen(id, index: index));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(color: lightWhiteColor, borderRadius: BorderRadius.circular(15), boxShadow: [
                          BoxShadow(color: colorText.withOpacity(.06), blurRadius: 3.0, spreadRadius: 2.0, offset: const Offset(0.0, 0.0))
                        ]),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(.1), blurRadius: 10.0, spreadRadius: 3.0, offset: const Offset(0.0, 0.0))
                              ]),
                              child: customNetworkImage(pageProvider.findPageModel[index].avatar),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(pageProvider.findPageModel[index].name,
                                  style: robotoStyle700Bold.copyWith(fontSize: 16, color: Colors.black)),
                            ),
                            const SizedBox(width: 10),
                            PopupMenuButton(
                              itemBuilder: (context) => [
                                // PopupMenuItem 1
                                PopupMenuItem(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      PopUpMenuWidget(ImagesModel.likeIcons, 'Like', () {}, size: 18),
                                      const SizedBox(height: 18),
                                      PopUpMenuWidget(ImagesModel.copyIcons, 'Copy Link', () {}, size: 18),
                                    ],
                                  ),
                                ),
                                // PopupMenuItem 2
                              ],
                              offset: const Offset(0, 58),
                              color: Colors.white,
                              elevation: 4,
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                              child: Container(
                                  width: 35,
                                  height: 25,
                                  margin: const EdgeInsets.only(top: 2),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(color: const Color(0xffE4E6EB), borderRadius: BorderRadius.circular(10)),
                                  child: const Icon(Icons.more_horiz, color: colorText, size: 20)),
                            ),
                            const SizedBox(width: 10),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        );
      }),
    );
  }

  Card buildCard(PageProvider pageProvider, int index) {
    return Card(
      color: const Color(0xffFAFAFA),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Container(
          height: 36,
          width: 36,
          decoration: BoxDecoration(
              color: const Color(0xffFFFFFF), image: DecorationImage(image: NetworkImage(pageProvider.findPageModel[index].avatar))),
        ),
        title: Text(pageProvider.findPageModel[index].name,
            style: GoogleFonts.roboto(fontWeight: FontWeight.w700, fontSize: 15, color: Colors.black)),
        trailing: PopupMenuButton(
          itemBuilder: (context) => [
            // PopupMenuItem 1
            PopupMenuItem(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PopUpMenuWidget(ImagesModel.likeIcons, 'Like', () {}, size: 18),
                  const SizedBox(height: 18),
                  PopUpMenuWidget(ImagesModel.copyIcons, 'Copy Link', () {}, size: 18),
                  const SizedBox(height: 18),
                ],
              ),
            ),
            // PopupMenuItem 2
          ],
          offset: const Offset(0, 58),
          color: Colors.white,
          elevation: 4,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: Container(
              width: 26,
              height: 20,
              margin: const EdgeInsets.only(top: 2),
              alignment: Alignment.center,
              decoration: BoxDecoration(color: const Color(0xffE4E6EB), borderRadius: BorderRadius.circular(10)),
              child: const Icon(Icons.more_horiz, color: colorText, size: 19)),
        ),
      ),
    );
  }
}
