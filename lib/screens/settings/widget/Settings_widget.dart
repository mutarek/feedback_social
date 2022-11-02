
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({
    Key? key,
    required this.image,
    required this.name,
    this.subname,

    required this.goingScreen,



  }) : super(key: key);
   final String name;
   final String? subname;
   final String image;
   final VoidCallback goingScreen;


  @override
  Widget build(BuildContext context) {
    return  Row(

      children: [
        CircleAvatar(
          radius: 19,
          backgroundColor: Color(0xffE1F6FE),
          child: Center(child: SvgPicture.asset(image,height: 15,color: Colors.blue,)),
        ),
        SizedBox(width: 10,),
        Text(name,style: GoogleFonts.lato(fontSize: 16)),
        SizedBox(width: 80,),
        Text(subname!,style: GoogleFonts.lato(color: Color(0xff9C9EA2)),),
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: InkWell(
            onTap: goingScreen,
            child: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                  color: Color(0xffF3F3F6),
                  borderRadius: BorderRadius.circular(8)
              ),
              child: Icon(FontAwesomeIcons.angleRight,size: 15,),
            ),
          ),
        )
      ],
    );
  }
}
