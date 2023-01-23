import 'package:als_frontend/screens/video/widget/new_video_widgets.dart';
import 'package:als_frontend/util/image.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NewPageDetailsHeaderWidget extends StatelessWidget {
  const NewPageDetailsHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SafeArea(
          child: Stack(
            children: [
              Container(
                height: 215,
                color: Colors.white,
              ),
              //TODO cover Photo.........
              Container(
                height: 170,
                decoration: const BoxDecoration(
                    color: Colors.black45, borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10))),
              ),
              Positioned(
                top: 115,
                left: 18,
                child: Container(
                  height: 90,
                  width: 90,
                  color: Colors.blue,
                ),
              )
            ],
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(left: 18),
            child: Text("Abstract Graphics Studio", style: robotoStyle500Medium.copyWith(fontSize: 22))),
        const SizedBox(height: 2),
        Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Row(
            children: [
              Container(
                height: 15,
                width: 15,
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primaryColorLight),
                child: SvgPicture.asset(ImagesModel.followersIcons, color: Colors.white, width: 9, height: 9),
              ),
              const SizedBox(width: 2),
              Text("Followers:", style: robotoStyle400Regular.copyWith(fontSize: 11, color: AppColors.primaryColorLight)),
              Text(" 5M", style: robotoStyle700Bold.copyWith(fontSize: 11, color: AppColors.primaryColorLight)),
              const SizedBox(width: 10),
              Container(
                height: 15,
                width: 15,
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primaryColorLight),
                child: SvgPicture.asset(ImagesModel.followingIcons, color: Colors.white, width: 9, height: 9),
              ),
              const SizedBox(width: 2),
              Text("Following:", style: robotoStyle400Regular.copyWith(fontSize: 11, color: AppColors.primaryColorLight)),
              Text(" 20", style: robotoStyle700Bold.copyWith(fontSize: 11, color: AppColors.primaryColorLight)),
            ],
          ),
        ),
        const SizedBox(height: 13),
      ],
    );
  }
}
