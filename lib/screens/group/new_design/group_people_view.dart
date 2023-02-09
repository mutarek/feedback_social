import 'package:als_frontend/screens/group/widget/group_people_widget.dart';
import 'package:flutter/material.dart';

import '../../page/widget/group_header.dart';

class GroupPeopleView extends StatelessWidget {
  const GroupPeopleView(this.widget,{Key? key}) : super(key: key);
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        //const GroupHeaderWidget(),
        widget,
        const GroupPeopleWidget(),
      ],
    );
  }
}
