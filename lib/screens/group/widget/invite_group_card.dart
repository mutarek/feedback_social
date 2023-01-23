import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InviteGroupCard extends StatelessWidget {
  const InviteGroupCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Card(
      elevation: 1,
      child: Container(
        height: 130,
        width: 194,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              child: Image.network('https://wander-lush.org/wp-content/uploads/2022/03/Beautiful-places-in-Bangladesh-WMC-hero.jpg',
                height: 84,
                fit: BoxFit.fitWidth,width: double.infinity,),
            ),
            const SizedBox(height: 5,),
            Row(
              children: [
                const SizedBox(width: 5,),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text('City Travels',style: GoogleFonts.roboto(fontWeight: FontWeight.w700, fontSize: 18, color: AppColors.primaryColorLight),)),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 5,),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text('570K Members - 10+ Post a Day',style: GoogleFonts.roboto(fontWeight: FontWeight.w700, fontSize: 10, color: AppColors.primaryColorLight),)),
              ],
            ),
            const SizedBox(height: 5,),
            Row(
              children: [
                const SizedBox(width: 5,),
                CircleAvatar(
                  radius: 9,
                  backgroundColor: Color(0xff8600DE),
                ),
                const SizedBox(width: 5,),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Mehedi invited you',style: GoogleFonts.roboto(fontWeight: FontWeight.w700, fontSize: 10, color: AppColors.primaryColorLight),)),
              ],
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
              child: Row(
                children: [
                  Container(
                    height: 19,
                    width: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xffE7F3FF)
                    ),
                    child: Center(
                      child: Text('Join Group',style: GoogleFonts.roboto(fontWeight: FontWeight.w700, fontSize: 10, color: AppColors.primaryColorLight)),
                    ),
                  ),
                  Spacer(),
                  Container(
                    height: 19,
                    width: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xffE7F3FF)
                    ),
                    child: Center(
                      child: Icon(Icons.more_horiz,size: 15,),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
