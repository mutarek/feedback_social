import 'package:als_frontend/data/model/response/page/athour_pages_model.dart';
import 'package:als_frontend/provider/other_provider.dart';
import 'package:als_frontend/provider/page_provider.dart';
import 'package:als_frontend/screens/page/new_design/new_page_details_screen.dart';
import 'package:als_frontend/screens/page/widget/page_app_bar.dart';
import 'package:als_frontend/screens/page/widget/page_view_widget.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewMyLikedPageScreen extends StatefulWidget {
  const NewMyLikedPageScreen({Key? key}) : super(key: key);

  @override
  State<NewMyLikedPageScreen> createState() => _NewMyLikedPageScreenState();
}

class _NewMyLikedPageScreenState extends State<NewMyLikedPageScreen> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<PageProvider>(context, listen: false).initializeLikedPageLists(isFirstTime: true);

    controller.addListener(() {
      if (controller.offset >= controller.position.maxScrollExtent &&
          !controller.position.outOfRange &&
          Provider.of<PageProvider>(context, listen: false).hasNextDataMyPage) {
        Provider.of<PageProvider>(context, listen: false).updateMyLikedPageNo();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<OtherProvider, PageProvider>(
      builder: (context, otherProvider, pageProvider, child) {
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: const PageAppBar(title: 'Pages you like & follow'),
            body: pageProvider.isLoadingMyPage
                ? const Center(child: CircularProgressIndicator())
                : pageProvider.likedPageLists.isNotEmpty
                    ? ListView.builder(
                        controller: controller,
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        itemCount: pageProvider.likedPageLists.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          AuthorPageModel pageModel2 = pageProvider.likedPageLists[index];
                          return PageViewWidget(
                              authorPageModel: AuthorPageModel(id: pageModel2.id, name: pageModel2.name, avatar: pageModel2.name),
                              onTap: () {
                                pageProvider.changeSearchView(0);
                                Helper.toScreen(NewPageDetailsScreen(pageModel2.id.toString(), index: index));
                              });
                        })
                    : const Center(child: CustomText(title: "You haven't any Liked Page")));
      },
    );
  }
}
