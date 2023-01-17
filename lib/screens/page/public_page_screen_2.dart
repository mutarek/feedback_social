import 'package:als_frontend/util/palette.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class PublicPageScreen2 extends StatelessWidget {
  const PublicPageScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
            child: Stack(
              children: [
                Container(
                  height: 222,
                  color: Colors.white,
                ),
                //TODO cover Photo.........
                Container(
                  height: 170,
                  decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10), topLeft: Radius.circular(10))),
                ),
                Positioned(
                  top: 115,
                  left: 30,
                  child: Container(
                    height: 96,
                    width: 96,
                    color: Colors.blue,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18),
            child: Text(
              "Abstract Graphics Studio",
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500, fontSize: 22, color: AppColors.primaryColorLight),
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 18),
              child: Row(
                children: [
                  Container(
                    height: 10,
                    width: 10,
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, color: AppColors.primaryColorLight),
                    // child:  SvgPicture.asset("assets/svg/bookmark.svg",),
                  ),
                  SizedBox(
                    width: 1,
                  ),
                  Text("Followers: 5M",
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w700,
                          fontSize: 9,
                          color: AppColors.primaryColorLight)),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 10,
                    width: 10,
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, color: AppColors.primaryColorLight),
                    // child:  SvgPicture.asset("assets/svg/bookmark.svg",),
                  ),
                  SizedBox(
                    width: 1,
                  ),
                  Text("Following: 20",
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w700,
                          fontSize: 9,
                          color: AppColors.primaryColorLight))
                ],
              ),
            ),
          ),
          SizedBox(height: 9,),
          Padding(
            padding: const EdgeInsets.only(left: 18,right: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 35,
                  width: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1.0),
                      color: AppColors.imageBGColorLight),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.thumb_up,
                        size: 10,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text("Like" ,  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w700, fontSize: 10, color: AppColors.primaryColorLight),)
                    ],
                  ),
                ),

                Container(
                  height: 35,
                  width: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),

                      color: AppColors.primaryColorLight),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person_add,
                        size: 10,color: Colors.white,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text("Following" ,  style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w700, fontSize: 10, color: Colors.white),)
                    ],
                  ),
                ),

                Container(
                  height: 35,
                  width: 65,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1.0),
                      color: AppColors.imageBGColorLight),
                  child:    PopupMenuButton(
                    icon: Icon(Icons.more_horiz,size: 15,),
                    itemBuilder: (context) => [
                      // PopupMenuItem 1
                      PopupMenuItem(
                        child: Column(
 mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           SvgPicture.asset("assets/svg/add.svg",height: 10,width:20,),
                           SizedBox(width: 3,),
                           Text("Invites Friends",style: GoogleFonts.roboto(
                           fontWeight: FontWeight.w500, fontSize: 12, color: AppColors.primaryColorLight),)
                         ],
                        ),
                            SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // SvgPicture.asset("assets/svg/add.svg",height: 10,width:20,),
                                Icon(Icons.copy,size: 12,color: AppColors.primaryColorLight,),
                                SizedBox(width: 3,),
                                Text("Copy Link",style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w500, fontSize: 12, color: AppColors.primaryColorLight),)
                              ],
                            ),
                            SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SvgPicture.asset("assets/svg/block.svg",height: 10,width:20,),
                                SizedBox(width: 3,),
                                Text("Block",style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w500, fontSize: 12, color: AppColors.primaryColorLight),)
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
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 1,),
          Divider(

            thickness: 1.8,
            color: Color(0xffE4E6EB),
          )
        ],
      ),
    );
  }
}
