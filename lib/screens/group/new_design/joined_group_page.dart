import 'package:als_frontend/screens/page/widget/group_header.dart';
import 'package:als_frontend/screens/page/widget/new_page_details_header_widget.dart';
import 'package:als_frontend/screens/page/widget/new_page_like_following_widget.dart';
import 'package:als_frontend/screens/page/widget/post_widget.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter/material.dart';

class JoinedGroupPage extends StatelessWidget {
  const JoinedGroupPage(this.widget,{Key? key}) : super(key: key);
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        const GroupHeaderWidget(),
        widget,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            height: 70,
            width: double.infinity,
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Color(0xff673BB7),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: AppColors.primaryColorLight)
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'What do you want to talk about ?',
                        hintStyle: robotoStyle400Regular.copyWith(fontSize: 13)
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        const Divider(thickness: 1,color: Color(0xffE4E6EB)),
        PagePostView(
          description:
          'In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to the visual form of a commonly  to the ..In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to the visual form of a commonly  to the\nIn publishing and graphic design, Lorem ipsum is a placeholder text commonly used to the visual form of a commonly  to the',
          value: true,
          showDescription: () {
            // pageProvider.changeTextValue();
          },
        ),
      ],
    );
  }
}
