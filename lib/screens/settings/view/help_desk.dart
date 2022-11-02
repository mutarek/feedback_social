
import 'package:als_frontend/screens/settings/widget/help_desk_widget.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                 child: Center(child: IconButton(onPressed: (){}, icon: Icon(FontAwesomeIcons.arrowLeft,size: 15,)))
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
                SizedBox(height: height*0.03,),
                HelpDeskWidget(icon: FontAwesomeIcons.message, textname: 'Chat',
                  discription: 'Discribe your chating problem',
                  color: Color(0xffF1B8BC), goingScreen: () { },),
                SizedBox(height: height*0.02,),
                HelpDeskWidget(icon: FontAwesomeIcons.message, textname: 'Chat',
                  discription: 'Discribe your chating problem',
                  color: Color(0xffF1B8BC), goingScreen: () { },),
                SizedBox(height: height*0.02,),
                HelpDeskWidget(icon: FontAwesomeIcons.message, textname: 'Chat',
                  discription: 'Discribe your chating problem',
                  color: Color(0xffF1B8BC), goingScreen: () { },),
                SizedBox(height: height*0.02,),
                HelpDeskWidget(icon: FontAwesomeIcons.message, textname: 'Chat',
                  discription: 'Discribe your chating problem',
                  color: Color(0xffF1B8BC), goingScreen: () { },),
                SizedBox(height: height*0.02,),
                HelpDeskWidget(icon: FontAwesomeIcons.message, textname: 'Chat',
                  discription: 'Discribe your chating problem',
                  color: Color(0xffF1B8BC), goingScreen: () { },),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
