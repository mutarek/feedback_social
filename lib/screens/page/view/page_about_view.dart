import 'package:als_frontend/screens/page/widget/about_widget.dart';
import 'package:als_frontend/screens/page/widget/new_page_like_following_widget.dart';
import 'package:flutter/material.dart';

class PageAboutView extends StatelessWidget {
  const PageAboutView(this.widget,{Key? key}) : super(key: key);
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        const SizedBox(height: 10),
        const NewPageLikeFollowingWidget(),
        widget,
        const PageAboutViewWidget()
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
