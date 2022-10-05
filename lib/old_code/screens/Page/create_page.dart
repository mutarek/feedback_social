import 'package:als_frontend/old_code/const/palette.dart';
import 'package:als_frontend/old_code/provider/provider.dart';
import 'package:als_frontend/old_code/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CreatPage extends StatefulWidget {
  const CreatPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CreatPage> createState() => _CreatPageState();
}

class _CreatPageState extends State<CreatPage> {
  _refresh() {
    final value = Provider.of<AllPageProvider>(context, listen: false);
    value.getData();
  }

  @override
  void initState() {
    _refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController pageNameController = TextEditingController();

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Palette.scaffold,
        body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Padding(
                  padding:
                      EdgeInsets.only(top: height * 0.06, left: width * 0.1),
                  child: Text(
                    "Page Catagory ",
                    style: GoogleFonts.lato(fontSize: height * 0.03),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: height * 0.03,
                  ),
                  child: Container(
                      height: height * 0.06,
                      color: Palette.primary,
                      child: Consumer<CreatePageProvider>(
                          builder: (context, provider, child) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(29.0, 5, 25, 5),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: width * 0.1),
                                child: const Text(
                                  "Pick up",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                              SizedBox(
                                width: width * 0.16,
                              ),
                              Container(
                                // height: height * 0.0001,
                                width: width * 0.4,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF656B87),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),

                                child: Center(
                                  child: DropdownButton<String>(
                                    dropdownColor: const Color.fromARGB(
                                        255, 248, 245, 245),
                                    value: provider.catagoryValue,
                                    items: provider.items
                                        .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            )))
                                        .toList(),
                                    onChanged: (item) {
                                      setState(() {
                                        provider.catagoryValue = item!;
                                      });
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      })),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: height * 0.06, left: width * 0.1),
                  child: Text(
                    "Page name ",
                    style: GoogleFonts.lato(fontSize: height * 0.03),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: height * 0.03, left: width * 0.17),
                  child: Container(
                    width: width * 0.7,
                    decoration: BoxDecoration(
                        color: const Color(0xffEBF5FF),
                        borderRadius: BorderRadius.circular(5)),
                    child: TextFormField(
                      controller: pageNameController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: const OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.green)),
                        hintText: "input Page Name",
                        hintStyle: GoogleFonts.lato(),
                      ),
                    ),
                  ),
                ),
                Consumer<CreatePageProvider>(
                    builder: (context, provider, child) {
                  return Padding(
                    padding: EdgeInsets.only(top: height * 0.04),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          if (pageNameController.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Please fill all ther form");
                          } else {
                            provider.createpage(
                              pageNameController.text,
                              provider.catagoryValue,
                            );

                            Get.to(const Flag());
                            _refresh();
                          }
                        },
                        child: Container(
                            height: height * 0.037,
                            width: width * 0.4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              gradient: const LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                stops: [
                                  0.1,
                                  0.7,
                                ],
                                colors: [
                                  Palette.primary,
                                  Palette.notificationColor,
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Palette.primary.withOpacity(0.4),
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  offset: const Offset(
                                      0, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Center(
                                child: Text("Submit",
                                    style: GoogleFonts.lato(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white)))),
                      ),
                    ),
                  );
                }),
              ])),
        ));
  }
}
