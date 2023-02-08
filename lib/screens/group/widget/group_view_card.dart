import 'package:als_frontend/screens/video/widget/new_video_widgets.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GroupViewCard extends StatelessWidget {
  const GroupViewCard({
    Key? key,
    required this.ontap,
    required this.name,
    required this.photo,
    required this.message,
  }) : super(key: key);
  final VoidCallback ontap;
  final String name;
  final String message;
  final String  photo;

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
          const SizedBox(width: 10,),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
               child: Center(child: circularImage(photo, 36, 36))),
          const SizedBox(width: 15),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: robotoStyle700Bold.copyWith(fontSize: 16)),
              const SizedBox(height: 5),
              Row(
                children: [
                  SvgPicture.asset("assets/svg/last_minute_icon.svg", width: 14, height: 14),
                  const SizedBox(width: 2),
                  Text(message, style: robotoStyle500Medium.copyWith(fontSize: 9)),
                ],
              )
            ],
          ),
          const Spacer(),
          InkWell(
            onTap: ontap,
            child: const CircleAvatar(radius: 15, backgroundColor: Color(0xffE4E6EB), child: Icon(Icons.play_circle, color: colorText)),
          ),
        ],
      ),
    );
  }
}
