import 'package:als_frontend/provider/settings_provider.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BlockListUpdateSettings extends StatefulWidget {
  const BlockListUpdateSettings({Key? key}) : super(key: key);

  @override
  State<BlockListUpdateSettings> createState() => _BlockListUpdateSettingsState();
}

class _BlockListUpdateSettingsState extends State<BlockListUpdateSettings> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<SettingsProvider>(context, listen: false).initializeAllUserBlockData((bool status) {}, isFirstTime: true);
    Provider.of<SettingsProvider>(context, listen: false).blocklist;
    controller.addListener(() {
      if (controller.offset >= controller.position.maxScrollExtent &&
          !controller.position.outOfRange &&
          Provider.of<SettingsProvider>(context, listen: false).hasNextData) {
        Provider.of<SettingsProvider>(context, listen: false).updatePageNo();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xffFFFFFF),
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(FontAwesomeIcons.angleLeft, size: 20, color: Colors.black)),
        title: Text("Block List", style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.black)),
      ),
      body: SafeArea(
        child: Consumer<SettingsProvider>(builder: (context, settingsProvider, child) {
          return SingleChildScrollView(
            controller: controller,
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: settingsProvider.blocklist.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Material(
                            borderRadius: BorderRadius.circular(8),
                            elevation: 7,
                            child: Container(
                              height: height * 0.07,
                              width: width,
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.red,
                                    radius: 25,
                                    child: CircleAvatar(
                                      radius: 23,
                                      backgroundColor: Colors.grey,
                                      backgroundImage: NetworkImage("${settingsProvider.blocklist[index].profileImage}"),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "${settingsProvider.blocklist[index].fullName}",
                                    style: latoStyle500Medium,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red, elevation: 7),
                                      onPressed: () {},
                                      child: const Text(
                                        "Unblock",
                                        style: button,
                                      ))
                                ],
                              ),
                            ),
                          ),
                        );
                      })
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
