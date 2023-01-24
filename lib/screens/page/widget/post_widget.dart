import 'dart:async';

import 'package:als_frontend/screens/page/widget/popup_menu_widget.dart';
import 'package:als_frontend/util/image.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class PagePostView extends StatefulWidget {
  const PagePostView({Key? key, required this.description, required this.value, required this.showDescription}) : super(key: key);
  final String description;
  final bool value;
  final VoidCallback showDescription;

  @override
  State<PagePostView> createState() => _PagePostViewState();
}

class _PagePostViewState extends State<PagePostView> with TickerProviderStateMixin {

  int durationAnimationBox = 500;
  int durationAnimationBtnLongPress = 150;
  int durationAnimationBtnShortPress = 500;
  int durationAnimationIconWhenDrag = 150;
  int durationAnimationIconWhenRelease = 1000;

  // For long press btn
  late AnimationController animControlBtnLongPress, animControlBox;
  late Animation zoomIconLikeInBtn, tiltIconLikeInBtn, zoomTextLikeInBtn;
  late Animation fadeInBox;
  late Animation moveRightGroupIcon;
  late Animation pushIconLikeUp, pushIconLoveUp, pushIconHahaUp, pushIconWowUp, pushIconSadUp, pushIconAngryUp;
  late Animation zoomIconLike, zoomIconLove, zoomIconHaha, zoomIconWow, zoomIconSad, zoomIconAngry;

  late AnimationController animControlBtnShortPress;
  late Animation zoomIconLikeInBtn2, tiltIconLikeInBtn2;

  // For zoom icon when drag
  late AnimationController animControlIconWhenDrag;
  late AnimationController animControlIconWhenDragInside;
  late AnimationController animControlIconWhenDragOutside;
  late AnimationController animControlBoxWhenDragOutside;
  late Animation zoomIconChosen, zoomIconNotChosen;
  late Animation zoomIconWhenDragOutside;
  late Animation zoomIconWhenDragInside;
  late Animation zoomBoxWhenDragOutside;
  late Animation zoomBoxIcon;

  // For jump icon when release
  late AnimationController animControlIconWhenRelease;
  late Animation zoomIconWhenRelease, moveUpIconWhenRelease;
  late Animation moveLeftIconLikeWhenRelease,
      moveLeftIconLoveWhenRelease,
      moveLeftIconHahaWhenRelease,
      moveLeftIconWowWhenRelease,
      moveLeftIconSadWhenRelease,
      moveLeftIconAngryWhenRelease;

  Duration durationLongPress = Duration(milliseconds: 250);
  late Timer holdTimer;
  bool isLongPress = false;
  bool isLiked = false;

  // 0 = nothing, 1 = like, 2 = love, 3 = haha, 4 = wow, 5 = sad, 6 = angry
  int whichIconUserChoose = 0;

  // 0 = nothing, 1 = like, 2 = love, 3 = haha, 4 = wow, 5 = sad, 6 = angry
  int currentIconFocus = 0;
  int previousIconFocus = 0;
  bool isDragging = false;
  bool isDraggingOutside = false;
  bool isJustDragInside = true;


  @override
  void initState() {
    super.initState();

    // Button Like
    initAnimationBtnLike();

    // Box and Icons
    initAnimationBoxAndIcons();

    // Icon when drag
    initAnimationIconWhenDrag();

    // Icon when drag outside
    initAnimationIconWhenDragOutside();

    // Box when drag outside
    initAnimationBoxWhenDragOutside();

    // Icon when first drag
    initAnimationIconWhenDragInside();

    // Icon when release
    initAnimationIconWhenRelease();
  }

