import 'package:als_frontend/screens/group/widget/group_comuinity_widget.dart';
import 'package:als_frontend/screens/page/widget/group_header.dart';
import 'package:flutter/material.dart';

class GroupComunityView extends StatelessWidget {
  const GroupComunityView(this.widget,{Key? key}) : super(key: key);
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        const GroupHeaderWidget(),
        widget,
        GroupComuinityWidget()
      ],
    );
  }
}
