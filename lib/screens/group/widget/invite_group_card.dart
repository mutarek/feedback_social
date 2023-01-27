import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InviteGroupCard extends StatelessWidget {
  String groupImage;
  String groupName;
  String extraText;
  String inviteBy;
  InviteGroupCard(this.groupImage,this.groupName,this.extraText,this.inviteBy,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Card(
      elevation: 1,
      child: SizedBox(
        height: 130,
        width: 194,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              child: customNetworkImage(groupImage,height: 84,boxFit: BoxFit.fitWidth)

            ),
            const SizedBox(height: 5,),
            Row(
              children: [
                const SizedBox(width: 5,),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(groupName,style: robotoStyle700Bold.copyWith(fontSize: 18,color: AppColors.primaryColorLight))),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 5,),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(extraText,style: robotoStyle700Bold.copyWith(fontSize: 10,color: AppColors.primaryColorLight))),
              ],
            ),
            const SizedBox(height: 5,),
            Row(
              children: [
                const SizedBox(width: 5,),
                const CircleAvatar(
                  radius: 9,
                  backgroundColor: Color(0xff8600DE),
                ),
                const SizedBox(width: 5,),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(inviteBy,style: GoogleFonts.roboto(fontWeight: FontWeight.w700, fontSize: 10, color: AppColors.primaryColorLight),)),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
              child: Row(
                children: [
                  Container(
                    height: 19,
                    width: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xffE7F3FF)
                    ),
                    child: Center(
                      child: Text('Join Group',style: GoogleFonts.roboto(fontWeight: FontWeight.w700, fontSize: 10, color: AppColors.primaryColorLight)),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 19,
                    width: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xffE7F3FF)
                    ),
                    child: const Center(
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
