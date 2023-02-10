import 'package:als_frontend/data/model/response/author_group_model.dart';
import 'package:als_frontend/provider/group_provider.dart';
import 'package:als_frontend/provider/other_provider.dart';
import 'package:als_frontend/screens/group/new_design/feedback_groups.dart';
import 'package:als_frontend/screens/page/shimmer_effect/find_page_shimmer.dart';
import 'package:als_frontend/screens/page/widget/page_app_bar.dart';
import 'package:als_frontend/screens/page/widget/popup_menu_widget.dart';
import 'package:als_frontend/util/image.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:als_frontend/widgets/network_image.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class BlockedGroupScreen extends StatefulWidget {
  const BlockedGroupScreen({Key? key}) : super(key: key);

  @override
  State<BlockedGroupScreen> createState() => _BlockedGroupScreenState();
}

class _BlockedGroupScreenState extends State<BlockedGroupScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<GroupProvider>(context, listen: false).callForGetGroupBlockLists(isFirstTime: true);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<OtherProvider, GroupProvider>(
      builder: (context, otherProvider, groupProvider, child) {
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: const PageAppBar(title: 'My Group Block'),
            body: groupProvider.isLoadingBlockGroup
                ? const FindPageShimmer()
                : groupProvider.blockGroupLists.isNotEmpty
                    ? ModalProgressHUD(
                        inAsyncCall: groupProvider.isLoadingBlockGroup2,
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            ListView.builder(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                itemCount: groupProvider.blockGroupLists.length,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  AuthorGroupModel groupModel = groupProvider.blockGroupLists[index];
                                  return Container(
                                    padding: const EdgeInsets.all(8.0),
                                    margin: const EdgeInsets.only(top: 6, bottom: 6),
                                    decoration: BoxDecoration(
                                        color: const Color(0xffFAFAFA),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey.withOpacity(.2),
                                              blurRadius: 10.0,
                                              spreadRadius: 3.0,
                                              offset: const Offset(0.0, 0.0))
                                        ],
                                        borderRadius: BorderRadius.circular(15)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        circularImage(groupModel.coverPhoto!, 40, 40),
                                        const SizedBox(width: 15),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(groupModel.name!, style: robotoStyle700Bold.copyWith(fontSize: 16)),
                                            const SizedBox(height: 5)
                                          ],
                                        ),
                                        const Spacer(),
                                        PopupMenuButton(
                                          itemBuilder: (context) => [
                                            // PopupMenuItem 1
                                            PopupMenuItem(
                                              child: PopUpMenuWidget(ImagesModel.blocksIcons, 'Unblock Group', () {
                                                groupProvider.createUnBlock(groupModel.id as int, index);
                                                Navigator.of(context).pop();
                                              }),
                                            ),
                                            // PopupMenuItem 2
                                          ],
                                          offset: const Offset(0, 28),
                                          color: Colors.white,
                                          elevation: 4,
                                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                          child: Container(
                                            height: 24,
                                            width: 30,
                                            decoration:
                                                BoxDecoration(color: const Color(0xffE4E6EB), borderRadius: BorderRadius.circular(10)),
                                            child: const Center(child: Icon(Icons.more_horiz)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                            groupProvider.hasNextDataBlockGroup
                                ? loadMoreGroup(groupProvider.hasNextDataBlockGroup, groupProvider.isBottomLoadingBlockGroup, () {
                                    groupProvider.updateBlockGroupNo();
                                  }, 'Load more Groups')
                                : const SizedBox.shrink()
                          ],
                        ),
                      )
                    : const Center(child: CustomText(title: "You haven't any Block Groups")));
      },
    );
  }
}
