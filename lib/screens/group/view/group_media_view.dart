import 'package:als_frontend/screens/group/new_design/group_media_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/group_provider.dart';
import '../../page/widget/group_header.dart';
import '../widget/group_media_widget.dart';

class GroupMediaView extends StatefulWidget {
  final String groupID;
  final int index;
  const GroupMediaView(this.widget, this.groupID, {this.index = 0,Key? key}) : super(key: key);
  final Widget widget;

  @override
  State<GroupMediaView> createState() => _GroupMediaViewState();
}

class _GroupMediaViewState extends State<GroupMediaView> {
  ScrollController controller = ScrollController();
  @override
  void initState() {
      controller.addListener(() {
        if (controller.offset >= controller.position.maxScrollExtent &&
            !controller.position.outOfRange &&
            Provider.of<GroupProvider>(context, listen: false).hasNextData) {
          Provider.of<GroupProvider>(context, listen: false).updateGroupNo(widget.groupID.toString());
        }
      });
      super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GroupProvider>(
        builder: (context, groupProvider,child) {
          return ListView(
            physics: const BouncingScrollPhysics(),
            controller: controller,
            children: [
              GroupHeaderWidget(widget.index),
              widget.widget,
              GroupMediaWidget(groupProvider.groupDetailsModel,widget.index),
            ],
          );
        }
    );
  }
}
