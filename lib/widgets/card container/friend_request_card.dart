
 import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FrindRequestCard extends StatelessWidget {
   FrindRequestCard({
     required this.ontap,
     this.confirmText = "Confirm",
     required this.ontapconfrim,
     this.deleteText = "Delete",
     required this.ontapdelete,
     required this.picture,
     required this.name,
     Key? key}) : super(key: key);
   VoidCallback ontap;
   VoidCallback ontapconfrim;
   VoidCallback ontapdelete;
   String picture;
   String name;
   String confirmText;
   String deleteText;

   @override
   Widget build(BuildContext context) {
     final double height=MediaQuery.of(context).size.height;
     final  double width=MediaQuery.of(context).size.width;
     return Padding(
       padding: EdgeInsets.only(left: width*0.03,right:width*0.03,top: height*0.012),
       child: InkWell(onTap: ontap,
         child: Container(
           height: height*0.13,
           width: width,

           decoration: BoxDecoration(
             color: const Color(0xffFFFFFF),
             borderRadius: BorderRadius.circular(10),
           ),
           child: Row(
             children: [
               Padding(
                 padding: EdgeInsets.only(top: 12,bottom: 13,left: width*0.03),
                 child: Container(
                   height: height*0.1,
                   width: width*0.19,
                   decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(10),
                       image: DecorationImage(
                           image: NetworkImage(picture),
                           fit: BoxFit.fitHeight
                       ),
                   ),
                 ),
               ),
               Padding(
                 padding:  EdgeInsets.only(top: height*0.02,left: width*0.06,right: width*0.06),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(name,style:
                     TextStyle(fontWeight: FontWeight.bold,fontSize: height*0.02),
                     ),
                     
                     Padding(
                       padding: EdgeInsets.only(top: height*0.012),
                       child: Row(
                         children: [
                           InkWell(onTap: ontapconfrim,
                             child: Container(
                               height: height*0.035,
                               width: width*0.2,
                               decoration: BoxDecoration(
                                   color: const Color(0xff06113E),
                                   borderRadius: BorderRadius.circular(15)
                               ),
                               child: Center(child: Text(confirmText,style: const TextStyle(color: Colors.white),)),
                             ),
                           ),
                           SizedBox(width: width*0.04,),
                           InkWell(onTap: ontapdelete,
                             child: Container(
                               height: height*0.035,
                               width: width*0.2,
                               decoration: BoxDecoration(
                                   color: const Color(0xffEEEEEE),
                                   borderRadius: BorderRadius.circular(15)
                               ),
                               child: Center(child: Text(deleteText,style: const TextStyle(color: Color(0xff555555)),)),
                             ),
                           )
                         ],
                       ),
                     )
                   ],
                 ),
               )
             ],
           ),
         ),
       ),
     );
   }
 }

