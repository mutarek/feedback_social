import 'package:als_frontend/data/model/response/author_group_model.dart';
import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/provider/group_provider.dart';
import 'package:als_frontend/screens/page/widget/popup_menu_widget.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:als_frontend/util/image.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class InviteGroupCard extends StatelessWidget {
  final AuthorGroupModelWithID authorGroupModel;
  final GroupProvider groupProvider;
  final int index;

  const InviteGroupCard(this.authorGroupModel, this.groupProvider, this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(.2), blurRadius: 10.0, spreadRadius: 3.0, offset: Offset(0.0, 0.0))],
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
              child: customNetworkImage(authorGroupModel.authorGroupModel!.coverPhoto!, height: 84, boxFit: BoxFit.fill)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 6),
                Text(authorGroupModel.authorGroupModel!.name!,
                    style: robotoStyle700Bold.copyWith(fontSize: 18, color: AppColors.primaryColorLight)),
                const SizedBox(height: 4),
                Text('${authorGroupModel.authorGroupModel!.totalMember} Members',
                    style: robotoStyle700Bold.copyWith(fontSize: 10, color: AppColors.primaryColorLight)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          groupProvider.joinInviteGroup(authorGroupModel.id.toString(), authorGroupModel.authorGroupModel!.id.toString(),
                              Provider.of<AuthProvider>(context, listen: false).userID, index);
                        },
                        child: Container(
                          height: 25,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: const Color(0xffE7F3FF)),
                          child: Center(child: Text('Join Group', style: robotoStyle600SemiBold.copyWith(fontSize: 10))),
                        ),
                      ),
                    ),
                    const SizedBox(width: 7),
                    PopupMenuButton(
                      itemBuilder: (context) => [
                        // PopupMenuItem 1
                        PopupMenuItem(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PopUpMenuWidget(ImagesModel.notInterestedIcons, 'Not Interested', () {
                                groupProvider.cancelInviteGroup(authorGroupModel.id.toString(), index);
                                Navigator.of(context).pop();
                              }, size: 18),
                              const SizedBox(height: 13),
                              PopUpMenuWidget(ImagesModel.copyIcons, 'Copy', () {
                                Clipboard.setData(
                                    ClipboardData(text: '${AppConstant.baseUrl}${authorGroupModel.authorGroupModel!.copyLinkUrl}'));
                                Fluttertoast.showToast(msg: 'Copy Successfully');
                                Navigator.of(context).pop();
                              }, size: 18),
                              const SizedBox(height: 5),
                            ],
                          ),
                        ),
                        // PopupMenuItem 2
                      ],
                      offset: const Offset(0, 58),
                      color: Colors.white,
                      elevation: 4,
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                      child: Container(
                        width: 30,
                        height: 25,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: const Color(0xffE7F3FF)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [Icon(Icons.more_horiz, color: AppColors.primaryColorLight, size: 12)],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
