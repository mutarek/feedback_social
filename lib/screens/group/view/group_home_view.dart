import 'package:als_frontend/provider/group_provider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../provider/page_provider.dart';
import '../../../util/helper.dart';
import '../../../util/image.dart';
import '../../../util/theme/app_colors.dart';
import '../../../util/theme/text.styles.dart';
import '../../home/widget/create_post_widget.dart';
import '../../page/widget/group_header.dart';
import '../../page/widget/page_details_header_widget.dart';
import '../../page/widget/new_page_like_following_widget.dart';
import '../../post/widget/post_widget.dart';
import '../../video/widget/new_video_widgets.dart';

class GroupHomeView extends StatefulWidget {
  final String groupID;
  final int index;
  const GroupHomeView(this.widget, this.groupID, {this.index = 0,Key? key}) : super(key: key);
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
        Provider.of<GroupProvider>(context, listen: false).updatePageNo(widget.groupID.toString());
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<GroupProvider>(
        builder: (context, groupProvider, child) =>
            ListView(
          physics: const BouncingScrollPhysics(),
          controller: controller,
          children: [
            GroupHeaderWidget(groupProvider.newGroupDetailsModel,widget.index),
            widget.widget,
          ],
        ));
  }

  Widget infoWidget(String imageURL, String title, Widget widget) {
    return Padding(
      padding: const EdgeInsets.only(left: 18),
      child: Row(
        children: [
          Container(
            height: 20,
            width: 20,
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(color: AppColors.primaryColorLight, shape: BoxShape.circle),
            child: SvgPicture.asset(imageURL, height: 13, width: 13),
          ),
          const SizedBox(width: 2),
          widget,
          const SizedBox(width: 2),
          Text(title, style: robotoStyle400Regular.copyWith(fontSize: 14))
        ],
      ),
    );
  }
}