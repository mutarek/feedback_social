import 'package:als_frontend/const/palette.dart';
import 'package:als_frontend/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EditGroup extends StatefulWidget {
  const EditGroup({Key? key}) : super(key: key);

  @override
  State<EditGroup> createState() => _EditiGroupState();
}

class _EditiGroupState extends State<EditGroup> {
  TextEditingController nameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  @override
  void initState() {
    final value = Provider.of<GroupDetailsProvider>(context, listen: false);
    nameController.text = value.groupDetails.name;
    categoryController.text = value.groupDetails.category;
    value.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Consumer<EditGroupProvider>(builder: (context, provider, child) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: width * 0.03, right: width * 0.03),
            child: SafeArea(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: height * 0.04,
                        width: width * 0.09,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            border: Border.all(color: Colors.white, width: 2)),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: height * 0.001, left: width * 0.001),
                          child: Icon(
                            FontAwesomeIcons.angleLeft,
                            color: Palette.scaffold,
                            size: height * 0.026,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.3),
                    Text(
                      "change group name",
                      style: GoogleFonts.lato(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Container(
                      height: height * 0.04,
                      width: width,
                      decoration: BoxDecoration(
                          color: Palette.scaffold,
                          borderRadius: BorderRadius.circular(4)),
                      child: TextField(
                        controller: nameController,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(30),
                        ],
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "change group name"),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Text(
                      "change group catagory",
                      style: GoogleFonts.lato(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Container(
                      height: height * 0.04,
                      width: width,
                      decoration: BoxDecoration(
                          color: Palette.scaffold,
                          borderRadius: BorderRadius.circular(4)),
                      child: TextField(
                        controller: categoryController,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(30),
                        ],
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "change group catagory"),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Container(
                      width: width,
                      child: ElevatedButton(
                          child: const Text("Update"),
                          onPressed: () {
                            provider.editGroup(
                                nameController.text, categoryController.text);
                          }),
                    )
                  ]),
            ),
          ),
        );
      }),
    );
  }
}
