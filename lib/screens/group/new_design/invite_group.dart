import 'package:als_frontend/screens/group/widget/invite_group_card.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter/material.dart';

import '../../page/widget/page_app_bar.dart';

class InvitesGroup extends StatelessWidget {
  const InvitesGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PageAppBar(title: 'Invites Group'),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text('You have been invited to join these groups.',style: robotoStyle700Bold.copyWith(fontSize: 12,color: AppColors.primaryColorLight)),
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
                  return InviteGroupCard("https://res.cloudinary.com/dhakacity/image/upload/c_scale,w_648,h_364/f_auto,q_auto/v1670167720/couple-resort-in-sajek-valley.jpg",
                  "City Travel","570K Members - 10+ Post a Day","Mehedi invited you");
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
