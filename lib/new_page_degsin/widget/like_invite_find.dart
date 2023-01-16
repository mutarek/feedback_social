
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter/material.dart';

class LikeInviteFindWidget extends StatelessWidget {
  const LikeInviteFindWidget({Key? key,this.icon,this.name,this.extraArguments}) : super(key: key);
final IconData? icon;
final String? name;
final String? extraArguments;

  @override
  Widget build(BuildContext context) {
    return Row(

      children: [
        CircleAvatar(
          backgroundColor: Color(0xffDEE0E6),
          radius: 23,
          child: Icon(icon,color: AppColors.primaryColorLight,),
        ),

        SizedBox(width: 15,),
        Column( mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name!, style: latoStyle600SemiBold.copyWith(color: AppColors.primaryColorLight,fontSize: 17),),
            extraArguments==null?SizedBox.shrink():Text(extraArguments!, style: latoStyle300Light.copyWith(
                color: AppColors.primaryColorLight, fontSize: 10),)
          ],
        )
      ],
    );
  }
}
