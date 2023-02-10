import 'package:provider/provider.dart';

import '../../../provider/group_provider.dart';
import '../../page/widget/group_header.dart';
import '../../video/widget/new_video_widgets.dart';
import '../widget/group_comuinity_widget.dart';

class GroupPolicyView extends StatefulWidget {
  final String groupID;
  final int index;
  const GroupPolicyView(this.widget, this.groupID, {this.index = 0,Key? key}) : super(key: key);
  final Widget widget;

  @override
  State<GroupPolicyView> createState() => _GroupPolicyViewState();
}

class _GroupPolicyViewState extends State<GroupPolicyView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GroupProvider>(
        builder: (context, groupProvider,child) {
          return ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              GroupHeaderWidget(widget.index),
              widget.widget,
              GroupComuinityWidget(groupProvider.newGroupDetailsModel,widget.index),
            ],
          );
        }
    );
  }
}
