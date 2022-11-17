import 'package:als_frontend/localization/language_constrants.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class OwnerInfoWidget extends StatelessWidget {
  final String? image;
  final String? name;

  const OwnerInfoWidget({Key? key, required this.image, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(radius: 25, backgroundImage: NetworkImage(image!)),
        const SizedBox(width: 7),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(title: name,textStyle: latoStyle600SemiBold.copyWith(fontSize: 18)),
            CustomText(title: getTranslated('Owner',context),textStyle: latoStyle400Regular.copyWith(fontSize: 15)),
          ],
        )
      ],
    );
  }
}