  initAnimationBtnLike() {
    // long press
    animControlBtnLongPress =
        AnimationController(vsync: this, duration: Duration(milliseconds: durationAnimationBtnLongPress));
    zoomIconLikeInBtn = Tween(begin: 1.0, end: 0.85).animate(animControlBtnLongPress);
    tiltIconLikeInBtn = Tween(begin: 0.0, end: 0.2).animate(animControlBtnLongPress);
    zoomTextLikeInBtn = Tween(begin: 1.0, end: 0.85).animate(animControlBtnLongPress);

    zoomIconLikeInBtn.addListener(() {
      setState(() {});
    });
    tiltIconLikeInBtn.addListener(() {
      setState(() {});
    });
    zoomTextLikeInBtn.addListener(() {
      setState(() {});
    });

    // short press
    animControlBtnShortPress =
        AnimationController(vsync: this, duration: Duration(milliseconds: durationAnimationBtnShortPress));
    zoomIconLikeInBtn2 = Tween(begin: 1.0, end: 0.2).animate(animControlBtnShortPress);
    tiltIconLikeInBtn2 = Tween(begin: 0.0, end: 0.8).animate(animControlBtnShortPress);

    zoomIconLikeInBtn2.addListener(() {
      setState(() {});
    });
    tiltIconLikeInBtn2.addListener(() {
      setState(() {});
    });
  }

