import 'package:als_frontend/old_code/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../const/palette.dart';

class SharePostScreen extends StatelessWidget {
  const SharePostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    TextEditingController descriptionController = TextEditingController();
    return Scaffold(
      backgroundColor: Palette.scaffold,
      body: SafeArea(
        child: Consumer<ShareTimeLinePostProvider>(
            builder: (context, postShareProvider, child) {
          return SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(top: height * 0.02, left: width * 0.03),
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: CircleAvatar(
                        backgroundColor: Palette.primary,
                        radius: 17,
                        child: Icon(
                          FontAwesomeIcons.angleLeft,
                          color: Colors.white,
                          size: height * 0.03,
                        )),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: height * 0.02, left: width * 0.06),
                  child: Text(
                    "Share",
                    style: GoogleFonts.lato(
                        fontWeight: FontWeight.w500, fontSize: 23),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: height * 0.02,
                    left: width * 0.06,
                    right: width * 0.06,
                  ),
                  child: Container(
                    height: height * 0.45,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      maxLines: null,
                      controller: descriptionController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(
                              width * 0.04, height * 0.017, width * 0.02, 00),
                          hintStyle: GoogleFonts.lato(
                              fontWeight: FontWeight.w300, fontSize: 15),
                          hintText: "Want to write something before share",
                          suffixIcon: Icon(
                            FontAwesomeIcons.pen,
                            size: 13,
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          postShareProvider
                              .sharePost(descriptionController.text);
                          if (postShareProvider.success == true) {
                            Get.back();
                          }
                        },
                        child: const Text("Share")),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
