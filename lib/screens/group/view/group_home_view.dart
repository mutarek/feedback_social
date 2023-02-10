import 'package:als_frontend/provider/group_provider.dart';
import 'package:als_frontend/screens/post/widget/post_widget.dart';
import 'package:provider/provider.dart';

import '../../../util/helper.dart';
import '../../home/widget/create_post_widget.dart';
import '../../page/widget/group_header.dart';
import '../../video/widget/new_video_widgets.dart';

class GroupHomeView extends StatefulWidget {
  final String groupID;
  final int index;

  const GroupHomeView(this.widget, this.groupID, {this.index = 0, Key? key}) : super(key: key);
  final Widget widget;

  @override
  State<GroupHomeView> createState() => _GroupHomeViewState();
}

class _GroupHomeViewState extends State<GroupHomeView> {
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
        builder: (context, groupProvider, child) => ListView(
              physics: const BouncingScrollPhysics(),
              controller: controller,
              children: [
                GroupHeaderWidget(widget.index),
                widget.widget,
                SizedBox(height: isMe(groupProvider.groupDetailsModel.creator!.id.toString()) ? 6 : 0),
                !isMe(groupProvider.groupDetailsModel.creator!.id.toString())
                    ? const SizedBox.shrink()
                    : Container(
                        decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xffE4E6EB), width: 2))),
                        child: createPostWidget(isForGroup: true, groupPageID: groupProvider.groupDetailsModel.id as int)),

                const SizedBox(height: 15),
                ListView.builder(
                    itemCount: groupProvider.groupAllPosts.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return PostWidget(groupProvider.groupAllPosts[index], index: index, isGroup: true);
                    })

              ],
            ));
  }
}
