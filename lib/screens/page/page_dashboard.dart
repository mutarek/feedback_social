import 'dart:math';

import 'package:als_frontend/provider/page_provider.dart';
import 'package:als_frontend/screens/page/page_home_screen.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/snackbar_message.dart';
import 'new_design/edit_page/edit_page1.dart';

class PageDashboard extends StatefulWidget {
  const PageDashboard(this.pageId,{Key? key}) : super(key: key);
  final String pageId;

  @override
  State<PageDashboard> createState() => _PageDashboardState();
}

class _PageDashboardState extends State<PageDashboard> {
  final keyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(title: "Dashboard", color: AppColors.primaryColorLight, fontWeight: FontWeight.bold, fontSize: 24),
        backgroundColor: Colors.white,
        elevation: 0.3,
        centerTitle: true,
        leading: const BackButton(
          color: Colors.black, // <-- SEE HERE
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Consumer<PageProvider>(builder: (context, pageProvider, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  child: Container(
                    decoration: BoxDecoration(color: const Color(0xffF0F2F5), borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
                            child: SvgPicture.asset(
                              "assets/svg/invite_friends.svg",
                              height: 20,
                              width: 34,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Edit Page", style: robotoStyle700Bold.copyWith(fontSize: 22)),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: AppColors.primaryColorLight,
                            child: InkWell(
                                onTap: () {
                                  Helper.toScreen(EditPage1(widget.pageId));
                                },
                                child: const Icon(Icons.arrow_circle_right_rounded, color: Colors.white))
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  child: Container(
                    decoration: BoxDecoration(color: const Color(0xffF0F2F5), borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
                            child: SvgPicture.asset(
                              "assets/svg/invite_friends.svg",
                              height: 20,
                              width: 34,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Invites Friend", style: robotoStyle700Bold.copyWith(fontSize: 22)),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: AppColors.primaryColorLight,
                            child: InkWell(
                                onTap: () {
                                  pageProvider.changeExpended();
                                  showLog(pageProvider.pageExpended);
                                },
                                child: pageProvider.pageExpended != true
                                    ? const Icon(Icons.arrow_drop_down, color: Colors.white)
                                    : const Icon(Icons.arrow_drop_up, color: Colors.white)),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                pageProvider.pageExpended == true
                    ? SizedBox(
                        height: 250,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20, right: 20),
                                    child: Container(
                                      height: 48.0,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: AppColors.primaryColorLight),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: Row(
                                        children: [
                                          const Expanded(
                                            child: TextField(
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: "Search..",
                                                  hintStyle: TextStyle(color: Colors.black)),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(2),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(100), color: AppColors.primaryColorLight),
                                              height: 38,
                                              width: 71,
                                              child: Center(
                                                child: Text('Search',
                                                    style:
                                                        GoogleFonts.roboto(fontWeight: FontWeight.w300, fontSize: 12, color: Colors.white)),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                        itemCount: 10,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            leading: CircleAvatar(
                                              backgroundColor: index % 2 == 0 ? Colors.amber : Colors.teal,
                                            ),
                                            title: Text('Rafatul Islam',style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                color: AppColors.primaryColorLight),),
                                            trailing: Checkbox(
                                              value: index % 2 == 0 ? true : false,
                                              onChanged: (value) {},
                                            ),
                                          );
                                        }),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    height: 25,
                                    width: 250,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(45), color: AppColors.primaryColorLight),
                                    child: Center(
                                      child: Text('Send invitations',
                                          style: GoogleFonts.roboto(fontWeight: FontWeight.w700, fontSize: 13, color: Colors.white)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ))
                    : const SizedBox.shrink(),
                const SizedBox(height: 10),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  child: Container(
                    decoration: BoxDecoration(color: const Color(0xffF0F2F5), borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
                            child: SvgPicture.asset(
                              "assets/svg/page_access.svg",
                              height: 20,
                              width: 34,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Page Access", style: robotoStyle700Bold.copyWith(fontSize: 22)),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: AppColors.primaryColorLight,
                            child: InkWell(
                                onTap: () {
                                  pageProvider.changeAdminAccessExpanded();
                                },
                                child: pageProvider.adminAccessPage != true
                                    ? const Icon(Icons.arrow_drop_down, color: Colors.white)
                                    : const Icon(Icons.arrow_drop_up, color: Colors.white)),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                pageProvider.adminAccessPage == true
                    ? SizedBox(
                        height: 1000,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //TODO: FOR ADMIN SECTION
                            Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                              child: Container(
                                width: 260,
                                height: 38,
                                decoration: BoxDecoration(color: const Color(0xffF0F2F5), borderRadius: BorderRadius.circular(30)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Colors.white,
                                        child: SvgPicture.asset(
                                          "assets/svg/page_access.svg",
                                          height: 20,
                                          width: 34,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Admin Section", style: robotoStyle700Bold.copyWith(fontSize: 12)),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      CircleAvatar(
                                        radius: 15,
                                        backgroundColor: AppColors.primaryColorLight,
                                        child: InkWell(
                                            onTap: () {
                                              pageProvider.changeAdminSectionAccessExpanded();
                                            },
                                            child: pageProvider.adminSectionAccess != true
                                                ? const Icon(Icons.arrow_drop_down, color: Colors.white)
                                                : const Icon(Icons.arrow_drop_up, color: Colors.white)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            pageProvider.adminSectionAccess
                                ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 86,
                                        height: 21,
                                        decoration:
                                            BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.primaryColorLight),
                                        child: Center(
                                          child: Text(
                                            'Admin List',
                                            style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 12, color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: SizedBox(
                                          height: 80,
                                          width: 212,
                                          child: Expanded(
                                            child: ListView.builder(
                                                itemCount: 2,
                                                itemBuilder: (context, index) {
                                                  return SizedBox(
                                                    height: 35,
                                                    width: 150,
                                                    child: Card(
                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                        child: Container(
                                                          padding: const EdgeInsets.all(2),
                                                          child: Row(
                                                            children: [
                                                              const CircleAvatar(
                                                                backgroundColor: Colors.deepPurple,
                                                              ),
                                                              Expanded(
                                                                  child: Text('Rafayetul Islam',
                                                                      style: GoogleFonts.roboto(
                                                                          fontWeight: FontWeight.w700, fontSize: 11, color: Colors.black))),
                                                              const CircleAvatar(
                                                                backgroundColor: Colors.white,
                                                                child: Icon(
                                                                  Icons.more_horiz,
                                                                  color: Colors.black,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        )),
                                                  );
                                                }),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 86,
                                        height: 21,
                                        decoration:
                                            BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.primaryColorLight),
                                        child: Center(
                                          child: Text(
                                            'Add New',
                                            style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 12, color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox.shrink(),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20, right: 20),
                                child: Card(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 20, right: 20),
                                          child: Container(
                                            height: 48.0,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: AppColors.primaryColorLight),
                                              borderRadius: BorderRadius.circular(25),
                                            ),
                                            child: Row(
                                              children: [
                                                const Expanded(
                                                  child: TextField(
                                                    decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        hintText: "Search..",
                                                        hintStyle: TextStyle(color: Colors.black)),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(2),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(100), color: AppColors.primaryColorLight),
                                                    height: 38,
                                                    width: 71,
                                                    child: Center(
                                                      child: Text('Search',
                                                          style: GoogleFonts.roboto(
                                                              fontWeight: FontWeight.w300, fontSize: 12, color: Colors.white)),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Expanded(
                                          child: ListView.builder(
                                              itemCount: 10,
                                              itemBuilder: (context, index) {
                                                return ListTile(
                                                  leading: CircleAvatar(
                                                    backgroundColor: index % 2 == 0 ? Colors.amber : Colors.teal,
                                                  ),
                                                  title: const Text('Rafatul Islam'),
                                                  trailing: SizedBox(
                                                    height: 8,
                                                    width: 8,
                                                    child: Checkbox(
                                                      activeColor: Colors.black,
                                                      value: index % 2 == 0 ? true : false,
                                                      onChanged: (value) {},
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          height: 25,
                                          width: 250,
                                          decoration:
                                              BoxDecoration(borderRadius: BorderRadius.circular(45), color: AppColors.primaryColorLight),
                                          child: Center(
                                            child: Text('Make Admin',
                                                style: GoogleFonts.roboto(fontWeight: FontWeight.w700, fontSize: 13, color: Colors.white)),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                              child: Container(
                                width: 260,
                                height: 38,
                                decoration: BoxDecoration(color: const Color(0xffF0F2F5), borderRadius: BorderRadius.circular(30)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Colors.white,
                                        child: SvgPicture.asset(
                                          "assets/svg/page_access.svg",
                                          height: 20,
                                          width: 34,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Modarator Section", style: robotoStyle700Bold.copyWith(fontSize: 12)),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      CircleAvatar(
                                        radius: 15,
                                        backgroundColor: AppColors.primaryColorLight,
                                        child: InkWell(
                                            onTap: () {
                                              pageProvider.changeModeratorSectionAccessExpanded();
                                            },
                                            child: pageProvider.moderatorSectionAccess != true
                                                ? const Icon(Icons.arrow_drop_down, color: Colors.white)
                                                : const Icon(Icons.arrow_drop_up, color: Colors.white)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            pageProvider.moderatorSectionAccess
                                ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 86,
                                        height: 21,
                                        decoration:
                                            BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.primaryColorLight),
                                        child: Center(
                                          child: Text(
                                            'Moderator List',
                                            style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 12, color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: SizedBox(
                                          height: 80,
                                          width: 212,
                                          child: Expanded(
                                            child: ListView.builder(
                                                itemCount: 2,
                                                itemBuilder: (context, index) {
                                                  return SizedBox(
                                                    height: 35,
                                                    width: 150,
                                                    child: Card(
                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                        child: Container(
                                                          padding: const EdgeInsets.all(2),
                                                          child: Row(
                                                            children: [
                                                              const CircleAvatar(
                                                                backgroundColor: Colors.deepPurple,
                                                              ),
                                                              Expanded(
                                                                  child: Text('Rafayetul Islam',
                                                                      style: GoogleFonts.roboto(
                                                                          fontWeight: FontWeight.w700, fontSize: 11, color: Colors.black))),
                                                              const CircleAvatar(
                                                                backgroundColor: Colors.white,
                                                                child: Icon(
                                                                  Icons.more_horiz,
                                                                  color: Colors.black,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        )),
                                                  );
                                                }),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 86,
                                        height: 21,
                                        decoration:
                                            BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.primaryColorLight),
                                        child: Center(
                                          child: Text(
                                            'Add New',
                                            style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 12, color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox.shrink(),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20, right: 20),
                                child: Card(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 20, right: 20),
                                          child: Container(
                                            height: 48.0,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: AppColors.primaryColorLight),
                                              borderRadius: BorderRadius.circular(25),
                                            ),
                                            child: Row(
                                              children: [
                                                const Expanded(
                                                  child: TextField(
                                                    decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        hintText: "Search..",
                                                        hintStyle: TextStyle(color: Colors.black)),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(2),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(100), color: AppColors.primaryColorLight),
                                                    height: 38,
                                                    width: 71,
                                                    child: Center(
                                                      child: Text('Search',
                                                          style: GoogleFonts.roboto(
                                                              fontWeight: FontWeight.w300, fontSize: 12, color: Colors.white)),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Expanded(
                                          child: ListView.builder(
                                              itemCount: 10,
                                              itemBuilder: (context, index) {
                                                return ListTile(
                                                  leading: CircleAvatar(
                                                    backgroundColor: index % 2 == 0 ? Colors.amber : Colors.teal,
                                                  ),
                                                  title: const Text('Rafatul Islam'),
                                                  trailing: SizedBox(
                                                    height: 8,
                                                    width: 8,
                                                    child: Checkbox(
                                                      activeColor: Colors.black,
                                                      value: index % 2 == 0 ? true : false,
                                                      onChanged: (value) {},
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          height: 25,
                                          width: 250,
                                          decoration:
                                              BoxDecoration(borderRadius: BorderRadius.circular(45), color: AppColors.primaryColorLight),
                                          child: Center(
                                            child: Text('Make Moderator',
                                                style: GoogleFonts.roboto(fontWeight: FontWeight.w700, fontSize: 13, color: Colors.white)),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ))
                    : const SizedBox.shrink(),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  child: Container(
                    decoration: BoxDecoration(color: const Color(0xffF0F2F5), borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
                            child: SvgPicture.asset(
                              "assets/svg/invite_friends.svg",
                              height: 20,
                              width: 34,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("All follower", style: robotoStyle700Bold.copyWith(fontSize: 22)),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: AppColors.primaryColorLight,
                            child: InkWell(
                                onTap: () {
                                  pageProvider.changeAllFollowerExpanded();
                                  showLog(pageProvider.pageExpended);
                                },
                                child: pageProvider.allFollower != true
                                    ? const Icon(Icons.arrow_drop_down, color: Colors.white)
                                    : const Icon(Icons.arrow_drop_up, color: Colors.white)),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                pageProvider.allFollower
                    ? SizedBox(
                        height: 300,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
                              child: Column(
                                children: [
                                  // Padding(
                                  //   padding: EdgeInsets.only(left: 20, right: 20),
                                  //   child: Container(
                                  //     height: 48.0,
                                  //     width: double.infinity,
                                  //     decoration: BoxDecoration(
                                  //       border: Border.all(color: AppColors.primaryColorLight),
                                  //       borderRadius: BorderRadius.circular(25),
                                  //     ),
                                  //     child: Row(
                                  //       children: [
                                  //         Expanded(
                                  //           child: TextField(
                                  //             decoration: InputDecoration(
                                  //                 border: InputBorder.none,
                                  //                 hintText: "Search..",
                                  //                 hintStyle: TextStyle(color: Colors.black)),
                                  //           ),
                                  //         ),
                                  //         Padding(
                                  //           padding: EdgeInsets.all(2),
                                  //           child: Container(
                                  //             decoration: BoxDecoration(
                                  //                 borderRadius: BorderRadius.circular(100), color: AppColors.primaryColorLight),
                                  //             height: 38,
                                  //             width: 71,
                                  //             child: Center(
                                  //               child: Text('Search',
                                  //                   style:
                                  //                       GoogleFonts.roboto(fontWeight: FontWeight.w300, fontSize: 12, color: Colors.white)),
                                  //             ),
                                  //           ),
                                  //         )
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                        itemCount: 10,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            leading: CircleAvatar(
                                              backgroundColor: index % 2 == 0 ? Colors.amber : Colors.teal,
                                            ),
                                            title: Text('Rafatul Islam',style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                color: AppColors.primaryColorLight),),
                                          );
                                        }),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ))
                    : const SizedBox.shrink(),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  child: Container(
                    decoration: BoxDecoration(color: const Color(0xffF0F2F5), borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
                            child: SvgPicture.asset(
                              "assets/svg/invite_friends.svg",
                              height: 20,
                              width: 34,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Delete Page", style: robotoStyle700Bold.copyWith(fontSize: 20)),
                                Text("Once you delete a page, there is no going back. Please be certain.", style: robotoStyle700Bold.copyWith(fontSize: 8)),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          CircleAvatar(
                              radius: 15,
                              backgroundColor: AppColors.primaryColorLight,
                              child: InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          Random random =Random();
                                          int randomNumber = random.nextInt(90) + 10;
                                          return Dialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(20.0)), //this right here
                                            child: SizedBox(
                                              height: 300,
                                              width: double.infinity,
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(20.0)),
                                                child: Padding(
                                                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                        Text("Are you absolutely sure?", style: robotoStyle500Medium.copyWith(fontSize: 12)),
                                                        const Icon(Icons.auto_delete, color: Colors.red)
                                                      ]),
                                                      const Divider(thickness: 2, color: Colors.black),
                                                      Text(
                                                          "This action cannot be undone. This will permanently delete the mutarek/sasasas repository, wiki, issues, comments, packages, secrets, workflow runs, and remove all collaborator associations.",
                                                          style: robotoStyle400Regular.copyWith(fontSize: 16)),
                                                      const SizedBox(height: 10),
                                                      Text.rich(TextSpan(children: [
                                                        TextSpan(text: "Please Type", style: robotoStyle300Light.copyWith(fontSize: 12)),
                                                        TextSpan(text: " $randomNumber ", style: robotoStyle700Bold.copyWith(fontSize: 15)),
                                                        TextSpan(text: "To Confrim", style: robotoStyle300Light.copyWith(fontSize: 12)),
                                                      ])),
                                                      const SizedBox(height: 5),
                                                       CustomTextField(
                                                        hintText: 'Your Key Name',
                                                        isShowBorder: true,
                                                        borderRadius: 11,
                                                        verticalSize: 14,
                                                        controller: keyController,
                                                      ),
                                                      const SizedBox(height: 10),
                                                      CustomButton(
                                                        backgroundColor: Colors.red,
                                                          btnTxt: 'Delete Page',
                                                          onTap: () {
                                                            if (keyController.text == randomNumber.toString()) {
                                                              pageProvider.deleteSinglePage(widget.pageId, (status) {
                                                                if (status) {
                                                                  Helper.toScreen(const PageHomeScreen());
                                                                }
                                                              });
                                                            } else {
                                                              showMessage(message: 'Not Matched');
                                                            }
                                                          },
                                                          radius: 100,
                                                          height: 48)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: const Icon(Icons.arrow_circle_right_rounded, color: Colors.white))
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
