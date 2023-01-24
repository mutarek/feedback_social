import 'package:als_frontend/screens/page/widget/page_comment_view.dart';
import 'package:als_frontend/screens/page/widget/popup_menu_widget.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/image.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class PagePostView extends StatelessWidget {
  const PagePostView({Key? key, required this.description, required this.value, required this.showDescription}) : super(key: key);
  final String description;
  final bool value;
  final VoidCallback showDescription;

  @override
  Widget build(BuildContext context) {
    String firstHalf;
    String secondHalf;

    if (description.length > 190) {
      firstHalf = description.substring(0, 190);
      secondHalf = description.substring(190, description.length);
    } else {
      firstHalf = description;
      secondHalf = "";
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Padding(padding: const EdgeInsets.only(left: 18), child: Text("Details", style: robotoStyle700Bold.copyWith(fontSize: 16))),
        const SizedBox(height: 15),
        infoWidget(
            ImagesModel.categoryIcons, "news & media website", Text('Category - ', style: robotoStyle800ExtraBold.copyWith(fontSize: 15))),
        const SizedBox(height: 10),
        infoWidget(ImagesModel.emailIcons, "abs@google.com", const SizedBox.shrink()),
        const SizedBox(height: 10),
        infoWidget(ImagesModel.websiteIcons, "abs.com.bd", const SizedBox.shrink()),
        const SizedBox(height: 20),
        const Divider(thickness: 1.8, color: Color(0xffE4E6EB)),
        Padding(padding: const EdgeInsets.only(left: 18), child: Text("Posts", style: robotoStyle700Bold.copyWith(fontSize: 16))),
        const SizedBox(height: 10),
        ListView.builder(
            padding: const EdgeInsets.only(top: 0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18, right: 18),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 36,
                          width: 36,
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColors.primaryColorLight),
                              shape: BoxShape.circle,
                              image: const DecorationImage(image: AssetImage("assets/background/help.png"), fit: BoxFit.cover)),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Abstract Graphics Studio", style: robotoStyle700Bold),
                            Row(
                              children: [
                                SvgPicture.asset(ImagesModel.timeIcons, width: 12, height: 13),
                                const SizedBox(width: 2),
                                Text("2 Hours  -", style: robotoStyle500Medium.copyWith(fontSize: 10)),
                                const SizedBox(width: 3),
                                SvgPicture.asset(ImagesModel.globalIcons, width: 12, height: 12),
                              ],
                            )
                          ],
                        ),
                        const Spacer(),
                        PopupMenuButton(
                          itemBuilder: (context) => [
                            // PopupMenuItem 1
                            PopupMenuItem(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  PopUpMenuWidget(ImagesModel.saveIcons, 'Save', () {}),
                                  const SizedBox(height: 15),
                                  PopUpMenuWidget(ImagesModel.hideIcons, 'Hide this post', () {}),
                                  const SizedBox(height: 15),
                                  PopUpMenuWidget(ImagesModel.copyIcons, 'Copy Link', () {}),
                                  const SizedBox(height: 15),
                                  PopUpMenuWidget(ImagesModel.reportIcons, 'Report Post', () {}),
                                  const SizedBox(height: 8)
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
                            height: 24,
                            width: 30,
                            decoration: BoxDecoration(color: const Color(0xffE4E6EB), borderRadius: BorderRadius.circular(10)),
                            child: const Center(child: Icon(Icons.more_horiz)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 18, right: 18),
                    child: RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                            text: value ? ("$firstHalf...") : (firstHalf + secondHalf),
                            style: robotoStyle400Regular.copyWith(fontSize: 14),
                            children: [
                              TextSpan(
                                text: value ? "show more" : "show less",
                                style: robotoStyle600SemiBold.copyWith(fontSize: 14),
                                recognizer: TapGestureRecognizer()..onTap = showDescription,
                              )
                            ])),
                  ),
                  const SizedBox(height: 7),
                  Container(
                    height: 229,
                    color: AppColors.imageBGColorLight,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12, top: 7, right: 12),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            const SizedBox(height: 17, width: 50),
                            Container(
                              height: 17,
                              width: 17,
                              decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primaryColorLight),
                              child: Center(child: SvgPicture.asset("assets/svg/like.svg", fit: BoxFit.cover, height: 9, width: 8)),
                            ),
                            Positioned(
                              left: 14,
                              child: Container(
                                height: 17,
                                width: 17,
                                decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                                child: Center(child: SvgPicture.asset("assets/svg/love.svg", fit: BoxFit.cover, height: 9, width: 8)),
                              ),
                            ),
                            Positioned(
                              left: 28,
                              child: Container(
                                height: 17,
                                width: 17,
                                decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.yellow),
                                child: Center(child: SvgPicture.asset("assets/svg/haha.svg", fit: BoxFit.cover, height: 9, width: 8)),
                              ),
                            ),
                          ],
                        ),
                        RichText(
                            text: TextSpan(text: "Rafatul ", style: robotoStyle600SemiBold.copyWith(fontSize: 12), children: [
                          TextSpan(
                              text: " and",
                              style: GoogleFonts.roboto(fontWeight: FontWeight.w400, fontSize: 12, color: AppColors.primaryColorLight),
                              children: [
                                TextSpan(
                                    text: " 5,500",
                                    style: GoogleFonts.roboto(fontWeight: FontWeight.w600, fontSize: 12, color: Colors.black),
                                    children: [
                                      TextSpan(
                                        text: " others",
                                        style: GoogleFonts.roboto(
                                            fontWeight: FontWeight.w400, fontSize: 12, color: AppColors.primaryColorLight),
                                      ),
                                    ])
                              ])
                        ])),
                        const Spacer(),
                        Row(
                          children: [
                            Container(
                                height: 17,
                                width: 17,
                                decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primaryColorLight),
                                child: Center(child: SvgPicture.asset("assets/svg/comment.svg", fit: BoxFit.cover, height: 9, width: 8))),
                            const SizedBox(width: 3),
                            Text(
                              "120",
                              style: GoogleFonts.roboto(fontWeight: FontWeight.w600, fontSize: 12, color: Colors.black),
                            )
                          ],
                        ),
                        const SizedBox(width: 18),
                        Row(
                          children: [
                            Container(
                                height: 17,
                                width: 17,
                                decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primaryColorLight),
                                child: Center(child: SvgPicture.asset("assets/svg/share2.svg", fit: BoxFit.cover, height: 9, width: 8))),
                            const SizedBox(width: 3),
                            Text(
                              "90",
                              style: GoogleFonts.roboto(fontWeight: FontWeight.w600, fontSize: 12, color: Colors.black),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  Padding(
                    padding: const EdgeInsets.only(left: 18, right: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        likeCommentShareButtonWidget(ImagesModel.likeIcons, "Like", () {}),
                        likeCommentShareButtonWidget(ImagesModel.commentIcons, "Comment", () {Helper.toScreen(PageCommentView(value: true, showDescription: () {  }, description: '',));}),
                        PopupMenuButton(
                          itemBuilder: (context) => [
                            // PopupMenuItem 1
                            PopupMenuItem(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  PopUpMenuWidget(ImagesModel.shareTimelinesIcons, 'Share on your timeline', () {}, size: 18),
                                  const SizedBox(height: 18),
                                  PopUpMenuWidget(ImagesModel.shareMessageIcons, 'Share via message', () {}, size: 18),
                                  const SizedBox(height: 18),
                                  PopUpMenuWidget(ImagesModel.shareFriendIcons, 'Share to friends timeline', () {}, size: 16),
                                  const SizedBox(height: 18),
                                  PopUpMenuWidget(ImagesModel.shareGroupIcons, 'Share to a group', () {}, size: 16),
                                  const SizedBox(height: 18),
                                  PopUpMenuWidget(ImagesModel.pageIconsPng, 'Share to a page', () {}, size: 18,isShowAssetImage: true),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                            // PopupMenuItem 2
                          ],
                          offset: const Offset(0, 58),
                          color: Colors.white,
                          elevation: 4,
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                          child: Row(
                            children: [
                              Container(
                                height: 23,
                                width: 37,
                                decoration: BoxDecoration(color: AppColors.primaryColorLight, borderRadius: BorderRadius.circular(18)),
                                child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: SvgPicture.asset(ImagesModel.share2Icons, height: 13, width: 12, color: Colors.white)),
                              ),
                              const SizedBox(width: 5),
                              Text("Share", style: robotoStyle600SemiBold.copyWith())
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 1.8,
                    color: Color(0xffE4E6EB),
                  ),
                ],
              );
            })
      ],
    );
  }

  Widget likeCommentShareButtonWidget(String image, String title, GestureTapCallback callback) {
    return InkWell(
      onTap: callback,
      child: Row(
        children: [
          Container(
            height: 23,
            width: 37,
            decoration: BoxDecoration(color: AppColors.primaryColorLight, borderRadius: BorderRadius.circular(18)),
            child: Padding(padding: const EdgeInsets.all(4.0), child: SvgPicture.asset(image, height: 13, width: 12, color: Colors.white)),
          ),
          const SizedBox(width: 5),
          Text(title, style: robotoStyle600SemiBold.copyWith())
        ],
      ),
    );
  }

  Widget infoWidget(String imageURL, String title, Widget widget) {
    return Padding(
      padding: const EdgeInsets.only(left: 18),
      child: Row(
        children: [
          Container(
            height: 20,
            width: 20,
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(color: AppColors.primaryColorLight, shape: BoxShape.circle),
            child: SvgPicture.asset(imageURL, height: 13, width: 13),
          ),
          const SizedBox(width: 2),
          widget,
          const SizedBox(width: 2),
          Text(title, style: robotoStyle400Regular.copyWith(fontSize: 14))
        ],
      ),
    );
  }
}
