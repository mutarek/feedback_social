import 'package:als_frontend/provider/settings_provider.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EmailUpdateSettings extends StatelessWidget {
  const EmailUpdateSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController currentMailContorller = TextEditingController();
    TextEditingController newMailContorller = TextEditingController();
    TextEditingController currentPasswordContorller = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child:



        SingleChildScrollView(
          child: Padding(
            padding:  const EdgeInsets.only(left: 30,right: 30),
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
                Text("Email update",style:GoogleFonts.lato(fontSize: 40,fontWeight: FontWeight.w800),),
                const SizedBox(height: 30,),
                Text("Enter your current Email",style: latoStyle500Medium,),
                const SizedBox(height: 20,),
                CustomTextField(
                  controller: currentMailContorller,
                  fillColor: const Color(0xfff1d3f2),
                  //Color(0xffd7f2d3),
                  hintText: "input your old Email",

                ),
                const SizedBox(height: 20,),
                Text("Enter new Email",style: latoStyle500Medium,),
                const SizedBox(height: 20,),
                CustomTextField(
                  controller: newMailContorller,
                  fillColor: const Color(0xffd7f2d3),
                  hintText: "input your new Email",

                ),
                const SizedBox(height: 20,),
                Text("Enter current password",style: latoStyle500Medium,),
                const SizedBox(height: 20,),
                CustomTextField(
                  controller: currentPasswordContorller,
                  fillColor: const Color(0xffd7f2d3),
                  hintText: "input your password",

                ),
                const SizedBox(height: 20,),
                Center(
                  child: SizedBox(
                    height: 38,
                    width: 200,
                    child: Consumer<SettingsProvider>(

                      builder: (context, emailProvider,child) {
                        return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 7,
                                backgroundColor: Colors.green
                            ),
                            onPressed: (){
                             if(
                             currentMailContorller.text.isNotEmpty && newMailContorller.text.isNotEmpty
                                 &&currentPasswordContorller.text.isNotEmpty) {
                               emailProvider.emailUpdate(
                                   currentMailContorller.text,
                                   newMailContorller.text,
                                   currentPasswordContorller.text);}else{
                               print("error");
                             }
                            }, child: const Text("Update"));
                      }
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
