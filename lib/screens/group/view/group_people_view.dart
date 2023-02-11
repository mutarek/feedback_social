import 'package:als_frontend/provider/auth_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../provider/group_provider.dart';
import '../../../util/helper.dart';
import '../../../util/theme/app_colors.dart';
import '../../../util/theme/text.styles.dart';
import '../../../widgets/network_image.dart';
import '../../page/widget/group_header.dart';
import '../../profile/profile_screen.dart';
import '../../profile/public_profile_screen.dart';
import '../../video/widget/new_video_widgets.dart';

class GroupPeopleView extends StatefulWidget {
  final String groupID;
  final int index;

  const GroupPeopleView(this.widget, this.groupID, {this.index = 0, Key? key}) : super(key: key);
  final Widget widget;

  @override
  State<GroupPeopleView> createState() => _GroupPolicyViewState();
}

class _GroupPolicyViewState extends State<GroupPeopleView> {
  ScrollController controller = ScrollController();
  @override
  void initState() {
    Provider.of<GroupProvider>(context, listen: false).getGroupMembers(widget.groupID.toString(), isFirstTime: true);
    // if (controller.offset >= controller.position.maxScrollExtent &&
    //     !controller.position.outOfRange &&
    //     Provider.of<GroupProvider>(context, listen: false).hasNextData) {
    //   Provider.of<GroupProvider>(context, listen: false).updategro(widget.groupID.toString());
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<GroupProvider, AuthProvider>(builder: (context, groupProvider, authProvider, child) {
      return ListView(
        controller: controller,
        physics: const BouncingScrollPhysics(),
        children: [
          GroupHeaderWidget(widget.index),
          widget.widget,
          groupProvider.isLoadingCreatePolicy
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : groupProvider.groupPolicyList.isEmpty
                  ? const Center(
                      child: Text("Ops No Group Policies"),
                    )
                  : const SizedBox(
                      height: 5,
                    ),
          groupProvider.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : groupProvider.groupMembersList.isEmpty
                  ? const Center(
                      child: Text("Ops You have No Members"),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: groupProvider.groupMembersList.length,
                      itemBuilder: (context, index) {
                        var members = groupProvider.groupMembersList[index];
                        return ListTile(
                          onTap: () {
                            if (authProvider.userID == members.member!.id) {
                              Helper.toScreen(const ProfileScreen());
                            } else {
                              Helper.toScreen(PublicProfileScreen(members.member!.id.toString(),
                                  isFromFriendRequestScreen: false, isFromFriendScreen: false));
                            }
                          },
                          leading: CircleAvatar(
                            backgroundColor: index % 2 == 0 ? Colors.amber : Colors.teal,
                            child: circularImage(members.member!.profileImage.toString(), 36, 36),
                          ),
                          title: Text(
                            members.member!.fullName.toString(),
                            style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 14, color: AppColors.primaryColorLight),
                          ),
                        );
                      }),
          const SizedBox(
            height: 5,
          ),
        ],
      );
    });
  }
}
