
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter/cupertino.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({
    Key? key,
    required this.buttunName,
    required this.buttunValue,
    required this.onChanged,
  }) : super(key: key);
  final String buttunName;
  final bool buttunValue;
  final bool? Function(bool?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.scaffold,

        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 20,),
          Text(buttunName,style: latoStyle500Medium,),
          const Spacer(),
          CupertinoSwitch(
            value:buttunValue,
            onChanged: onChanged,
          ),
          const SizedBox(width: 10,),
        ],
      ),
    );
  }
}
