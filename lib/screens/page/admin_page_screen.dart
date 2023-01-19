import 'package:als_frontend/provider/page_provider.dart';
import 'package:als_frontend/screens/page/widget/admin_post_view.dart';
import 'package:als_frontend/screens/page/widget/post_widget.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AdminPageScreen extends StatefulWidget {
  const AdminPageScreen({Key? key}) : super(key: key);

  @override
  State<AdminPageScreen> createState() => _AdminPageScreenState();
}

class _AdminPageScreenState extends State<AdminPageScreen> {
  @override
  void initState() {
    _pageController = PageController();
    super.initState();
    Provider.of<PageProvider>(context, listen: false).initializeAuthorPageLists();
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
        return ListView(
          children: [
            SafeArea(
              child: Stack(
                children: [
                  Container(
                    height: 215,
                    color: Colors.white,
                  ),
                  //TODO cover Photo.........
                  Container(
                    height: 170,
                    decoration: const BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10))),
                  ),
                  Positioned(
                    top: 115,
                    left: 18,
                    child: Container(
                      height: 90,
                      width: 90,
                      color: Colors.blue,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18),
              child: Text(
                "Abstract Graphics Studio",
                style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 22, color: AppColors.primaryColorLight),
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 18),
                child: Row(
                  children: [
                    Container(
                      height: 10,
                      width: 10,
                      decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primaryColorLight),
                      // child:  SvgPicture.asset("assets/svg/bookmark.svg",),
                    ),
                    const SizedBox(
                      width: 1,
                    ),
                    Text("Followers: 5M",
                        style: GoogleFonts.roboto(fontWeight: FontWeight.w700, fontSize: 9, color: AppColors.primaryColorLight)),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 10,
                      width: 10,
                      decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primaryColorLight),
                      // child:  SvgPicture.asset("assets/svg/bookmark.svg",),
                    ),
                    const SizedBox(
                      width: 1,
                    ),
                    Text("Following: 20",
                        style: GoogleFonts.roboto(fontWeight: FontWeight.w700, fontSize: 9, color: AppColors.primaryColorLight))
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 9,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18, right: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 35,
                    width: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), border: Border.all(width: 1.0), color: AppColors.imageBGColorLight),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.thumb_up,
                          size: 10,
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          "Like",
                          style: GoogleFonts.roboto(fontWeight: FontWeight.w700, fontSize: 10, color: AppColors.primaryColorLight),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 35,
                    width: 120,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.primaryColorLight),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.person_add,
                          size: 10,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          "Following",
                          style: GoogleFonts.roboto(fontWeight: FontWeight.w700, fontSize: 10, color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 35,
                    width: 65,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), border: Border.all(width: 1.0), color: AppColors.imageBGColorLight),
                    child: PopupMenuButton(
                      icon: const Icon(
                        Icons.more_horiz,
                        size: 15,
                      ),
                      itemBuilder: (context) => [
                        // PopupMenuItem 1
                        PopupMenuItem(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(
                                    "assets/svg/add.svg",
                                    height: 10,
                                    width: 20,
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    "Invites Friends",
                                    style:
                                    GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 12, color: AppColors.primaryColorLight),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // SvgPicture.asset("assets/svg/add.svg",height: 10,width:20,),
                                  const Icon(
                                    Icons.copy,
                                    size: 12,
                                    color: AppColors.primaryColorLight,
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    "Copy Link",
                                    style:
                                    GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 12, color: AppColors.primaryColorLight),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(
                                    "assets/svg/block.svg",
                                    height: 10,
                                    width: 20,
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    "Block",
                                    style:
                                    GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 12, color: AppColors.primaryColorLight),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        // PopupMenuItem 2
                      ],
                      offset: const Offset(0, 58),
                      color: Colors.white,
                      elevation: 4,
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 1,
            ),
            const Divider(
              thickness: 1.8,
              color: Color(0xffE4E6EB),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
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
                        )
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
                  return  AdminPostView(

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
      }),
    );
  }
}