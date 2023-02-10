import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/network_image.dart';
import 'package:flutter/material.dart';

class SuggestedGroupViewCard extends StatelessWidget {
  final String groupImage;
  final String groupName;
  final String groupText;

  const SuggestedGroupViewCard(this.groupName, this.groupText, this.groupImage, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
              child: customNetworkImage(groupImage, height: 84, boxFit: BoxFit.fitWidth)),
          const SizedBox(height: 5),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(groupName, style: robotoStyle700Bold.copyWith(fontSize: 15, color: AppColors.primaryColorLight))),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(groupText, style: robotoStyle500Medium.copyWith(fontSize: 8, color: AppColors.primaryColorLight))),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 25,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: const Color(0xffE7F3FF)),
                    child: Center(
                        child: Text('Join Group', style: robotoStyle700Bold.copyWith(fontSize: 10, color: AppColors.primaryColorLight))),
                  ),
                ),
                const SizedBox(width: 5),
                Container(
                    height: 25,
                    width: 30,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: const Color(0xffE7F3FF)),
                    child: const Center(child: Icon(Icons.more_horiz, size: 15))),
              ],
            ),
          ),
          const SizedBox(height: 5)
        ],
      ),
    );
  }
}
