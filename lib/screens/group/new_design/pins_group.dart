import 'package:als_frontend/screens/group/widget/group_view_card.dart';
import 'package:als_frontend/screens/group/widget/invite_group_card.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../page/widget/page_app_bar.dart';

class PinsGroup extends StatelessWidget {
  const PinsGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PageAppBar(title: 'Pins Group'),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text('Your pinned groups.',style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: AppColors.primaryColorLight),),
                ),
              ),
              const SizedBox(height: 10,),
          SizedBox(
            height: 140,
            child: Expanded(
              child: ListView.builder(
                itemCount: 2,
                itemBuilder: (_,index){
                  return  Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.only(top: 6, bottom: 6),
                    decoration: BoxDecoration(
                        color: const Color(0xffFAFAFA),
                        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(.2), blurRadius: 10.0, spreadRadius: 3.0, offset: const Offset(0.0, 0.0))],
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 10,),
                        ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Center(child: Image.asset("assets/background/profile_placeholder.jpg",height: 36,width: 36,))),
                        const SizedBox(width: 15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("City Travels", style: robotoStyle700Bold.copyWith(fontSize: 16)),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                SvgPicture.asset("assets/svg/last_minute_icon.svg", width: 14, height: 14),
                                const SizedBox(width: 2),
                                Text("Last active 50 minutes ago", style: robotoStyle500Medium.copyWith(fontSize: 9)),
                              ],
                            )
                          ],
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: (){

                          },
                          child:  SvgPicture.asset("assets/svg/pins_group_icon.svg"),
                        ),
                        SizedBox(width: 10,)
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
              const SizedBox(height: 10,),
              Divider(
                height: 2,
                color: Color(0xffE4E6EB),
              ),
              const SizedBox(height: 5,),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text('Pins',style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: AppColors.primaryColorLight),),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text('Pin your favorite group to access quick.',style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: AppColors.primaryColorLight),),
                ),
              ),
              const SizedBox(height: 5,),
              SizedBox(
                height: 700,
                child: Expanded(
                  child: ListView.builder(
                    itemCount: 15,
                    itemBuilder: (_,index){
                      return  Container(
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.only(top: 6, bottom: 6),
                        decoration: BoxDecoration(
                            color: const Color(0xffFAFAFA),
                            boxShadow: [BoxShadow(color: Colors.grey.withOpacity(.2), blurRadius: 10.0, spreadRadius: 3.0, offset: const Offset(0.0, 0.0))],
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(width: 10,),
                            ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Center(child: Image.asset("assets/background/profile_placeholder.jpg",height: 36,width: 36,))),
                            const SizedBox(width: 15),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Flutter Bangladesh", style: robotoStyle700Bold.copyWith(fontSize: 16)),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    SvgPicture.asset("assets/svg/last_minute_icon.svg", width: 14, height: 14),
                                    const SizedBox(width: 2),
                                    Text("Last active 50 minutes ago", style: robotoStyle500Medium.copyWith(fontSize: 9)),
                                  ],
                                )
                              ],
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: (){

                              },
                              child:  SvgPicture.asset("assets/svg/pins_group_icon.svg"),
                            ),
                            SizedBox(width: 10,)
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
