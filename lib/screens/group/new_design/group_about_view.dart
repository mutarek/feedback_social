import 'package:als_frontend/screens/group/widget/groupAboutViewWidget.dart';
import 'package:als_frontend/screens/page/widget/group_header.dart';
import 'package:als_frontend/screens/page/widget/new_page_like_following_widget.dart';
import 'package:flutter/material.dart';

class GroupAboutView extends StatelessWidget {
  const GroupAboutView(this.widget,{Key? key}) : super(key: key);
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        const GroupHeaderWidget(),
        widget,
        const GroupAboutViewWidget(),
      ],
    );
  }
}
