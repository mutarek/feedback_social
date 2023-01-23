import 'package:als_frontend/provider/other_provider.dart';
import 'package:als_frontend/provider/page_provider.dart';
import 'package:als_frontend/screens/page/widget/page_app_bar.dart';
import 'package:als_frontend/screens/page/widget/page_view_widget.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewMyLikedPageScreen extends StatelessWidget{
  const NewMyLikedPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<OtherProvider, PageProvider>(
      builder: (context, otherProvider, pageProvider, child) {
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: const PageAppBar(title: 'Pages you like & follow'),
            body: pageProvider.likedPageLists.isNotEmpty
                ? ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    itemCount: pageProvider.likedPageLists.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return PageViewWidget(authorPageModel: pageProvider.likedPageLists[index]);
                    })
                : const Center(child: CustomText(title: "You haven't any Liked Page")));
      },
    );
  }
}
