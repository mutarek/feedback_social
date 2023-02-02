import 'package:als_frontend/data/model/response/page/page_details_model.dart';
import 'package:als_frontend/screens/page/widget/new_page_like_following_widget.dart';
import 'package:als_frontend/screens/page/widget/page_about_widget.dart';
import 'package:flutter/material.dart';

class PageAboutView extends StatelessWidget {
  const PageAboutView(this.widget, this.isAdmin, this.pageDetailsModel, {Key? key}) : super(key: key);
  final Widget widget;
  final bool isAdmin;
  final PageDetailsModel pageDetailsModel;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        const SizedBox(height: 10),
        NewPageLikeFollowingWidget(pageDetailsModel, isAdmin),
        widget,
        const PageAboutWidget(),
      ],
    );
  }
}
