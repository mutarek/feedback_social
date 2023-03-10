import 'package:als_frontend/provider/group_provider.dart';
import 'package:als_frontend/screens/group/new_design/group_about_view.dart';
import 'package:als_frontend/screens/group/view/group_home_view.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../../util/theme/app_colors.dart';
import '../../../util/theme/text.styles.dart';
import '../../page/shimmer_effect/new_page_details_screen_shimmer.dart';
import '../../video/widget/new_video_widgets.dart';
import '../view/group_media_view.dart';
import '../view/group_people_view.dart';
import '../view/group_policy_view.dart';

class GroupDetailsPage extends StatefulWidget {
  const GroupDetailsPage(this.groupID, {this.index = 0, Key? key}) : super(key: key);
  final int index;
  final String groupID;

  @override
  State<GroupDetailsPage> createState() => _GroupDetailsPageState();
}

class _GroupDetailsPageState extends State<GroupDetailsPage> {
  @override
  void initState() {
    Provider.of<GroupProvider>(context, listen: false).callForGetAllGroupPosts(widget.groupID);
    _pageController = PageController();
    super.initState();
  }

  PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<GroupProvider>(builder: (context, groupProvider, child) {
        return groupProvider.isLoading || groupProvider.isLoadingGroupDetails
            ? const Center(child: NewPageDetailsShimmer())
            : ModalProgressHUD(
                inAsyncCall: groupProvider.isLoadingUpdateCover,
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (int i) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    groupProvider.changeMenuValue(i);
                  },
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    GroupHomeView(tabMenuWidget(groupProvider), widget.groupID, index: widget.index),
                    GroupAboutView(tabMenuWidget(groupProvider), widget.groupID, index: widget.index),
                    GroupMediaView(tabMenuWidget(groupProvider), widget.groupID, index: widget.index),
                    GroupPeopleView(tabMenuWidget(groupProvider), widget.groupID, index: widget.index),
                    GroupPolicyView(tabMenuWidget(groupProvider), widget.groupID, index: widget.index),
                    // PageUpcomingView(tabMenuWidget(pageProvider),  pageProvider.pageDetailsModel),
                  ],
                ),
              );
      }),
    );
  }

  Widget tabMenuWidget(GroupProvider groupProvider) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // TODO: Post Container
          tabButtonWidget(0, "Home", groupProvider),
          tabButtonWidget(1, "About", groupProvider),
          tabButtonWidget(2, "Media", groupProvider),
          tabButtonWidget(3, "People", groupProvider),
          tabButtonWidget(4, "Policies", groupProvider), // 1.5
        ],
      ),
    );
  }

  Widget tabButtonWidget(int status, String title, GroupProvider groupProvider, {int ratio = 2}) {
    return Expanded(
      flex: ratio,
      child: InkWell(
        onTap: () {
          _pageController.animateToPage(status, duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
          groupProvider.changeMenuValue(status);
        },
        child: Container(
          alignment: Alignment.center,
          decoration: groupProvider.menuValue == status
              ? BoxDecoration(borderRadius: BorderRadius.circular(20), color: AppColors.primaryColorLight)
              : const BoxDecoration(),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(
              title,
              style: robotoStyle700Bold.copyWith(
                  fontSize: 12, color: groupProvider.menuValue == status ? Colors.white : AppColors.primaryColorLight),
            ),
          ),
        ),
      ),
    );
  }
}
