
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter/material.dart';

class HelpDeskWidget extends StatelessWidget {
  const HelpDeskWidget({Key? key,
  required this.icon,
  required this.textname,
  required this.discription,
  required this.color,
  required this.goingScreen,


  }) : super(key: key);
 final IconData icon;
  final String textname;
  final String discription;
  final Color color;
  final VoidCallback goingScreen;


  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: goingScreen,
      child: Container(
        height: height*0.09,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(.2),
                  blurRadius: 10.0,
                  spreadRadius: 3.0,
                  offset: const Offset(0.0, 0.0))
            ],
            borderRadius: BorderRadius.circular(8)
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  height: height*0.2,
                  width: width*0.15,
                  decoration: BoxDecoration(
                      color: const Color(0xffF1B8BC),
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Center(child: Icon(icon,color: Colors.pinkAccent,)
              ),
            ),),
           SizedBox(width: width*0.03,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: height*0.02,),
                Text(textname,style: latoStyle600SemiBold.copyWith(color:const Color(0xff2E4266),fontSize: 20 ),),
                Text(discription,style: latoStyle500Medium.copyWith(color:const Color(0xff9EA8B9),fontSize: 10 ),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