  initAnimationBoxAndIcons() {
    animControlBox = AnimationController(vsync: this, duration: Duration(milliseconds: durationAnimationBox));

    // General
    moveRightGroupIcon = Tween(begin: 0.0, end: 10.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.0, 1.0)),
    );
    moveRightGroupIcon.addListener(() {
      setState(() {});
    });

    // Box
    fadeInBox = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.7, 1.0)),
    );
    fadeInBox.addListener(() {
      setState(() {});
    });

    // Icons
    pushIconLikeUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.0, 0.5)),
    );
    zoomIconLike = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.0, 0.5)),
    );

    pushIconLoveUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.1, 0.6)),
    );
    zoomIconLove = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.1, 0.6)),
    );

    pushIconHahaUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.2, 0.7)),
    );
    zoomIconHaha = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.2, 0.7)),
    );

    pushIconWowUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.3, 0.8)),
    );
    zoomIconWow = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.3, 0.8)),
    );

    pushIconSadUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.4, 0.9)),
    );
    zoomIconSad = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.4, 0.9)),
    );

    pushIconAngryUp = Tween(begin: 30.0, end: 60.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.5, 1.0)),
    );
    zoomIconAngry = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.5, 1.0)),
    );

    pushIconLikeUp.addListener(() {
      setState(() {});
    });
    zoomIconLike.addListener(() {
      setState(() {});
    });
    pushIconLoveUp.addListener(() {
      setState(() {});
    });
    zoomIconLove.addListener(() {
      setState(() {});
    });
    pushIconHahaUp.addListener(() {
      setState(() {});
    });
    zoomIconHaha.addListener(() {
      setState(() {});
    });
    pushIconWowUp.addListener(() {
      setState(() {});
    });
    zoomIconWow.addListener(() {
      setState(() {});
    });
    pushIconSadUp.addListener(() {
      setState(() {});
    });
    zoomIconSad.addListener(() {
      setState(() {});
    });
    pushIconAngryUp.addListener(() {
      setState(() {});
    });
    zoomIconAngry.addListener(() {
      setState(() {});
    });
  }

  initAnimationIconWhenDrag() {
    animControlIconWhenDrag =
        AnimationController(vsync: this, duration: Duration(milliseconds: durationAnimationIconWhenDrag));

    zoomIconChosen = Tween(begin: 1.0, end: 1.8).animate(animControlIconWhenDrag);
    zoomIconNotChosen = Tween(begin: 1.0, end: 0.8).animate(animControlIconWhenDrag);
    zoomBoxIcon = Tween(begin: 50.0, end: 40.0).animate(animControlIconWhenDrag);

    zoomIconChosen.addListener(() {
      setState(() {});
    });
    zoomIconNotChosen.addListener(() {
      setState(() {});
    });
    zoomBoxIcon.addListener(() {
      setState(() {});
    });
  }

  initAnimationIconWhenDragOutside() {
    animControlIconWhenDragOutside =
        AnimationController(vsync: this, duration: Duration(milliseconds: durationAnimationIconWhenDrag));
    zoomIconWhenDragOutside = Tween(begin: 0.8, end: 1.0).animate(animControlIconWhenDragOutside);
    zoomIconWhenDragOutside.addListener(() {
      setState(() {});
    });
  }

  initAnimationBoxWhenDragOutside() {
    animControlBoxWhenDragOutside =
        AnimationController(vsync: this, duration: Duration(milliseconds: durationAnimationIconWhenDrag));
    zoomBoxWhenDragOutside = Tween(begin: 40.0, end: 50.0).animate(animControlBoxWhenDragOutside);
    zoomBoxWhenDragOutside.addListener(() {
      setState(() {});
    });
  }

  initAnimationIconWhenDragInside() {
    animControlIconWhenDragInside =
        AnimationController(vsync: this, duration: Duration(milliseconds: durationAnimationIconWhenDrag));
    zoomIconWhenDragInside = Tween(begin: 1.0, end: 0.8).animate(animControlIconWhenDragInside);
    zoomIconWhenDragInside.addListener(() {
      setState(() {});
    });
    animControlIconWhenDragInside.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        isJustDragInside = false;
      }
    });
  }

  initAnimationIconWhenRelease() {
    animControlIconWhenRelease =
        AnimationController(vsync: this, duration: Duration(milliseconds: durationAnimationIconWhenRelease));

    zoomIconWhenRelease = Tween(begin: 1.8, end: 0.0)
        .animate(CurvedAnimation(parent: animControlIconWhenRelease, curve: Curves.decelerate));

    moveUpIconWhenRelease = Tween(begin: 180.0, end: 0.0)
        .animate(CurvedAnimation(parent: animControlIconWhenRelease, curve: Curves.decelerate));

    moveLeftIconLikeWhenRelease = Tween(begin: 20.0, end: 10.0)
        .animate(CurvedAnimation(parent: animControlIconWhenRelease, curve: Curves.decelerate));
    moveLeftIconLoveWhenRelease = Tween(begin: 68.0, end: 10.0)
        .animate(CurvedAnimation(parent: animControlIconWhenRelease, curve: Curves.decelerate));
    moveLeftIconHahaWhenRelease = Tween(begin: 116.0, end: 10.0)
        .animate(CurvedAnimation(parent: animControlIconWhenRelease, curve: Curves.decelerate));
    moveLeftIconWowWhenRelease = Tween(begin: 164.0, end: 10.0)
        .animate(CurvedAnimation(parent: animControlIconWhenRelease, curve: Curves.decelerate));
    moveLeftIconSadWhenRelease = Tween(begin: 212.0, end: 10.0)
        .animate(CurvedAnimation(parent: animControlIconWhenRelease, curve: Curves.decelerate));
    moveLeftIconAngryWhenRelease = Tween(begin: 260.0, end: 10.0)
        .animate(CurvedAnimation(parent: animControlIconWhenRelease, curve: Curves.decelerate));

    zoomIconWhenRelease.addListener(() {
      setState(() {});
    });
    moveUpIconWhenRelease.addListener(() {
      setState(() {});
    });

    moveLeftIconLikeWhenRelease.addListener(() {
      setState(() {});
    });
    moveLeftIconLoveWhenRelease.addListener(() {
      setState(() {});
    });
    moveLeftIconHahaWhenRelease.addListener(() {
      setState(() {});
    });
    moveLeftIconWowWhenRelease.addListener(() {
      setState(() {});
    });
    moveLeftIconSadWhenRelease.addListener(() {
      setState(() {});
    });
    moveLeftIconAngryWhenRelease.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    animControlBtnLongPress.dispose();
    animControlBox.dispose();
    animControlIconWhenDrag.dispose();
    animControlIconWhenDragInside.dispose();
    animControlIconWhenDragOutside.dispose();
    animControlBoxWhenDragOutside.dispose();
    animControlIconWhenRelease.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String firstHalf;
    String secondHalf;

    if (widget.description.length > 190) {
      firstHalf = widget.description.substring(0, 190);
      secondHalf = widget.description.substring(190, widget.description.length);
    } else {
      firstHalf = widget.description;
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
                            text: widget.value ? ("$firstHalf...") : (firstHalf + secondHalf),
                            style: robotoStyle400Regular.copyWith(fontSize: 14),
                            children: [
                              TextSpan(
                                text: widget.value ? "show more" : "show less",
                                style: robotoStyle600SemiBold.copyWith(fontSize: 14),
                                recognizer: TapGestureRecognizer()..onTap = widget.showDescription,
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
                        likeCommentShareButtonWidget(ImagesModel.likeIcons, "Like", () {
                        }),
                        likeCommentShareButtonWidget(ImagesModel.commentIcons, "Comment", () {}),
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
