import 'package:als_frontend/old_code/const/palette.dart';
import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {

  final List<IconData> icons;
  final int selectedIndex;
  final Function(int) onTap;

  const CustomTabBar({Key? key, required this.icons, required this.selectedIndex, required this.onTap}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicatorPadding: EdgeInsets.zero,
      indicator: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Palette.primary,
            width: 3.0
          )
        )
      ),
      tabs: icons.asMap()
      .map((i, e) => MapEntry(i,Tab(
        icon: Icon(e,
          color:(i == selectedIndex)? Palette.primary: Colors.black45,
          size: 30,
        ),
      )
    )).values.toList(),
    onTap: onTap,
    );
  }
}