import 'package:als_frontend/data/model/response/page/athour_pages_model.dart';
import 'package:als_frontend/provider/page_provider.dart';
import 'package:als_frontend/screens/page/view/page_about_view.dart';
import 'package:als_frontend/screens/page/view/page_home_view.dart';
import 'package:als_frontend/screens/page/view/page_upcomming_view.dart';
import 'package:als_frontend/screens/page/widget/admin_post_view.dart';
import 'package:als_frontend/screens/page/widget/page_photo_view.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewPageDetailsScreen extends StatefulWidget {
  final bool isAdmin;
  final AuthorPageModel authorPageModel;
  final int index;
  final bool isFromYourPage;

  const NewPageDetailsScreen(this.authorPageModel, {this.isAdmin = false, this.index = 0, this.isFromYourPage = false, Key? key})
      : super(key: key);

  @override
  State<NewPageDetailsScreen> createState() => _NewPageDetailsScreenState();
}

class _NewPageDetailsScreenState extends State<NewPageDetailsScreen> {
  @override
  void initState() {
    Provider.of<PageProvider>(context, listen: false).callForGetPageInformation(widget.authorPageModel.id.toString());
    Provider.of<PageProvider>(context, listen: false).callForGetAllPagePosts(widget.authorPageModel.id.toString());
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
        return pageProvider.isLoading || pageProvider.isLoadingPageDetails
            ? const Center(child: CircularProgressIndicator())
            : PageView(
                controller: _pageController,
                onPageChanged: (int i) {
                  FocusScope.of(context).requestFocus(FocusNode());
                  pageProvider.changeMenuValue(i);
                },
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  PageHomeView(tabMenuWidget(pageProvider), widget.authorPageModel, isAdmin: widget.isAdmin, index: widget.index),
                  PageAboutView(tabMenuWidget(pageProvider), widget.isAdmin, pageProvider.pageDetailsModel),
                  PagePhotoView(tabMenuWidget(pageProvider), widget.isAdmin),
                  PageUpcomingView(tabMenuWidget(pageProvider), widget.isAdmin, pageProvider.pageDetailsModel),
                  PageUpcomingView(tabMenuWidget(pageProvider), widget.isAdmin, pageProvider.pageDetailsModel),

                ],
              );
      }),
    );
  }

  Widget tabMenuWidget(PageProvider pageProvider) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // TODO: Post Container
          tabButtonWidget(0, "Home", pageProvider),
          tabButtonWidget(1, "About", pageProvider),
          tabButtonWidget(2, "Photos", pageProvider),
          tabButtonWidget(3, "Live", pageProvider),
          tabButtonWidget(4, "Community", pageProvider, ratio: 3), // 1.5
        ],
      ),
    );
  }

  Widget tabButtonWidget(int status, String title, PageProvider pageProvider, {int ratio = 2}) {
    return Expanded(
      flex: ratio,
      child: InkWell(
        onTap: () {
          _pageController.animateToPage(status, duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
          pageProvider.changeMenuValue(status);
        },
        child: Container(
          alignment: Alignment.center,
          decoration: pageProvider.menuValue == status
              ? BoxDecoration(borderRadius: BorderRadius.circular(20), color: AppColors.primaryColorLight)
              : const BoxDecoration(),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(
              title,
              style: robotoStyle700Bold.copyWith(
                  fontSize: 12, color: pageProvider.menuValue == status ? Colors.white : AppColors.primaryColorLight),
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
