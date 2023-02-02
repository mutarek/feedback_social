import 'package:als_frontend/data/model/response/page/page_details_model.dart';
import 'package:als_frontend/screens/page/widget/new_page_like_following_widget.dart';
import 'package:als_frontend/screens/page/widget/page_about_widget.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter/material.dart';

class PageUpcomingView extends StatelessWidget {
  const PageUpcomingView(this.widget, this.isAdmin, this.pageDetailsModel, {Key? key}) : super(key: key);
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
        Container(
          alignment: Alignment.center,
          height: 300,
          child: Text('Coming soon...', style: robotoStyle900Black.copyWith(fontSize: 22)),
        )
      ],
    );
  }
}
