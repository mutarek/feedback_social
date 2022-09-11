import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../const/palette.dart';
import '../../provider/provider.dart';
import '../../screens/screens.dart';
import '../widgets.dart';

class FlagPageWidget extends StatefulWidget {
  const FlagPageWidget({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  State<FlagPageWidget> createState() => _FlagPageWidgetState();
}

class _FlagPageWidgetState extends State<FlagPageWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(
          top: widget.height * 0.02,
        ),
        child: Column(
          children: [
            SizedBox(
              height: widget.height * 0.15,
              width: widget.width,
              child: Consumer5<AuthorPagesProvider, WritePagePostProvider,
                      AuthorPageDetailsProvider, PagePostProvider, CreatePagePost>(
                  builder: (context, provider, pagePostProvider, 
                      authorPageDetailsProvider,pagePostsProvider,
                      createPagePost, child) {
                return (provider.pages!.isEmpty)
                    ? const Center(
                        child: Text(
                        "You have no Page",
                        style: TextStyle(fontSize: 16),
                      ))
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: provider.pages!.length,
                        itemBuilder: (context, index2) {
                          return InkWell(
                            onTap: () {
                              createPagePost.pageId = provider.pages![index2].id;
                              authorPageDetailsProvider.pageIndex =
                                  provider.pages![index2].id;
                              pagePostsProvider.id = provider.pages![index2].id;
                              

                              Get.to(() => const AdminPage());
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: widget.height * 0.04,
                                    backgroundColor: Palette.notificationColor,
                                    child: CircleAvatar(
                                      radius: widget.height * 0.0368,
                                      backgroundColor: Palette.scaffold,
                                      backgroundImage: NetworkImage(
                                          provider.pages![index2].avatar),
                                    ),
                                  ),
                                  Text(
                                    provider.pages![index2].name,
                                    style: GoogleFonts.lato(
                                        fontSize: widget.height * 0.02,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Pages",
                style: GoogleFonts.lato(
                    fontSize: widget.height * 0.03,
                    fontWeight: FontWeight.w700),
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(const CreatPage());
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    height: widget.height * 0.037,
                    width: widget.width * 0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: const LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        stops: [
                          0.1,
                          0.7,
                        ],
                        colors: [
                          Palette.primary,
                          Palette.notificationColor,
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Palette.primary.withOpacity(0.4),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset:
                              const Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Center(
                        child: Text("Create ",
                            style: GoogleFonts.lato(
                                fontWeight: FontWeight.w400,
                                color: Colors.white)))),
              ),
            ),
            const Text(
              "Suggested Pages",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Consumer4<AllPageProvider, SuggestedPageDetailsProvider, PagePostProvider, PageLikeProvider>(builder:
                (context, provider, suggestedPageDetailsProvider, pagePostsProvider, pageLikeProvider, child) {
              return Visibility(
                child: Expanded(
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: provider.pages!.length,
                      itemBuilder: (context, index2) {
                        return CustomPageGroupButton(
                            onTap: () {
                              pageLikeProvider.pageId =
                                  provider.pages![index2].id;
                              suggestedPageDetailsProvider.pageIndex =
                                  provider.pages![index2].id;
                              pagePostsProvider.id = provider.pages![index2].id;
                              Get.to(() => const SuggestedPageView());
                            },
                            goToGroupOrPage: () {},
                            groupOrPageImage: provider.pages![index2].avatar,
                            groupOrPageName: provider.pages![index2].name,
                            groupOrPageLikes:
                                "${provider.pages![index2].followers} Likes");
                      }),
                ),
                replacement: const CircularProgressIndicator(),
              );
            }),
          ],
        ),
      ),
    );
  }
}
