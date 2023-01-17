import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PagePostView extends StatelessWidget {
  const PagePostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 5,
        ),
        SizedBox(height: 15,),
        Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Text(
            "Details",
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w700, fontSize: 15, color: AppColors.primaryColorLight),
          ),
        ),
        SizedBox(height: 15,),
        Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Row(
            children: [
             Container(
               height: 15,
               width: 15,
               decoration: BoxDecoration(
                 color: AppColors.primaryColorLight,shape: BoxShape.circle,
               ),
               child: Padding(
                 padding: const EdgeInsets.all(4.0),
                 child: Image.asset("assets/background/category.png",),
               ),
             ),
              SizedBox(width: 2,),
              RichText(
                text: TextSpan(
                  text: "Cateory -" ,style: GoogleFonts.roboto(
                fontWeight: FontWeight.w800, fontSize: 12, color: AppColors.primaryColorLight),
                  children: [
                    TextSpan(
                      text: "ews & media website", style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400, fontSize: 12, color: AppColors.primaryColorLight),
                    )
                  ]
                ),
              )

            ],
          ),
        ),
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Row(
            children: [
              Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                  color: AppColors.primaryColorLight,shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 2,),
              Text("abs@google.com",style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w400, fontSize: 12, color: AppColors.primaryColorLight),)
            ],
          ),
        ),
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Row(
            children: [
              Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                  color: AppColors.primaryColorLight,shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 2,),
              Text("abs.com.bd",style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w400, fontSize: 12, color: AppColors.primaryColorLight),),

            ],
          ),
        ),
        SizedBox(height: 12,),
        Divider(
          thickness: 1.8,
          color: Color(0xffE4E6EB),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Text("Posts",style: GoogleFonts.roboto(
    fontWeight: FontWeight.w700, fontSize: 12, color: AppColors.primaryColorLight),),
        ),
      ],
    );
  }
}
