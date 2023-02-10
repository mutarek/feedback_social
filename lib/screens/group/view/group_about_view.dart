import 'package:als_frontend/provider/group_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widget/groupAboutViewWidget.dart';

class GroupAboutView extends StatelessWidget {
  final String groupID;
  final int index;
  const GroupAboutView(this.widget, this.groupID, {this.index = 0,Key? key}) : super(key: key);
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Consumer<GroupProvider>(
        builder: (context, groupProvider, child) => ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            GroupAboutViewWidget(groupProvider.groupDetailsModel,index),
            widget,
          ],
        ));
  }
}
