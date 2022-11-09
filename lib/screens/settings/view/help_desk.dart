
import 'package:als_frontend/screens/settings/widget/help_desk_widget.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HelpDesk extends StatelessWidget {
  const HelpDesk({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffF9F9FE),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 5,right: 5,top: 5),
          child: SingleChildScrollView(
            child: Column(
              children: [
 Container(
   height: height*0.4,
   decoration: BoxDecoration(
     color: Color(0xff8DC0FB),
     borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight:Radius.circular(10), )
   ),
   child: Column(
     children: [
       Padding(
         padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
         child: Row(
            
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Container(
                 height: height*0.05,
                 width: width*0.1,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(8),
                   color: Colors.white
                 ),
                 child: Center(child: IconButton(onPressed: (){
                   Get.back();
                 }, icon: Icon(FontAwesomeIcons.arrowLeft,size: 15,)))
               ),
               Text("Need help?",style: latoStyle600SemiBold.copyWith(color:Color(0xff2E4266) ),),
               Container(
                   height: height*0.05,
                   width: width*0.1,
                   decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(8),
                       color: Colors.white
                   ),
                   child: Center(child: IconButton(onPressed: (){}, icon: Icon(FontAwesomeIcons.barsStaggered,size: 15,)))
               ),

             ],
         ),
         
       ),
       Center(child: Text("Help Centre",style: latoStyle600SemiBold.copyWith(color:Color(0xff2E4266),fontSize: 40 ),)),
       Container(

         height: height*0.26,

             child: Image.asset("assets/background/help.png",fit: BoxFit.cover))

     ],
   ),

 ),
               Container(
                 width: width,
                 color: Colors.white,
                 child: Column(
                   children: [
                     SizedBox(height: height*0.02,),
                     Text("Tell us how we can help 👋",style: latoStyle600SemiBold.copyWith(color:Color(0xff2E4266),fontSize: 16 ),),
                     Text("our crew of superheroes are standing by\n for service & support",textAlign: TextAlign.center  ,style: latoStyle500Medium.copyWith(color:Color(0xffA4AEC0), ),),
                     SizedBox(height: height*0.05,),
                   ],
                 ),
               ),

                HelpDeskWidget(icon: FontAwesomeIcons.sms, textname: 'Chat',
                  discription: 'Start a conversation now',
                  color: Color(0xffF1B8BC), goingScreen: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text("Type your problem"),
                        content: CustomTextField(
                          fillColor: AppColors.scaffold,
                        ),
                        actions: [
                          SizedBox(
                              child: TextButton(onPressed: (){
                              }, child: Text("Add screen sort",style: latoStyle500Medium.copyWith(color: Colors.green,fontSize: 8,fontWeight: FontWeight.bold),))),
                         ElevatedButton(onPressed: (){}, child: Text("Cancel")),

                          ElevatedButton(onPressed: (){}, child: Text("Send")),
                        ],
                      ),
                    );
                  },),
                SizedBox(height: height*0.01,),
                HelpDeskWidget(icon: FontAwesomeIcons.question, textname: 'FAQs',
                  discription: "Find intelligent answer instantly",
                  color: Color(0xffF1B8BC), goingScreen: () { },),
                SizedBox(height: height*0.01,),
                HelpDeskWidget(icon: FontAwesomeIcons.solidPaperPlane, textname: 'Email',
                  discription: 'Get solution beamed to your inbox',
                  color: Color(0xffF1B8BC), goingScreen: () { },),
             
              ],
            ),
          ),
        ),
      ),
    );
  }
}
