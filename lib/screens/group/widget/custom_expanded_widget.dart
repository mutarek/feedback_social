import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomExpandedWidget extends StatelessWidget {
  final String icon;
  final String widgetName;
  final String widgetSubText;
  final bool arrowValue;
  final GestureTapCallback? onTap;

  const CustomExpandedWidget(this.icon, this.widgetName, this.widgetSubText, this.arrowValue, this.onTap, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: const Color(0xffF0F2F5), borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: SvgPicture.asset(icon, height: 22, width: 25),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widgetName, style: robotoStyle700Bold.copyWith(fontSize: 20)),
                  const SizedBox(height: 2),
                  Text(widgetSubText, style: robotoStyle400Regular.copyWith(fontSize: 10))
                ],
              ),
            ),
            const SizedBox(width: 10),
            CircleAvatar(
              radius: 15,
              backgroundColor: AppColors.primaryColorLight,
              child: InkWell(
                  onTap: onTap,
                  child: arrowValue != true
                      ? const Icon(Icons.arrow_drop_down, color: Colors.white)
                      : const Icon(Icons.arrow_drop_up, color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}
