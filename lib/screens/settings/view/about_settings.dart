

import 'package:als_frontend/data/model/response/user_profile_model.dart';
import 'package:als_frontend/screens/profile/edit_profile_screen.dart';
import 'package:als_frontend/screens/settings/view/block_list.dart';
import 'package:als_frontend/screens/settings/view/email_update.dart';
import 'package:als_frontend/screens/settings/view/password_update.dart';
import 'package:als_frontend/screens/settings/widget/Settings_widget.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';



class AboutSettings extends StatelessWidget {
  const AboutSettings({
    Key? key,
    required this.name,
    required this.image,
    required this.userprofileData
  }) : super(key: key);
  final UserProfileModel userprofileData;
final String image;
final String name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      body: SafeArea(
        child: Padding(
          padding:  const EdgeInsets.only(left: 30,right: 30),
          child: SingleChildScrollView(
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
                Text("About",style:GoogleFonts.lato(fontSize: 40,fontWeight: FontWeight.w800),),
                const SizedBox(height: 30,),
                Center(
                  child: CircleAvatar(
                    radius: 62,
                    backgroundColor: Colors.green,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(image,),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Center(child: Text(name,style:GoogleFonts.lato(fontSize: 20,fontWeight: FontWeight.w800),)),
                const SizedBox(height: 30,),
                Row(

                  children: [
                    const CircleAvatar(
                      radius: 25,
                      backgroundColor: Color(0xffd7f2d3),
                      child: Center(child: Icon(FontAwesomeIcons.person,color: Colors.green,)),
                    ),
                    const SizedBox(width: 10,),
                   Column(crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text("Personal Information",style: GoogleFonts.lato(fontSize: 16)),
                       const SizedBox(height: 3,),
                       Text("Name,gender,profile details",style: GoogleFonts.lato(color: const Color(0xff9C9EA2)),),
                     ],
                   ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: InkWell(
                        onTap: (){

                          Get.to(EditProfile(userprofileData: userprofileData,));
                        },
                        child: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                              color: const Color(0xffF3F3F6),
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: const Icon(FontAwesomeIcons.angleRight,size: 15,),
                        ),
                      ),
                    )
                  ],
                ),


                const SizedBox(height: 30,),
                Row(

                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: const Color(0xffd7f2d3),
                      child: Center(child: SvgPicture.asset('assets/svg/password.svg',height: 25,)),
                    ),
                    const SizedBox(width: 10,),
                   Column(crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text("Password security",style: GoogleFonts.lato(fontSize: 16)),
                       const SizedBox(height: 3,),
                       Text("change password",style: GoogleFonts.lato(color: const Color(0xff9C9EA2)),),
                     ],
                   ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: InkWell(
                        onTap: (){
                      Get.to(const PasswordUpdateSettings());
                        },
                        child: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                              color: const Color(0xffF3F3F6),
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: const Icon(FontAwesomeIcons.angleRight,size: 15,),
                        ),
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 30,),
                Row(

                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: const Color(0xfff1d3f2),
                      child: Center(child: SvgPicture.asset('assets/svg/mail.svg',height: 25,color: Colors.pink,)),
                    ),
                    const SizedBox(width: 10,),
                   Column(crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text("Email Security",style: GoogleFonts.lato(fontSize: 16)),
                       const SizedBox(height: 3,),
                       Text("Change Email",style: GoogleFonts.lato(color: const Color(0xff9C9EA2)),),
                     ],
                   ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: InkWell(
                        onTap: (){
                          Get.to(const EmailUpdateSettings());
                        },
                        child: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                              color: const Color(0xffF3F3F6),
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: const Icon(FontAwesomeIcons.angleRight,size: 15,),
                        ),
                      ),
                    )
                  ],
                ),



                const SizedBox(height: 30,),
                Row(

                  children: [
                    const CircleAvatar(
                      radius: 25,
                      backgroundColor: Color(0xfff1d3f2),
                      child: Center(child: Icon(FontAwesomeIcons.ban,color: Colors.pinkAccent,)),
                    ),
                    const SizedBox(width: 10,),
                   Column(crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text("Block list",style: GoogleFonts.lato(fontSize: 16)),
                       const SizedBox(height: 3,),
                       Text("See your block list",style: GoogleFonts.lato(color: const Color(0xff9C9EA2)),),
                     ],
                   ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: InkWell(
                        onTap: (){
                          Get.to(const BlockListUpdateSettings());
                        },
                        child: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                              color: const Color(0xffF3F3F6),
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: const Icon(FontAwesomeIcons.angleRight,size: 15,),
                        ),
                      ),
                    )
                  ],
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
