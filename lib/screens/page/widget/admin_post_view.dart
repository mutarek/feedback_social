
import 'package:als_frontend/util/image.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminPostView extends StatelessWidget {
  const AdminPostView(
      {Key? key, required this.dicription, required this.value, required this.showDescription})
      : super(key: key);
  final String dicription;
  final bool value;
  final VoidCallback showDescription;

  @override
  Widget build(BuildContext context) {
    String firstHalf;
    String secondHalf;

    if (dicription.length > 190) {
      firstHalf = dicription.substring(0, 190);
      secondHalf = dicription.substring(190, dicription.length);
    } else {
      firstHalf = dicription;
      secondHalf = "";
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 5,
        ),
        const SizedBox(
          height: 15,
        ),
       Padding(
         padding: const EdgeInsets.only(left: 18,right: 16),
         child: Container(
           height: 130,
           decoration: BoxDecoration(
             color: AppColors.imageBGColorLight,
             borderRadius: BorderRadius.circular(10),
             border: Border.all(color: AppColors.primaryColorLight,width:0.4)
           ),
           child: Column(
           
             children: [
               Row(
                 mainAxisAlignment: MainAxisAlignment.end,

                 children: [
                   Icon(Icons.add)
                 ],
               )
             ],
           ),
         ),
       ),
        Padding(
          padding: const EdgeInsets.only(
            left: 18,
            top: 5
          ),
          child: Container(
            height: 22,
            width: 43,
            decoration: BoxDecoration(
              color: AppColors.primaryColorLight,
              borderRadius: BorderRadius.circular(20)
            ),

            child: Center(
              child: Text(
                "Posts",
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w700, fontSize: 12, color: Colors.white),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ListView.builder(
            padding: const EdgeInsets.only(top: 0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 2,
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
                              image: const DecorationImage(
                                  image: AssetImage("assets/background/help.png"),
                                  fit: BoxFit.cover)),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Abstract Graphics Studio",
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13.5,
                                  color: AppColors.primaryColorLight),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.fact_check_outlined,
                                  color: AppColors.primaryColorLight,
                                  size: 12,
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "2 Hours  -",
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 7,
                                      color: AppColors.primaryColorLight),
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                const Icon(
                                  Icons.circle,
                                  color: AppColors.primaryColorLight,
                                  size: 12,
                                )
                              ],
                            )
                          ],
                        ),
                        const Spacer(),
                        PopupMenuButton(
                          child:  Container(
                            height: 24,
                            width: 30,
                            decoration: BoxDecoration(
                                color: const Color(0xffE4E6EB),
                                borderRadius: BorderRadius.circular(10)),
                            child: const Center(child: Icon(Icons.more_horiz)),
                          ),
                          itemBuilder: (context) => [
                            // PopupMenuItem 1
                            PopupMenuItem(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset("assets/svg/save.svg",height: 14,width: 14,),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        "Save",
                                        style: GoogleFonts.roboto(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            color: AppColors.primaryColorLight),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 18,
                                  ),

                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/svg/hide.svg",
                                        height: 12,width: 16,
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        "Hide this post",
                                        style: GoogleFonts.roboto(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            color: AppColors.primaryColorLight),
                                      )
                                    ],
                                  ),

                                  const SizedBox(
                                    height: 18,
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.copy,size: 12,),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        "Copy Link",
                                        style: GoogleFonts.roboto(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            color: AppColors.primaryColorLight),
                                      )
                                    ],
                                  ),

                                  const SizedBox(
                                    height: 18,
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset("assets/svg/report.svg",height: 14,width:10 ,),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        "Share to a page",
                                        style: GoogleFonts.roboto(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            color: AppColors.primaryColorLight),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            // PopupMenuItem 2
                          ],
                          offset: const Offset(0, 58),
                          color: Colors.white,
                          elevation: 4,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0))),
                        ),

                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18, right: 18),
                    child: RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                            text: value ? (firstHalf + "...") : (firstHalf + secondHalf),
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w400,
                                fontSize: 10,
                                color: AppColors.primaryColorLight),
                            children: [
                              TextSpan(
                                text: value ? "show more" : "show less",
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    color: AppColors.primaryColorLight),
                                recognizer: TapGestureRecognizer()..onTap = showDescription,
                              )
                            ])),
                  ),
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
                            Container(
                              height: 17,
                              width: 50,
                            ),
                            Container(
                              height: 17,
                              width: 17,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: AppColors.primaryColorLight),
                              child: Center(
                                  child: SvgPicture.asset(
                                    "assets/svg/like.svg",
                                    fit: BoxFit.cover,
                                    height: 9,
                                    width: 8,
                                  )),
                            ),
                            Positioned(
                              left: 14,
                              child: Container(
                                height: 17,
                                width: 17,
                                decoration:
                                const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                                child: Center(
                                    child: SvgPicture.asset(
                                      "assets/svg/love.svg",
                                      fit: BoxFit.cover,
                                      height: 9,
                                      width: 8,
                                    )),
                              ),
                            ),
                            Positioned(
                              left: 28,
                              child: Container(
                                height: 17,
                                width: 17,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.yellow),
                                child: Center(
                                    child: SvgPicture.asset(
                                      "assets/svg/haha.svg",
                                      fit: BoxFit.cover,
                                      height: 9,
                                      width: 8,
                                    )),
                              ),
                            ),
                          ],
                        ),
                        RichText(
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
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                                color: Colors.black),
                                            children: [
                                              TextSpan(
                                                text: " others",
                                                style: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                    color: AppColors.primaryColorLight),
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
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle, color: AppColors.primaryColorLight),
                                child: Center(
                                    child: SvgPicture.asset(
                                      "assets/svg/comment.svg",
                                      fit: BoxFit.cover,
                                      height: 9,
                                      width: 8,
                                    ))),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(
                              "120",
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w600, fontSize: 12, color: Colors.black),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        Row(
                          children: [
                            Container(
                                height: 17,
                                width: 17,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle, color: AppColors.primaryColorLight),
                                child: Center(
                                    child: SvgPicture.asset(
                                      "assets/svg/share2.svg",
                                      fit: BoxFit.cover,
                                      height: 9,
                                      width: 8,
                                    ))),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(
                              "90",
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w600, fontSize: 12, color: Colors.black),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18, right: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 23,
                          width: 37,
                          decoration: BoxDecoration(
                              color: AppColors.primaryColorLight,
                              borderRadius: BorderRadius.circular(18)),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: SvgPicture.asset(
                              "assets/svg/like.svg",
                              height: 13,
                              width: 12,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        Container(
                          height: 23,
                          width: 37,
                          decoration: BoxDecoration(
                              color: AppColors.primaryColorLight,
                              borderRadius: BorderRadius.circular(18)),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: SvgPicture.asset(
                              "assets/svg/comment.svg",
                              height: 13,
                              width: 12,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        PopupMenuButton(
                          child: Container(
                            height: 23,
                            width: 37,
                            decoration: BoxDecoration(
                                color: AppColors.primaryColorLight,
                                borderRadius: BorderRadius.circular(18)),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: SvgPicture.asset(
                                "assets/svg/share2.svg",
                                height: 13,
                                width: 12,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                          itemBuilder: (context) => [
                            // PopupMenuItem 1
                            PopupMenuItem(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.pending_actions),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        "Share on your timeline",
                                        style: GoogleFonts.roboto(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            color: AppColors.primaryColorLight),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 18,
                                  ),
                                  Row(
                                    children: [
                                      // SvgPicture.asset("assets/svg/add.svg",height: 10,width:20,),
                                      SvgPicture.asset("assets/svg/plane2.svg",height: 18,width: 18,),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        "Share via message",
                                        style: GoogleFonts.roboto(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            color: AppColors.primaryColorLight),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 18,
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/svg/twoPeople.svg",
                                        height: 13,width: 13,
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        "Share to friends timeline",
                                        style: GoogleFonts.roboto(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            color: AppColors.primaryColorLight),
                                      )
                                    ],
                                  ),

                                  const SizedBox(
                                    height: 18,
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/svg/threePeople.svg",
                                        height: 13,width: 13,
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        "Share to a group",
                                        style: GoogleFonts.roboto(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            color: AppColors.primaryColorLight),
                                      )
                                    ],
                                  ),

                                  const SizedBox(
                                    height: 18,
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(ImagesModel.pageIconsPng, width: 18, height: 18),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        "Share to a page",
                                        style: GoogleFonts.roboto(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            color: AppColors.primaryColorLight),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            // PopupMenuItem 2
                          ],
                          offset: const Offset(0, 58),
                          color: Colors.white,
                          elevation: 4,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0))),
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
}
