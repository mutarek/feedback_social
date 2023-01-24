import 'package:als_frontend/data/model/response/page/athour_pages_model.dart';
import 'package:als_frontend/screens/video/widget/new_video_widgets.dart';
import 'package:als_frontend/util/image.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PageViewWidget extends StatelessWidget {
  const PageViewWidget({required this.authorPageModel, this.onTap, Key? key}) : super(key: key);
  final AuthorPageModel authorPageModel;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(top: 6, bottom: 6),
        decoration: BoxDecoration(
            color: const Color(0xffFAFAFA),
            boxShadow: [BoxShadow(color: Colors.grey.withOpacity(.2), blurRadius: 10.0, spreadRadius: 3.0, offset: const Offset(0.0, 0.0))],
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            circularImage(authorPageModel.avatar!, 40, 40),
            const SizedBox(width: 15),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(authorPageModel.name!, style: robotoStyle700Bold.copyWith(fontSize: 16)),
                const SizedBox(height: 5),
                Row(
                  children: [
                    SvgPicture.asset(ImagesModel.messageIcons, width: 14, height: 14),
                    const SizedBox(width: 2),
                    Text('20 message', style: robotoStyle500Medium.copyWith(fontSize: 9)),
                    const SizedBox(width: 20),
                    SvgPicture.asset(ImagesModel.notificationIcons, width: 14, height: 14),
                    const SizedBox(width: 2),
                    Text("Notification", style: robotoStyle500Medium.copyWith(fontSize: 9)),
                  ],
                )
              ],
            ),
            const Spacer(),
            const CircleAvatar(radius: 15, backgroundColor: Color(0xffE4E6EB), child: Icon(Icons.more_horiz, color: colorText)),
            // ElevatedButton(
            //     onPressed: () {
            //       Helper.toScreen(AdminPageScreen());
            //     },
            //     child: Text("admin"))
          ],
        ),
      ),
    );
  }
}
