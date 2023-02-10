import 'package:als_frontend/provider/group_provider.dart';
import 'package:als_frontend/screens/group/new_design/feedback_groups.dart';
import 'package:als_frontend/screens/group/new_design/group_details_page.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/image.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../page/widget/page_app_bar.dart';

class PinsGroup extends StatefulWidget {
  const PinsGroup({Key? key}) : super(key: key);

  @override
  State<PinsGroup> createState() => _PinsGroupState();
}

class _PinsGroupState extends State<PinsGroup> {
  @override
  void initState() {
    Provider.of<GroupProvider>(context, listen: false).initializePinGroupLists();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PageAppBar(title: 'Pins Group'),
      body: Consumer<GroupProvider>(
        builder: (context, groupProvider, child) => ModalProgressHUD(
          inAsyncCall: groupProvider.isLoadingForPin2,
          child: groupProvider.isLoadingForPin
              ? const Center(child: CircularProgressIndicator())
              : groupProvider.pinGroupLists.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text('Your pinned groups.',
                                  style: robotoStyle700Bold.copyWith(fontSize: 12, color: AppColors.primaryColorLight)),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            child: ListView(
                              physics: const BouncingScrollPhysics(),
                              children: [
                                ListView.builder(
                                  itemCount: groupProvider.pinGroupLists.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (_, index) {
                                    return InkWell(
                                      onTap: () {
                                        Helper.toScreen(GroupDetailsPage(groupProvider.pinGroupLists[index].id.toString()));
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        margin: const EdgeInsets.only(top: 6, bottom: 6),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey.withOpacity(.1),
                                                  blurRadius: 4.0,
                                                  spreadRadius: 3.0,
                                                  offset: const Offset(0.0, 0.0))
                                            ],
                                            borderRadius: BorderRadius.circular(15)),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            const SizedBox(width: 10),
                                            circularImage(groupProvider.pinGroupLists[index].coverPhoto!, 36, 36),
                                            const SizedBox(width: 15),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(groupProvider.pinGroupLists[index].name!,
                                                    style: robotoStyle700Bold.copyWith(fontSize: 16)),
                                                const SizedBox(height: 5),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(ImagesModel.lastMinuteIcon, width: 14, height: 14),
                                                    const SizedBox(width: 4),
                                                    Text("Last active 0 minutes ago", style: robotoStyle500Medium.copyWith(fontSize: 9)),
                                                  ],
                                                )
                                              ],
                                            ),
                                            const Spacer(),
                                            InkWell(
                                              onTap: () {
                                                groupProvider.deletePinGroup(groupProvider.pinGroupLists[index].id as int, index);
                                              },
                                              child: SvgPicture.asset(ImagesModel.pins_the_group),
                                            ),
                                            const SizedBox(width: 10)
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                groupProvider.hasNextData
                                    ? loadMoreGroup(groupProvider.hasNextData, groupProvider.isBottomLoading, () {
                                        groupProvider.updatePinGroupNo();
                                      }, 'Load more Groups')
                                    : const SizedBox.shrink()
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : Center(
                      child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text("You haven't any pins Group, Please add at first, thanks",
                          style: robotoStyle500Medium.copyWith(fontSize: 16, color: Colors.blueGrey), textAlign: TextAlign.center),
                    )),
        ),
      ),
    );
  }
}
