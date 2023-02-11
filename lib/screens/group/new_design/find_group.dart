import 'dart:math';

import 'package:als_frontend/provider/group_provider.dart';
import 'package:als_frontend/screens/page/shimmer_effect/find_page_shimmer.dart';
import 'package:als_frontend/screens/page/widget/page_app_bar.dart';
import 'package:als_frontend/screens/page/widget/popup_menu_widget.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../util/image.dart';

class FindGroup extends StatefulWidget {
  const FindGroup({Key? key}) : super(key: key);

  @override
  State<FindGroup> createState() => _FindGroupState();
}

class _FindGroupState extends State<FindGroup> {
  ScrollController controller = ScrollController();
  TextEditingController textController = TextEditingController();
  var rng = Random();

  @override
  void initState() {
    Provider.of<GroupProvider>(context, listen: false).resetSearchHistory();
    controller.addListener(() {
      if (controller.offset >= controller.position.maxScrollExtent &&
          !controller.position.outOfRange &&
          Provider.of<GroupProvider>(context, listen: false).hasNextData) {
        Provider.of<GroupProvider>(context, listen: false).updateFindGroupSearchNo(textController.text);
      }
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PageAppBar(title: 'Find Groups'),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
        child: Consumer<GroupProvider>(builder: (context, groupProvider, child) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  height: 48.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primaryColorLight),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: textController,
                          decoration: const InputDecoration(
                              focusedBorder: InputBorder.none,
                              border: InputBorder.none,
                              hintText: "Search..",
                              hintStyle: TextStyle(color: Colors.black)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: AppColors.primaryColorLight),
                          height: 38,
                          width: 71,
                          child: Center(
                            child: InkWell(
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  groupProvider.findGroup(textController.text, page: 1);
                                },
                                child: Text('Search', style: robotoStyle300Light.copyWith(fontSize: 12, color: Colors.white))),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: groupProvider.isLoadingFindGroup
                    ? const FindPageShimmer()
                    : groupProvider.findGroupLists.isNotEmpty
                        ? ListView(
                            physics: const BouncingScrollPhysics(),
                            controller: controller,
                            children: [
                              ListView.builder(
                                itemCount: groupProvider.findGroupLists.length,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (_, index) {
                                  return Card(
                                    elevation: 1,
                                    color: (const Color(0xffFAFAFA)),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            const SizedBox(width: 10),
                                            ClipRRect(
                                                borderRadius: BorderRadius.circular(10),
                                                child: SizedBox(
                                                    height: 36,
                                                    width: 36,
                                                    child: customNetworkImage(groupProvider.findGroupLists[index].coverPhoto!,
                                                        height: 36, boxFit: BoxFit.fitWidth))),
                                            const SizedBox(width: 10),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(groupProvider.findGroupLists[index].name!,
                                                    style: robotoStyle700Bold.copyWith(fontSize: 15, color: AppColors.primaryColorLight)),
                                                Row(
                                                  children: [
                                                    Text(
                                                      '${groupProvider.findGroupLists[index].totalMember} Members - 1+ Post a Day',
                                                      style:
                                                          robotoStyle500Medium.copyWith(fontSize: 10, color: AppColors.primaryColorLight),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Row(
                                                      children: [
                                                        SvgPicture.asset(ImagesModel.lastMinuteIcon, width: 14, height: 14),
                                                        const SizedBox(width: 2),
                                                        Text('${rng.nextInt(9) + 1} hours ago',
                                                            style: robotoStyle500Medium.copyWith(fontSize: 9)),
                                                      ],
                                                    )
                                                  ],
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 20, right: 20),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Card(
                                                  elevation: 1,
                                                  color: index % 2 == 0 ? const Color(0xffFAFAFA) : const Color(0xff080C2F),
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                  child: SizedBox(
                                                    height: 37,
                                                    child: Expanded(
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          SvgPicture.asset(
                                                            "assets/svg/join_group_svg.svg",
                                                            height: 17,
                                                            width: 20,
                                                            color: index % 2 == 0 ? AppColors.primaryColorLight : Colors.white,
                                                          ),
                                                          const SizedBox(width: 5),
                                                          Text(index % 2 == 0 ? "Join Group" : "Joined",
                                                              style: robotoStyle700Bold.copyWith(
                                                                  fontSize: 15,
                                                                  color: index % 2 == 0 ? AppColors.primaryColorLight : Colors.white))
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Card(
                                                elevation: 1,
                                                color: (const Color(0xffFAFAFA)),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                child: SizedBox(
                                                  height: 37,
                                                  width: 70,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      PopupMenuButton(
                                                          itemBuilder: (context) => [
                                                                // PopupMenuItem 1
                                                                PopupMenuItem(
                                                                  child: Column(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      PopUpMenuWidget(
                                                                        ImagesModel.visitGroupIcons,
                                                                        'Visit Group',
                                                                        () {},
                                                                        isShowAssetImage: false,
                                                                      ),
                                                                      const SizedBox(
                                                                        height: 18,
                                                                      ),
                                                                      PopUpMenuWidget(
                                                                        ImagesModel.copyIcons,
                                                                        'Copy Link',
                                                                        () {
                                                                          Clipboard.setData(ClipboardData(
                                                                              text: groupProvider.findGroupLists[index].copyLinkUrl));
                                                                        },
                                                                        isShowAssetImage: false,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                // PopupMenuItem 2
                                                              ],
                                                          offset: const Offset(0, 58),
                                                          color: Colors.white,
                                                          elevation: 4,
                                                          shape: const RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                                          child: const Icon(Icons.more_horiz)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              groupProvider.isBottomLoadingFindGroup
                                  ? Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 100,
                                      alignment: Alignment.center,
                                      child: const CupertinoActivityIndicator())
                                  : const SizedBox.shrink()
                            ],
                          )
                        : Center(
                            child: Text(
                            'No Search Data Available',
                            style: robotoStyle500Medium.copyWith(color: Colors.blueGrey),
                          )),
              ),
            ],
          );
        }),
      ),
    );
  }
}
