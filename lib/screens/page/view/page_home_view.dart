import 'package:als_frontend/screens/page/widget/admin_post_view.dart';
import 'package:als_frontend/screens/page/widget/new_page_details_header_widget.dart';
import 'package:als_frontend/screens/page/widget/new_page_like_following_widget.dart';
import 'package:als_frontend/screens/page/widget/post_widget.dart';
import 'package:flutter/material.dart';

class PageHomeView extends StatelessWidget {
  const PageHomeView(this.widget,{Key? key}) : super(key: key);
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        NewPageDetailsHeaderWidget(),
        NewPageLikeFollowingWidget(),
        widget,
        PagePostView(
          description:
          'In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to the visual form of a commonly  to the ..In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to the visual form of a commonly  to the\nIn publishing and graphic design, Lorem ipsum is a placeholder text commonly used to the visual form of a commonly  to the',
          value: true,
          showDescription: () {
            // pageProvider.changeTextValue();
          },
        ),
        // AdminPostView(
        //
        //   dicription:
        //   'In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to the visual form of a commonly  to the ..In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to the visual form of a commonly  to the\nIn publishing and graphic design, Lorem ipsum is a placeholder text commonly used to the visual form of a commonly  to the',
        //   value: true,
        //   showDescription: () {
        //     // pageProvider.changeTextValue();
        //   },
        // )
      ],
    );
  }
}
