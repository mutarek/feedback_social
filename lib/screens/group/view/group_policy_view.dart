import 'package:provider/provider.dart';

import '../../../provider/group_provider.dart';
import '../../../util/theme/app_colors.dart';
import '../../../util/theme/text.styles.dart';
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
  void initState() {
    Provider.of<GroupProvider>(context, listen: false).getAllGroupPolicies(widget.groupID.toString());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<GroupProvider>(
        builder: (context, groupProvider,child) {
          return ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              GroupHeaderWidget(widget.index),
              widget.widget,
              groupProvider.isLoadingCreatePolicy?
                  const Center(
                    child: CircularProgressIndicator(),
                  ):
                  groupProvider.groupPolicyList.isEmpty?
                      const Center(
                        child: Text("Ops No Group Policies"),
                      ):
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: groupProvider.groupPolicyList.length,
                itemBuilder: (_, index) {
                  var rules = groupProvider.groupPolicyList[index];
                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Text("${index + 1}. ${rules.title}",
                              style: robotoStyle700Bold.copyWith(fontSize: 15, color: AppColors.primaryColorLight)),
                        ),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.only(left: 18),
                          child: Column(
                            children: [
                              Text(
                                  "${rules.description} See more.",
                                  style: robotoStyle500Medium.copyWith(fontSize: 12, color: AppColors.primaryColorLight)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          );
        }
    );
  }
}
