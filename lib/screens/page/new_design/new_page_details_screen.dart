import 'package:als_frontend/provider/page_provider.dart';
import 'package:als_frontend/screens/page/view/page_about_view.dart';
import 'package:als_frontend/screens/page/view/page_home_view.dart';
import 'package:als_frontend/screens/page/widget/admin_post_view.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NewPageDetailsScreen extends StatefulWidget {
  const NewPageDetailsScreen({Key? key}) : super(key: key);

  @override
  State<NewPageDetailsScreen> createState() => _NewPageDetailsScreenState();
}

class _NewPageDetailsScreenState extends State<NewPageDetailsScreen> {
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
            PageHomeView(tabMenuWidget(pageProvider)),
            PageAboutView(tabMenuWidget(pageProvider)),
          ],
        );
      }),
    );
  }

  Widget tabMenuWidget(PageProvider pageProvider) {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // TODO: Post Container
          InkWell(
            onTap: () {
              _pageController.animateToPage(0, duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
              pageProvider.changeMenuValue(0);
            },
            child: Container(
              decoration: pageProvider.menuValue == 0
                  ? BoxDecoration(borderRadius: BorderRadius.circular(20), color: AppColors.primaryColorLight)
                  : const BoxDecoration(),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  "Posts",
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: pageProvider.menuValue == 0 ? Colors.white : AppColors.primaryColorLight),
                ),
              ),
            ),
          ),

          // TODO: about Container
          InkWell(
            onTap: () {
              _pageController.animateToPage(1, duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
              pageProvider.changeMenuValue(1);
            },
            child: Container(
              decoration: pageProvider.menuValue == 1
                  ? BoxDecoration(borderRadius: BorderRadius.circular(20), color: AppColors.primaryColorLight)
                  : const BoxDecoration(),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  "About",
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: pageProvider.menuValue == 1 ? Colors.white : AppColors.primaryColorLight),
                ),
              ),
            ),
          ),
          // TODO: Photos Container
          InkWell(
            onTap: () {
              _pageController.animateToPage(2, duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
              pageProvider.changeMenuValue(2);
            },
            child: Container(
              decoration: pageProvider.menuValue == 2
                  ? BoxDecoration(borderRadius: BorderRadius.circular(20), color: AppColors.primaryColorLight)
                  : const BoxDecoration(),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  "Photos",
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: pageProvider.menuValue == 2 ? Colors.white : AppColors.primaryColorLight),
                ),
              ),
            ),
          ),
          // TODO: Live Container
          InkWell(
            onTap: () {
              _pageController.animateToPage(3, duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
              pageProvider.changeMenuValue(3);
            },
            child: Container(
              decoration: pageProvider.menuValue == 3
                  ? BoxDecoration(borderRadius: BorderRadius.circular(20), color: AppColors.primaryColorLight)
                  : const BoxDecoration(),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  "Live",
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: pageProvider.menuValue == 3 ? Colors.white : AppColors.primaryColorLight),
                ),
              ),
            ),
          ),
          // TODO: Community Container
          InkWell(
            onTap: () {
              _pageController.animateToPage(4, duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
              pageProvider.changeMenuValue(4);
            },
            child: Container(
              decoration: pageProvider.menuValue == 4
                  ? BoxDecoration(borderRadius: BorderRadius.circular(20), color: AppColors.primaryColorLight)
                  : const BoxDecoration(),
              child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    "Manage",
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        color: pageProvider.menuValue == 4 ? Colors.white : AppColors.primaryColorLight),
                  )),
            ),
          ),
        ],
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
