import 'package:als_frontend/screens/group/widget/invite_group_card.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../page/widget/page_app_bar.dart';

class InvitesGroup extends StatelessWidget {
  const InvitesGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PageAppBar(title: 'Invites Group'),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text('You have been invited to join these groups.',style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: AppColors.primaryColorLight),),
              ),
            ),
            const SizedBox(height: 10,),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2
                ),
                itemCount: 10,
                itemBuilder: (_,index){
                  return InviteGroupCard();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
