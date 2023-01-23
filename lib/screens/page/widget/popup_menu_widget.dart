import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PopUpMenuWidget extends StatelessWidget {
  const PopUpMenuWidget(this.imagePath, this.title, this.callback, {this.size = 15, this.isShowAssetImage = false, Key? key})
      : super(key: key);
  final String imagePath;
  final String title;
  final GestureTapCallback? callback;
  final double size;
  final bool isShowAssetImage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          isShowAssetImage ? Image.asset(imagePath, width: size, height: size) : SvgPicture.asset(imagePath, height: size, width: size),
          const SizedBox(width: 3),
          Text(title, style: robotoStyle500Medium.copyWith(fontSize: 13))
        ],
      ),
    );
  }
}
