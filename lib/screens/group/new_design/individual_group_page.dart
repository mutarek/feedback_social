import 'package:als_frontend/provider/page_provider.dart';
import 'package:als_frontend/screens/group/new_design/joined_group_page.dart';
import 'package:als_frontend/screens/group/new_design/post_in_group.dart';
import 'package:als_frontend/screens/group/widget/group_header.dart';
import 'package:als_frontend/screens/page/view/page_about_view.dart';
import 'package:als_frontend/screens/page/view/page_home_view.dart';
import 'package:als_frontend/screens/page/widget/admin_post_view.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IndividualGroupPage extends StatefulWidget {
  const IndividualGroupPage({Key? key}) : super(key: key);

  @override
  State<IndividualGroupPage> createState() => _NewPageDetailsScreenState();
}

class _NewPageDetailsScreenState extends State<IndividualGroupPage> {
  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<PageProvider>(builder: (context, pageProvider, child) {
        return PageView(
          controller: _pageController,
          onPageChanged: (int i) {
            FocusScope.of(context).requestFocus(FocusNode());
            pageProvider.changeMenuValue(i);
          },
          physics: const BouncingScrollPhysics(),
          children: [
            PostInGroupScreen(tabMenuWidget(pageProvider)),
            // PageAboutView(tabMenuWidget(pageProvider),true,),
          ],
        );
      }),
    );
  }

  Widget tabMenuWidget(PageProvider pageProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // TODO: Post Container
          tabButtonWidget(0,"Posts",pageProvider),
          tabButtonWidget(1,"About",pageProvider),
          tabButtonWidget(2,"Media",pageProvider),
          tabButtonWidget(3,"People",pageProvider),
          tabButtonWidget(4,"Community",pageProvider,ratio: 3), // 1.5

        ],
      ),
    );
  }

  Widget tabButtonWidget(int status, String title, PageProvider pageProvider,{int ratio=2}) {
    return Expanded(
      flex: ratio,
      child: InkWell(
        onTap: () {
          _pageController.animateToPage(status, duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
          pageProvider.changeMenuValue(status);
        },
        child: Container(
          decoration: pageProvider.menuValue == status
              ? BoxDecoration(borderRadius: BorderRadius.circular(20), color: AppColors.primaryColorLight)
              : const BoxDecoration(),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(
              title,
              style:
              robotoStyle700Bold.copyWith(fontSize: 12, color: pageProvider.menuValue == status ? Colors.white : AppColors.primaryColorLight),
            ),
          ),
        ),
      ),
    );
  }

  ListView buildListView(PageProvider pageProvider, BuildContext context) {
    return ListView(
      children: [
        tabMenuWidget(pageProvider),
        SizedBox(
          height: 1000,
          child: PageView.builder(
            itemCount: 1,
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (int i) {
              FocusScope.of(context).requestFocus(FocusNode());
              pageProvider.changeMenuValue(i);
            },
            itemBuilder: (context, index) {
              return AdminPostView(
                dicription:
                'In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to the visual form of a commonly  to the ..In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to the visual form of a commonly  to the\nIn publishing and graphic design, Lorem ipsum is a placeholder text commonly used to the visual form of a commonly  to the',
                value: pageProvider.showMoreText,
                showDescription: () {
                  pageProvider.changeTextValue();
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
