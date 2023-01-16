

import 'package:als_frontend/screens/video/widget/new_video_widgets.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';

class PageviewCard extends StatelessWidget {
  const PageviewCard({Key? key,
    required this.ontap,
    required this.name,
    required this.icon,
    required this.message,
  }) : super(key: key);
  final VoidCallback ontap;
  final String name;
  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xffEDEFF2),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: Icon(
                icon,
                color: AppColors.primaryColorLight,
              ),
            ),
            SizedBox(width: 15,),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: latoStyle600SemiBold.copyWith(color: AppColors.primaryColorLight),
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Icon(Icons.message,size: 13,),
                    SizedBox(width: 2,),
                    Text(
                      message,
                      style: latoStyle300Light.copyWith(
                          color: AppColors.primaryColorLight, fontSize: 9),
                    ),
                    SizedBox(width: 20,),
                    Icon(Icons.notifications_active,size: 13,),
                    SizedBox(width: 2,),
                    Text(
                      "Notification",
                      style: latoStyle300Light.copyWith(
                          color: AppColors.primaryColorLight, fontSize: 9),
                    ),
                  ],
                )
              ],
            ),
   Spacer(),
            InkWell(
              onTap: ontap,
              child: CircleAvatar(
                radius: 15,
                backgroundColor: Color(0xffDEE0E6),
                child: Icon(Icons.more_horiz,color: Colors.black45,),
              ),
            )
          ],
        ),
      ),
    );
  }
}
