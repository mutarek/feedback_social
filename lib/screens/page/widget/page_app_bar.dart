import 'package:als_frontend/screens/page/blocked_page_screen.dart';
import 'package:als_frontend/screens/page/widget/popup_menu_widget.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/image.dart';
import 'package:als_frontend/util/palette.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool? isBackButtonExist;
  final Function? onBackPressed;
  final bool? isOpenPageSettings;
  final double? appBarSize;

  const PageAppBar({
    Key? key,
    required this.title,
    this.isBackButtonExist = true,
    this.isOpenPageSettings = false,
    this.onBackPressed,
    this.appBarSize = 85,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(MediaQuery.of(context).size.width, appBarSize!),
      child: SizedBox(
        height: appBarSize,
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 1,
          shadowColor: Colors.black.withOpacity(.3),
          centerTitle: true,
          leadingWidth: isBackButtonExist! ? 50 : 0,
          leading: isBackButtonExist!
              ? IconButton(
                  icon: const Icon(Icons.arrow_back, color: colorText),
                  onPressed: () {
                    Helper.back();
                  },
                )
              : const SizedBox.shrink(),
          title: Text(title!, style: robotoStyle700Bold.copyWith(fontSize: 20)),
          actions: [
            isOpenPageSettings!
                ? PopupMenuButton(
                    icon: const CircleAvatar(
                        backgroundColor: AppColors.primaryColorLight, radius: 20, child: Icon(Icons.settings, color: Colors.white)),
                    itemBuilder: (context) => [
                      // PopupMenuItem 1
                      PopupMenuItem(
                        value: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Page Setting", style: latoStyle600SemiBold.copyWith(color: Palette.primary)),
                            Row(
                              children: [
                                SvgPicture.asset(ImagesModel.notificationIcons, width: 18, height: 18),
                                const SizedBox(width: 6),
                                Expanded(
                                    child:
                                        Text("Notifications", style: robotoStyle500Medium.copyWith(color: Palette.primary, fontSize: 12))),
                                SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: CupertinoSwitch(value: true, onChanged: (value) {}, activeColor: Palette.primary))),
                              ],
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(ImagesModel.messageIcons, width: 18, height: 18),
                                const SizedBox(width: 6),
                                Expanded(
                                    child: Text("Message", style: robotoStyle500Medium.copyWith(color: Palette.primary, fontSize: 12))),
                                SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: CupertinoSwitch(value: true, onChanged: (value) {}, activeColor: Palette.primary)))
                              ],
                            ),
                            const SizedBox(height: 6),
                            PopUpMenuWidget(ImagesModel.blocksIcons, 'Block Page List', () {
                              Helper.back();
                              Helper.toScreen(const BlockedPageScreen());
                            }),
                            const SizedBox(height: 6),
                          ],
                        ),
                      ),
                      // PopupMenuItem 2
                    ],
                    offset: const Offset(0, 58),
                    color: Colors.white,
                    elevation: 4,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(double.maxFinite, appBarSize!);
}
