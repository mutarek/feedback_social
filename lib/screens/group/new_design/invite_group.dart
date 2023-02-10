import 'package:als_frontend/provider/group_provider.dart';
import 'package:als_frontend/screens/group/widget/invite_group_card.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../page/widget/page_app_bar.dart';

class InvitesGroup extends StatefulWidget {
  const InvitesGroup({Key? key}) : super(key: key);

  @override
  State<InvitesGroup> createState() => _InvitesGroupState();
}

class _InvitesGroupState extends State<InvitesGroup> {
  ScrollController controller = ScrollController();
  @override
  void initState() {
    Provider.of<GroupProvider>(context, listen: false).getAllInvitedGroups(page: 1,isFirstTime: true);
    controller.addListener(() {
      if (controller.offset >= controller.position.maxScrollExtent &&
          !controller.position.outOfRange &&
          Provider.of<GroupProvider>(context, listen: false).hasInvitedGroupsNextData) {
        Provider.of<GroupProvider>(context, listen: false).updateInvitedGroupsPageNo();
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<GroupProvider>(
      builder: (context, groupProvider,child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: const PageAppBar(title: 'Invites Group'),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text('You have been invited to join these groups.',style: robotoStyle700Bold.copyWith(fontSize: 12,color: AppColors.primaryColorLight)),
                  ),
                ),
                const SizedBox(height: 10,),
                Expanded(
                  child:
                      groupProvider.invitedGroupList.isEmpty?
                          Center(
                            child: Text('No invited groups yet.',style: robotoStyle700Bold.copyWith(fontSize:20)),
                          ):GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2
                        ),
                        itemCount: groupProvider.invitedGroupList.length,
                        itemBuilder: (_,index){
                          var data = groupProvider.invitedGroupList[index];
                          return InviteGroupCard(data.coverPhoto!,
                              data.name!,"${data.followers } Members","Mehedi invited you");
                        },
                      ),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
