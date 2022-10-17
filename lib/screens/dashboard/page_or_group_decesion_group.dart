import 'package:als_frontend/old_code/const/palette.dart';
import 'package:als_frontend/screens/group/view/flag_group_view.dart';
import 'package:als_frontend/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PageOrGroupDecisionGroup extends StatelessWidget {
  const PageOrGroupDecisionGroup({Key? key}) : super(key: key);

  void openBottomSheet(BuildContext context){
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.18,
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            child: Column(
              children: [
                CustomButton(
                  btnTxt: 'Create a Group',
                  onTap: (){},
                  textWhiteColor: true,
                  radius: 5,
                  backgroundColor: Palette.primary,
                  isShowRightIcon: true,
                ),
                const SizedBox(height: 10),
                CustomButton(
                  btnTxt: 'Create a Page',
                  onTap: (){},
                  textWhiteColor: true,
                  radius: 5,
                  backgroundColor: Palette.notificationColor,
                  isShowRightIcon: true,
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // Provider.of<GroupProvider>(context, listen: false).initializeSuggestGroup();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Palette.scaffold,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 0,
            title: const Text(
              "FeedBack",
              style: TextStyle(color: Palette.primary, fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: -1.2),
            ),
          ),
          body: NestedScrollView(
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, innerBoxISScrolled) {
              return [
                SliverList(
                    delegate: SliverChildListDelegate([
                  SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: height * 0.035,
                            width: width * 0.7,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white54),
                            child: TabBar(
                              tabs: [
                                Text("Your Pages", style: GoogleFonts.lato(color: Colors.black)),
                                Text("Your Groups", style: GoogleFonts.lato(color: Colors.black)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]))
              ];
            },
            body: Container(
              height: height,
              width: width,
              color: Colors.white,
              child: TabBarView(children: [
                Container(),
                FlagGroupView(height: height, width: width),
              ]),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {openBottomSheet(context);},
            child: const Icon(Icons.add, color: Colors.white),
            backgroundColor: Palette.primary,
          ),
        ));
  }
}
