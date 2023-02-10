import 'package:als_frontend/provider/group_provider.dart';
import 'package:als_frontend/screens/group/new_design/feedback_groups.dart';
import 'package:als_frontend/screens/group/widget/invite_group_card.dart';
import 'package:als_frontend/screens/page/shimmer_effect/find_page_shimmer.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../../page/widget/page_app_bar.dart';

class InvitesGroup extends StatefulWidget {
  const InvitesGroup({Key? key}) : super(key: key);

  @override
  State<InvitesGroup> createState() => _InvitesGroupState();
}

class _InvitesGroupState extends State<InvitesGroup> {
  @override
  void initState() {
    Provider.of<GroupProvider>(context, listen: false).getAllInvitedGroups();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GroupProvider>(builder: (context, groupProvider, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: const PageAppBar(title: 'Invites Group'),
        body: groupProvider.isLoadingInvitedGroups
            ? const FindPageShimmer()
            : groupProvider.invitedGroupList.isEmpty
                ? Center(child: Text('No invited groups yet.', style: robotoStyle500Medium.copyWith(fontSize: 20)))
                : Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text('You have been invited to join these groups.',
                                style: robotoStyle700Bold.copyWith(fontSize: 12, color: AppColors.primaryColorLight)),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: ListView(
                            physics: const BouncingScrollPhysics(),
                            children: [
                              MasonryGridView.count(
                                crossAxisCount: 2,
                                crossAxisSpacing: 6,
                                mainAxisSpacing: 14,
                                itemCount: groupProvider.invitedGroupList.length,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (_, index) {
                                  var data = groupProvider.invitedGroupList[index];
                                  return InviteGroupCard(data, groupProvider, index);
                                },
                              ),
                              groupProvider.hasInvitedGroupsNextData
                                  ? loadMoreGroup(groupProvider.hasInvitedGroupsNextData, groupProvider.isBottomLoadingInvitedGroup, () {
                                      groupProvider.updateInvitedGroupsPageNo();
                                    }, 'Load more Invite Groups')
                                  : const SizedBox.shrink()
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
      );
    });
  }
}
