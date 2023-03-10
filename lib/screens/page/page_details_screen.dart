import 'package:als_frontend/provider/page_provider.dart';
import 'package:als_frontend/screens/page/shimmer_effect/new_page_details_screen_shimmer.dart';
import 'package:als_frontend/screens/page/view/page_about_view.dart';
import 'package:als_frontend/screens/page/view/page_home_view.dart';
import 'package:als_frontend/screens/page/view/page_upcomming_view.dart';
import 'package:als_frontend/screens/page/widget/page_photo_view.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class PageDetailsScreen extends StatefulWidget {

  final String pageID;
  final int index;

  const PageDetailsScreen(this.pageID, { this.index = 0, Key? key})
      : super(key: key);

  @override
  State<PageDetailsScreen> createState() => _PageDetailsScreenState();
}

class _PageDetailsScreenState extends State<PageDetailsScreen> {
  @override
  void initState() {
    Provider.of<PageProvider>(context, listen: false).callForGetPageInformation(widget.pageID.toString());
    Provider.of<PageProvider>(context, listen: false).callForGetAllPagePosts(widget.pageID.toString());
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
            ? const Center(child: NewPageDetailsShimmer())
            : ModalProgressHUD(
                inAsyncCall: pageProvider.isLoadingUpdateCover,
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (int i) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    pageProvider.changeMenuValue(i);
                  },
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    PageHomeView(tabMenuWidget(pageProvider), widget.pageID,index: widget.index),
                    PageAboutView(tabMenuWidget(pageProvider), pageProvider.pageDetailsModel),
                    PagePhotoView(tabMenuWidget(pageProvider)),
                    PageUpcomingView(tabMenuWidget(pageProvider),  pageProvider.pageDetailsModel),
                    PageUpcomingView(tabMenuWidget(pageProvider),  pageProvider.pageDetailsModel),
                  ],
                ),
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

}
