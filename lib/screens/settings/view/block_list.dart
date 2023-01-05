import 'package:als_frontend/provider/settings_provider.dart';
import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
              Helper.back();
            },
            child: const Icon(FontAwesomeIcons.angleLeft, size: 20, color: Colors.black)),
        title: Text(LocaleKeys.block_list.tr(), style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.black)),
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
                                          backgroundImage:CachedNetworkImageProvider(settingsProvider.blocklist[index].profileImage.toString())
                                          // NetworkImage("${settingsProvider.blocklist[index].profileImage}"),
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
                                          child:  Text(LocaleKeys.unblock.tr(), style: button)),
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
