import 'package:als_frontend/const/palette.dart';
import 'package:als_frontend/provider/provider.dart';
import 'package:als_frontend/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class Flag extends StatefulWidget {
  const Flag({Key? key}) : super(key: key);

  @override
  State<Flag> createState() => _FlagState();
}

class _FlagState extends State<Flag> {
  @override
  void initState() {
    final value = Provider.of<AllPageProvider>(context, listen: false);
    value.getData();
    final pageValue = Provider.of<AuthorPagesProvider>(context, listen: false);
    pageValue.getData();
    final value2 = Provider.of<AllGroupProvider>(context, listen: false);
    value2.getData();
    final value3 = Provider.of<AuthorGroupProvider>(context, listen: false);
    value3.getData();

    final notification =
        Provider.of<NotificationsProvider>(context, listen: false);
    notification.getData();
    notification.check();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                style: TextStyle(
                    color: Palette.primary,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1.2),
              ),
              actions: [
                CustomIconButton(iconName: Icons.search, onPressed: () {}),
                CustomIconButton(
                    iconName: MdiIcons.facebookMessenger, onPressed: () {}),
              ],
            ),
            body: NestedScrollView(
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              // Setting floatHeaderSlivers to true is required in order to float
              // the outer slivers over the inner scrollable.
              floatHeaderSlivers: true,

              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
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
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white54),
                              child: TabBar(
                                tabs: [
                                  Text("Your Pages",
                                      style: GoogleFonts.lato(
                                          color: Colors.black)),
                                  Text("Your Groups",
                                      style: GoogleFonts.lato(
                                          color: Colors.black)),
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
                  FlagPageWidget(height: height, width: width),
                  FlagGroupWidget(height: height, width: width)
                ]),
              ),
            )));
  }
}
