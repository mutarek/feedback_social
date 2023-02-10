import 'package:als_frontend/data/model/response/group/group_details_model.dart';
import 'package:als_frontend/screens/group/widget/group_media_widget.dart';
import 'package:als_frontend/screens/page/widget/group_header.dart';
import 'package:flutter/material.dart';

class GroupMediaViewWidget extends StatelessWidget {
  final GroupDetailsModel authorEachGroupModel;
  final int index;
  const GroupMediaViewWidget(this.authorEachGroupModel,this.index,{Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        GroupMediaWidget(authorEachGroupModel,index),
      ],
    );
  }
}
