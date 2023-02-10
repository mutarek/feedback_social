import 'package:als_frontend/provider/group_provider.dart';
import 'package:als_frontend/screens/group/widget/groupAboutViewWidget.dart';
import 'package:als_frontend/screens/page/widget/group_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupAboutView extends StatelessWidget {
  final String groupID;
  final int index;
  const GroupAboutView(this.widget, this.groupID, {this.index = 0,Key? key}) : super(key: key);
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    return Consumer<GroupProvider>(
      builder: (context, groupProvider,child) {
        return ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            GroupHeaderWidget(index),
            widget,
            GroupAboutViewWidget(groupProvider.newGroupDetailsModel,index),
          ],
        );
      }
    );
  }
}
