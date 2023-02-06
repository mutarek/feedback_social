import 'package:als_frontend/provider/page_provider.dart';
import 'package:als_frontend/screens/home/widget/create_post_widget.dart';
import 'package:als_frontend/screens/page/widget/new_page_details_header_widget.dart';
import 'package:als_frontend/screens/page/widget/new_page_like_following_widget.dart';
import 'package:als_frontend/screens/post/widget/post_widget.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/image.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class PageHomeView extends StatefulWidget {
  final String pageID;
  final int index;

  const PageHomeView(this.widget, this.pageID, {this.index = 0, Key? key}) : super(key: key);
  final Widget widget;

  @override
  State<PageHomeView> createState() => _PageHomeViewState();
}

class _PageHomeViewState extends State<PageHomeView> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(() {
      if (controller.offset >= controller.position.maxScrollExtent &&
          !controller.position.outOfRange &&
          Provider.of<PageProvider>(context, listen: false).hasNextData) {
        Provider.of<PageProvider>(context, listen: false).updatePageNo(widget.pageID.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PageProvider>(
        builder: (context, pageProvider, child) => ListView(
              physics: const BouncingScrollPhysics(),
              controller: controller,
              children: [
                NewPageDetailsHeaderWidget(pageProvider.pageDetailsModel, widget.index),
                NewPageLikeFollowingWidget(pageProvider.pageDetailsModel,index: widget.index),
                widget.widget,
                SizedBox(
                    height: pageProvider.pageDetailsModel.category!.isEmpty &&
                            pageProvider.pageDetailsModel.email!.isEmpty &&
                            pageProvider.pageDetailsModel.website!.isEmpty
                        ? 5
                        : 20),
                pageProvider.pageDetailsModel.category!.isEmpty &&
                        pageProvider.pageDetailsModel.email!.isEmpty &&
                        pageProvider.pageDetailsModel.website!.isEmpty
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.only(left: 18), child: Text("Details", style: robotoStyle700Bold.copyWith(fontSize: 16))),
                SizedBox(
                    height: pageProvider.pageDetailsModel.category!.isEmpty &&
                            pageProvider.pageDetailsModel.email!.isEmpty &&
                            pageProvider.pageDetailsModel.website!.isEmpty
                        ? 0
                        : 15),
                pageProvider.pageDetailsModel.category!.isEmpty
                    ? const SizedBox.shrink()
                    : infoWidget(ImagesModel.categoryIcons, pageProvider.pageDetailsModel.category!,
                        Text('Category - ', style: robotoStyle800ExtraBold.copyWith(fontSize: 15))),
                SizedBox(height: pageProvider.pageDetailsModel.category!.isEmpty ? 0 : 10),
                pageProvider.pageDetailsModel.email!.isEmpty
                    ? const SizedBox.shrink()
                    : infoWidget(ImagesModel.emailIcons, pageProvider.pageDetailsModel.email!, const SizedBox.shrink()),
                SizedBox(height: pageProvider.pageDetailsModel.email!.isEmpty ? 0 : 10),
                pageProvider.pageDetailsModel.website!.isEmpty
                    ? const SizedBox.shrink()
                    : infoWidget(ImagesModel.websiteIcons, pageProvider.pageDetailsModel.website!, const SizedBox.shrink()),
                SizedBox(height: pageProvider.pageDetailsModel.website!.isEmpty ? 0 : 20),
                !isMe(pageProvider.pageDetailsModel.author!.id.toString())
                    ? const SizedBox.shrink()
                    : Container(
                        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                        decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xffE4E6EB), width: 2))),
                        child: createPostWidget(isForPage: true, groupPageID: pageProvider.pageDetailsModel.id as int)),
                const SizedBox(height: 15),
                ListView.builder(
                    itemCount: pageProvider.pageAllPosts.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return PostWidget(pageProvider.pageAllPosts[index], index: index, isPage: true);
                    })
              ],
            ));
  }

  Widget infoWidget(String imageURL, String title, Widget widget) {
    return Padding(
      padding: const EdgeInsets.only(left: 18),
      child: Row(
        children: [
          Container(
            height: 20,
            width: 20,
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(color: AppColors.primaryColorLight, shape: BoxShape.circle),
            child: SvgPicture.asset(imageURL, height: 13, width: 13),
          ),
          const SizedBox(width: 2),
          widget,
          const SizedBox(width: 2),
          Text(title, style: robotoStyle400Regular.copyWith(fontSize: 14))
        ],
      ),
    );
  }
}
