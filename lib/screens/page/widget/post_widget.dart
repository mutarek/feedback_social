import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PagePostView extends StatelessWidget {
  const PagePostView({Key? key,required this.dicription,required this.value,required this.showDescription}) : super(key: key);
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
        SizedBox(
          height: 5,
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Text(
            "Details",
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w700, fontSize: 15, color: AppColors.primaryColorLight),
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
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                        color: AppColors.primaryColorLight),
                    children: [
                      TextSpan(
                        text: "ews & media website",
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: AppColors.primaryColorLight),
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
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w400, fontSize: 12, color: AppColors.primaryColorLight),
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
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w400, fontSize: 12, color: AppColors.primaryColorLight),
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
          padding: const EdgeInsets.only(left: 18,),
          child: Text(
            "Posts",
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w700, fontSize: 12, color: AppColors.primaryColorLight),
          ),
        ),
SizedBox(height: 10,),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.only(top: 0),
            physics: NeverScrollableScrollPhysics(),
            itemCount: 1,
              itemBuilder: (context, index) {
              return Column(
                children: [

                  Padding(
                    padding: const EdgeInsets.only(left: 18,right: 18),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Container(
                        height: 36,
                        width:36,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primaryColorLight),
                          shape: BoxShape.circle,
                          image: DecorationImage(image: AssetImage("assets/background/help.png"),fit: BoxFit.cover)
                        ),
                      ),
                      SizedBox(width: 8,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Abstract Graphics Studio",
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w700, fontSize: 13.5, color: AppColors.primaryColorLight),),
                          Row(
                            children: [
                              Icon(Icons.fact_check_outlined,color: AppColors.primaryColorLight,size: 12,),
                              SizedBox(width: 2,),
                              Text("2 Hours  -",
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w500, fontSize: 7, color: AppColors.primaryColorLight),),
                              SizedBox(width: 2,),
                              Icon(Icons.circle,color: AppColors.primaryColorLight,size: 12,)
                            ],
                          )
                        ],
                      ),
                        Spacer(),
                        Container(
                          height: 24,
                          width: 30,
                          decoration: BoxDecoration(
                            color: Color(0xffE4E6EB),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(child: Icon(Icons.more_horiz)),
                        ),

                      ],
                    ),
                  ),
                 SizedBox(height: 10,),
                 Padding(
                   padding: const EdgeInsets.only(left: 18,right: 18),
                   child: RichText(
                       textAlign: TextAlign.start,
                       text: TextSpan(
                     text: value ? (firstHalf + "...") : (firstHalf + secondHalf),
                       style: GoogleFonts.roboto(
                           fontWeight: FontWeight.w400, fontSize: 10, color: AppColors.primaryColorLight),
                     children: [

                       TextSpan(
                         text: value ? "show more" : "show less",
                         style: GoogleFonts.roboto(
                             fontWeight: FontWeight.w600, fontSize: 13, color: AppColors.primaryColorLight),
                       recognizer: TapGestureRecognizer()
                         ..onTap = showDescription,
                       )
                     ]

                   )),
                 ),
 Container(
   height:229 ,
   color: AppColors.imageBGColorLight,

 )

                ],
              );
              }),
        )
      ],
    );
  }
}
