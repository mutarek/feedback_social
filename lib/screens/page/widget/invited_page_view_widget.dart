import 'package:flutter_svg/svg.dart';

import '../../../data/model/response/page/page_model2.dart';
import '../../../util/image.dart';
import '../../../util/theme/app_colors.dart';
import '../../../util/theme/text.styles.dart';
import '../../../widgets/network_image.dart';
import '../../video/widget/new_video_widgets.dart';

class InvitedPageViewWidget extends StatelessWidget {
  const InvitedPageViewWidget({required this.invitedPageModel, this.onItemTap, this.onAcceptTap, this.onCancelTap, Key? key})
      : super(key: key);
  final PageModel2 invitedPageModel;
  final GestureTapCallback? onItemTap;
  final GestureTapCallback? onAcceptTap;
  final GestureTapCallback? onCancelTap;

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
          circularImage(invitedPageModel.page!.avatar!, 40, 40),
          const SizedBox(width: 15),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(invitedPageModel.page!.name!, style: robotoStyle700Bold.copyWith(fontSize: 16)),
              const SizedBox(height: 5),
              Row(
                children: [
                  SvgPicture.asset(ImagesModel.likeIconsSvg, width: 14, height: 14, color: Colors.black,),
                  const SizedBox(width: 2),
                  InkWell(
                      onTap: onAcceptTap,
                      child: Text('Like', style: robotoStyle500Medium.copyWith(fontSize: 10))),
                  const SizedBox(width: 40),
                  SvgPicture.asset(ImagesModel.declinedIcons, width: 14, height: 14, color: Colors.black,),
                  const SizedBox(width: 2),
                  InkWell(
                    onTap: onCancelTap,
                      child: Text("Declined", style: robotoStyle500Medium.copyWith(fontSize: 10))),
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
    );
  }
}
