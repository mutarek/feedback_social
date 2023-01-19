import 'package:als_frontend/screens/page/admin_page_screen.dart';
import 'package:als_frontend/screens/video/widget/new_video_widgets.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/image.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PageviewCard extends StatelessWidget {
  const PageviewCard({
    Key? key,
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
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.only(top: 6, bottom: 6),
      decoration: BoxDecoration(
          color: const Color(0xffFAFAFA),
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(.2), blurRadius: 10.0, spreadRadius: 3.0, offset: const Offset(0.0, 0.0))],
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(radius: 20, backgroundColor: Colors.white, child: Icon(icon, color: AppColors.primaryColorLight)),
          const SizedBox(width: 15),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: robotoStyle700Bold.copyWith(fontSize: 16)),
              const SizedBox(height: 5),
              Row(
                children: [
                  SvgPicture.asset(ImagesModel.messageIcons, width: 14, height: 14),
                  const SizedBox(width: 2),
                  Text(message, style: robotoStyle500Medium.copyWith(fontSize: 9)),
                  const SizedBox(width: 20),
                  SvgPicture.asset(ImagesModel.notificationIcons, width: 14, height: 14),
                  const SizedBox(width: 2),
                  Text("Notification", style: robotoStyle500Medium.copyWith(fontSize: 9)),
                ],
              )
            ],
          ),
          const Spacer(),
          InkWell(
            onTap: ontap,
            child: const CircleAvatar(radius: 15, backgroundColor: Color(0xffE4E6EB), child: Icon(Icons.more_horiz, color: colorText)),
          ),
          ElevatedButton(onPressed: (){
            Helper.toScreen(AdminPageScreen());
          }, child: Text("admin"))
        ],
      ),
    );
  }
}
