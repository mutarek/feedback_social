import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';

class OtherSettings extends StatelessWidget {
  const OtherSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(

      backgroundColor: AppColors.scaffold,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),
              InkWell(
                  onTap: (){
                    Get.back();
                  },
                  child: const Icon(FontAwesomeIcons.angleLeft,size: 20,)),
              const SizedBox(height: 40,),

              Text("Other",style:GoogleFonts.lato(fontSize: 30,fontWeight: FontWeight.w800),),
              const SizedBox(height: 40,),
          Material(
            elevation: 8,
            shadowColor:Color(0xff69D2FA),
            borderRadius: BorderRadius.circular(20),
            child: Container(

              width: width,
              decoration:  BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Color(0xff2D87EB),
                      Color(0xff69D2FA),
                    ],
                  )
              ),
              child: Padding(
                padding:  EdgeInsets.only(left: 30,right: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Text("Who can tag you ?",style: latoStyle500Medium.copyWith(color: Colors.white,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Text("* Your friend",style:latoStyle400Regular.copyWith(color: Colors.white,),),
                        Spacer(),
                        CupertinoSwitch(
                          trackColor: Color(0xff69D2FA), // **INACTIVE STATE COLOR**
                          activeColor:  Color(0xff2D87EB),
                          value:true,
                          onChanged: (value){},
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text("* Your follower",style:latoStyle400Regular.copyWith(color: Colors.white,),),
                        Spacer(),
                        CupertinoSwitch(
                          trackColor: Color(0xff69D2FA), // **INACTIVE STATE COLOR**
                          activeColor:  Color(0xff2D87EB),
                          value:true,
                          onChanged: (value){},
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text("* Your following",style:latoStyle400Regular.copyWith(color: Colors.white,),),
                        Spacer(),
                        CupertinoSwitch(
                          trackColor: Color(0xff69D2FA), // **INACTIVE STATE COLOR**
                          activeColor:  Color(0xff2D87EB),
                          value:true,
                          onChanged: (value){},
                        ),
                      ],
                    ),
                    SizedBox(height: 10,)
                  ],

                ),
              ),
            ),
          ),
              SizedBox(height: 20,),
              Material(
                elevation: 8,
                shadowColor:Color(0xff69D2FA),
                borderRadius: BorderRadius.circular(20),
                child: Container(

                  width: width,
                  decoration:  BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          Color(0xff57C84D),
                          Color(0xffC5E8B7),
                        ],
                      )
                  ),
                  child: Padding(
                    padding:  EdgeInsets.only(left: 30,right: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10,),
                        Text("Who can share Your post ?",style: latoStyle500Medium.copyWith(color: Colors.white,fontWeight: FontWeight.bold),),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Text("* Your friend",style:latoStyle400Regular.copyWith(color: Colors.white,),),
                            Spacer(),
                            CupertinoSwitch(
                              trackColor: Color(0xffC5E8B7),// **INACTIVE STATE COLOR**
                              activeColor:  Color(0xff57C84D),
                              value:true,
                              onChanged: (value){},
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("* Your follower",style:latoStyle400Regular.copyWith(color: Colors.white,),),
                            Spacer(),
                            CupertinoSwitch(
                              trackColor: Color(0xffC5E8B7),// **INACTIVE STATE COLOR**
                              activeColor:  Color(0xff57C84D),
                              value:true,
                              onChanged: (value){},
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("* Your following",style:latoStyle400Regular.copyWith(color: Colors.white,),),
                            Spacer(),
                            CupertinoSwitch(
                              trackColor: Color(0xffC5E8B7),// **INACTIVE STATE COLOR**
                              activeColor:  Color(0xff57C84D),
                              value:true,
                              onChanged: (value){},
                            ),
                          ],
                        ),
                        SizedBox(height: 10,)
                      ],

                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Material(
                elevation: 8,
                shadowColor:Color(0xff69D2FA),
                borderRadius: BorderRadius.circular(20),
                child: Container(

                  width: width,
                  decoration:  BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [

                          Color(0xffED30CD),
                          Color(0xffFA86F2),
                        ],
                      )
                  ),
                  child: Padding(
                    padding:  EdgeInsets.only(left: 30,right: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10,),
                        Text("Who can direct massage you ?",style: latoStyle500Medium.copyWith(color: Colors.white,fontWeight: FontWeight.bold),),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Text("* Your friend",style:latoStyle400Regular.copyWith(color: Colors.white,),),
                            Spacer(),
                            CupertinoSwitch(
                              trackColor:   Color(0xffFA86F2),// **INACTIVE STATE COLOR**
                              activeColor:  Color(0xffED30CD),
                              value:true,
                              onChanged: (value){},
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("* Your follower",style:latoStyle400Regular.copyWith(color: Colors.white,),),
                            Spacer(),
                            CupertinoSwitch(
                              trackColor:   Color(0xffFA86F2),// **INACTIVE STATE COLOR**
                              activeColor:  Color(0xffED30CD),
                              value:true,
                              onChanged: (value){},
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("* Your following",style:latoStyle400Regular.copyWith(color: Colors.white,),),
                            Spacer(),
                            CupertinoSwitch(
                              trackColor:   Color(0xffFA86F2),// **INACTIVE STATE COLOR**
                              activeColor:  Color(0xffED30CD),
                              value:true,
                              onChanged: (value){},
                            ),
                          ],
                        ),
                        SizedBox(height: 10,)
                      ],

                    ),
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
