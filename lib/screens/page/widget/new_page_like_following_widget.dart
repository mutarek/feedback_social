import 'package:als_frontend/data/model/response/page/page_details_model.dart';
import 'package:als_frontend/provider/page_provider.dart';
import 'package:als_frontend/screens/page/page_dashboard.dart';
import 'package:als_frontend/screens/page/widget/popup_menu_widget.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/image.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/snackbar_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class NewPageLikeFollowingWidget extends StatelessWidget {
  final bool isAdmin;
  final PageDetailsModel pageDetails;
  final int index;

  const NewPageLikeFollowingWidget(this.pageDetails, this.isAdmin, {this.index = 0, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 18, right: 14),
          height: 40,
          child: Row(
            children: [
              isAdmin
                  ? Expanded(
                      child: InkWell(
                        onTap: () {
                          // Provider.of<PageProvider>(context, listen: false).callForGetIndividualPageDetails(authorPage.id.toString());
                          isAdmin
                              ? Helper.toScreen(PageDashboard(pageDetails.id.toString(), index))
                              : showMessage(message: "Ops You don't have access");
                        },
                        child: Container(
                          height: 40,
                          margin: const EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.primaryColorLight),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(ImagesModel.followingIcons, width: 20, height: 20, color: Colors.white),
                              const SizedBox(width: 5),
                              Text("Dashboard", style: robotoStyle700Bold.copyWith(fontSize: 13, color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                if(pageDetails.isLiked ==true){
                                  Provider.of<PageProvider>(context, listen: false).pageUnlike(
                                      int.parse(
                                        pageDetails.id.toString(),
                                      ),
                                      isFromSuggestedPage: true,index: index);
                                }else{
                                  Provider.of<PageProvider>(context, listen: false).pageLikeUnlike(
                                      int.parse(
                                        pageDetails.id.toString(),
                                      ),
                                      isFromSuggestedPage: true,index: index);
                                }
                              },
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(width: 1.0),
                                    color: AppColors.imageBGColorLight),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(ImagesModel.likeIcons, width: 15, height: 15, color: colorText),
                                    const SizedBox(width: 2),
                                    Text(pageDetails.isLiked ==true?"Liked":"Like", style: robotoStyle700Bold.copyWith(fontSize: 12))
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: InkWell(
                              onTap: (){

                              },
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.primaryColorLight),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(ImagesModel.followingIcons, width: 15, height: 15, color: Colors.white),
                                    const SizedBox(width: 2),
                                    Text("Message", style: robotoStyle700Bold.copyWith(fontSize: 12, color: Colors.white)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                        ],
                      ),
                    ),
              Container(
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), border: Border.all(width: 1.0), color: AppColors.imageBGColorLight),
                child: PopupMenuButton(
                  icon: const Icon(Icons.more_horiz, size: 15),
                  itemBuilder: (context) => [
                    // PopupMenuItem 1
                    PopupMenuItem(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PopUpMenuWidget(ImagesModel.addIcons, "Invites Friends", () {}),
                          const SizedBox(height: 15),
                          PopUpMenuWidget(ImagesModel.copyIcons, "Copy Link", () {}),
                          const SizedBox(height: 15),
                          PopUpMenuWidget(ImagesModel.blocksIcons, "Block", () {}),
                          const SizedBox(height: 15),
                        ],
                      ),
                    ),
                    // PopupMenuItem 2
                  ],
                  offset: const Offset(0, 58),
                  color: Colors.white,
                  elevation: 4,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 1),
        const Divider(thickness: 1.8, color: Color(0xffE4E6EB)),
        const SizedBox(height: 5),
      ],
    );
  }
}
