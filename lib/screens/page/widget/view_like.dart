import 'package:als_frontend/provider/group_provider.dart';
import 'package:als_frontend/provider/page_provider.dart';
import 'package:als_frontend/util/image.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ViewLike extends StatefulWidget {
  const ViewLike({Key? key}) : super(key: key);

  @override
  State<ViewLike> createState() => _ViewLikeState();
}

class _ViewLikeState extends State<ViewLike> {
  PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Consumer<PageProvider>(builder: (context, pageProvider, child) {
      return PopupMenuButton(
          itemBuilder: (context) => [
                // PopupMenuItem 1
                PopupMenuItem(
                    child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              pageProvider.changeMenuValue(0);
                            },
                            child: RichText(
                                text: TextSpan(text: "All", style: robotoStyle700Bold, children: [
                              TextSpan(text: " 5500", style: robotoStyle400Regular)
                            ])),
                          ),
                          InkWell(
                            onTap: () {
                              pageProvider.changeMenuValue(1);
                            },
                            child: Row(
                              children: [
                                Container(
                                  height: 17,
                                  width: 17,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle, color: AppColors.primaryColorLight),
                                  child: Center(
                                      child: SvgPicture.asset("assets/svg/like.svg",
                                          fit: BoxFit.cover, height: 9, width: 8)),
                                ),
                                SizedBox(width: 3),
                                Text(
                                  "50",
                                  style: robotoStyle400Regular,
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              pageProvider.changeMenuValue(2);
                            },
                            child: Row(
                              children: [
                                Container(
                                  height: 17,
                                  width: 17,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle, color: Colors.red),
                                  child: Center(
                                      child: SvgPicture.asset("assets/svg/love.svg",
                                          fit: BoxFit.cover, height: 9, width: 8)),
                                ),
                                SizedBox(width: 3),
                                Text(
                                  "50",
                                  style: robotoStyle400Regular,
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              pageProvider.changeMenuValue(3);
                            },
                            child: Row(
                              children: [
                                Container(
                                  height: 17,
                                  width: 17,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle, color: Colors.yellow),
                                  child: Center(
                                      child: SvgPicture.asset("assets/svg/haha.svg",
                                          fit: BoxFit.cover, height: 9, width: 8)),
                                ),
                                SizedBox(width: 3),
                                Text(
                                  "50",
                                  style: robotoStyle400Regular,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    PageView.builder(
                      itemCount: 5,
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      onPageChanged: (int i) {
                        FocusScope.of(context).requestFocus(FocusNode());
                        pageProvider.changeMenuValue(i);
                      },
                      itemBuilder: (context, index) {
                       return (pageProvider.menuValue == 0)
                            ? Container(height: 4, width: 4, color: Colors.yellow)
                            : (pageProvider.menuValue == 1)
                            ? Container(height: 4, width: 4, color: Colors.green)
                            : (pageProvider.menuValue == 2)
                            ? Container(height: 4, width: 4, color: Colors.red)
                            : (pageProvider.menuValue == 3)
                            ? Container(height: 4, width: 4, color: Colors.yellow)
                            :  SizedBox.shrink();
                      },
                    ),

                  ],
                ))
                // PopupMenuItem 2
              ],
          offset: const Offset(0, 58),
          color: Colors.white,
          elevation: 4,
          child: RichText(
              text: TextSpan(
                  text: "Rafatul ",
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w600, fontSize: 12, color: Colors.black),
                  children: [
                TextSpan(
                    text: " and",
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: AppColors.primaryColorLight),
                    children: [
                      TextSpan(
                          text: " 5,500",
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w600, fontSize: 12, color: Colors.black),
                          children: [
                            TextSpan(
                                text: " others",
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: AppColors.primaryColorLight))
                          ])
                    ])
              ])));
    });
  }
}
