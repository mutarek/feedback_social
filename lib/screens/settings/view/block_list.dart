import 'package:als_frontend/localization/language_constrants.dart';
import 'package:als_frontend/provider/settings_provider.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
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
    Provider.of<SettingsProvider>(context, listen: false).initializeAllUserBlockData(isFirstTime: true);

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
        title: Text(getTranslated("Block List",context), style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.black)),
      ),
      body: SafeArea(
        child: Consumer<SettingsProvider>(builder: (context, settingsProvider, child) {
          return ModalProgressHUD(
            inAsyncCall: settingsProvider.isUnblockLoading,
            child: settingsProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    controller: controller,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: settingsProvider.blocklist.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(.2),
                                          blurRadius: 10.0,
                                          spreadRadius: 3.0,
                                          offset: const Offset(0.0, 0.0))
                                    ],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 10),
                                      CircleAvatar(
                                        backgroundColor: Colors.red,
                                        radius: 25,
                                        child: CircleAvatar(
                                          radius: 23,
                                          backgroundColor: Colors.grey,
                                          backgroundImage: NetworkImage("${settingsProvider.blocklist[index].profileImage}"),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(child: Text("${settingsProvider.blocklist[index].fullName}", style: latoStyle500Medium)),
                                      const SizedBox(width: 10),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red, elevation: 7),
                                          onPressed: () {
                                            settingsProvider.unblockUser(settingsProvider.blocklist[index].id, index);
                                          },
                                          child:  Text(getTranslated("Unblock", context), style: button)),
                                      const SizedBox(width: 10),
                                    ],
                                  ),
                                );
                              })
                        ],
                      ),
                    ),
                  ),
          );
        }),
      ),
    );
  }
}
