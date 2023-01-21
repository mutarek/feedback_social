import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PageAboutView extends StatefulWidget {
  const PageAboutView({Key? key}) : super(key: key);

  @override
  State<PageAboutView> createState() => _PageAboutViewState();
}

class _PageAboutViewState extends State<PageAboutView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Text(
            "Intro",
            style: GoogleFonts.roboto(fontWeight: FontWeight.w700, fontSize: 15, color: AppColors.primaryColorLight),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Text(
            "We are part of global community focused on change",
            style: GoogleFonts.roboto(fontWeight: FontWeight.w400, fontSize: 12, color: AppColors.primaryColorLight),
          ),
        ),
        SizedBox(height: 3,),
        Divider(
          height: 2,
        ),
        SizedBox(height: 3,),
        Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Text(
            "Details",
            style: GoogleFonts.roboto(fontWeight: FontWeight.w700, fontSize: 15, color: AppColors.primaryColorLight),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Row(
            children: [
              Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                  color: AppColors.primaryColorLight,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Image.asset(
                    "assets/background/category.png",
                  ),
                ),
              ),
              SizedBox(
                width: 2,
              ),
              RichText(
                text: TextSpan(
                    text: "Cateory -",
                    style: GoogleFonts.roboto(fontWeight: FontWeight.w800, fontSize: 12, color: AppColors.primaryColorLight),
                    children: [
                      TextSpan(
                        text: "ews & media website",
                        style: GoogleFonts.roboto(fontWeight: FontWeight.w400, fontSize: 12, color: AppColors.primaryColorLight),
                      )
                    ]),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Row(
            children: [
              Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                  color: AppColors.primaryColorLight,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(
                width: 2,
              ),
              Text(
                "abs@google.com",
                style: GoogleFonts.roboto(fontWeight: FontWeight.w400, fontSize: 12, color: AppColors.primaryColorLight),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Row(
            children: [
              Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                  color: AppColors.primaryColorLight,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(
                width: 2,
              ),
              Text(
                "abs.com.bd",
                style: GoogleFonts.roboto(fontWeight: FontWeight.w400, fontSize: 12, color: AppColors.primaryColorLight),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Row(
            children: [
              Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                  color: AppColors.primaryColorLight,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(
                width: 2,
              ),
              Text(
                "+880170000000",
                style: GoogleFonts.roboto(fontWeight: FontWeight.w400, fontSize: 12, color: AppColors.primaryColorLight),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Row(
            children: [
              Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                  color: AppColors.primaryColorLight,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(
                width: 2,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "151/7, Good Luck Center (7th & 8th)1205 Dhaka, Dhaka Division, Bangladesh",
                      style: GoogleFonts.roboto(fontWeight: FontWeight.w400, fontSize: 12, color: AppColors.primaryColorLight),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Row(
            children: [
              Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                  color: AppColors.primaryColorLight,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(
                width: 2,
              ),
              Text(
                "Get Directions",
                style: GoogleFonts.roboto(fontWeight: FontWeight.w700, fontSize: 15, color: AppColors.primaryColorLight),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Divider(
          thickness: 1.8,
          color: Color(0xffE4E6EB),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 18,
          ),
          child: Text(
            "Descriptions",
            style: GoogleFonts.roboto(fontWeight: FontWeight.w700, fontSize: 15, color: AppColors.primaryColorLight),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Column(
            children: [
              SizedBox(
                width: 2,
              ),
              Text(
                "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to the visual form of a commonly  to.used to the visual form of a commonly  to. placeholder text commonly used to the visual form of a commonly  to.used to thezxxzc...View More",
                style: GoogleFonts.roboto(fontWeight: FontWeight.w400, fontSize: 12, color: AppColors.primaryColorLight),
              ),
            ],
          ),
        ),
        Divider(
          thickness: 1.8,
          color: Color(0xffE4E6EB),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 18,
          ),
          child: Text(
            "Page Info",
            style: GoogleFonts.roboto(fontWeight: FontWeight.w700, fontSize: 15, color: AppColors.primaryColorLight),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Row(
            children: [
              Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                  color: AppColors.primaryColorLight,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Image.asset(
                    "assets/background/category.png",
                  ),
                ),
              ),
              SizedBox(
                width: 2,
              ),
              RichText(
                text: TextSpan(
                    text: "Admin -",
                    style: GoogleFonts.roboto(fontWeight: FontWeight.w800, fontSize: 12, color: AppColors.primaryColorLight),
                    children: [
                      TextSpan(
                        text: "Rafatul Islam",
                        style: GoogleFonts.roboto(fontWeight: FontWeight.w400, fontSize: 12, color: AppColors.primaryColorLight),
                      )
                    ]),
              )
            ],
          ),
        ),
        SizedBox(
          height: 7,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Row(
            children: [
              Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                  color: AppColors.primaryColorLight,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Image.asset(
                    "assets/background/category.png",
                  ),
                ),
              ),
              SizedBox(
                width: 2,
              ),
              RichText(
                text: TextSpan(
                    text: "Created Date -",
                    style: GoogleFonts.roboto(fontWeight: FontWeight.w800, fontSize: 12, color: AppColors.primaryColorLight),
                    children: [
                      TextSpan(
                        text: "15 March 2022",
                        style: GoogleFonts.roboto(fontWeight: FontWeight.w400, fontSize: 12, color: AppColors.primaryColorLight),
                      )
                    ]),
              )
            ],
          ),
        ),
      ],
    );
  }
}
