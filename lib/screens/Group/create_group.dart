import 'package:als_frontend/const/palette.dart';
import 'package:als_frontend/provider/provider.dart';
import 'package:als_frontend/screens/tab_bar_view/flag.dart';
import 'package:als_frontend/widgets/card%20container/snackbar_message.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  _refresh() {
    final value = Provider.of<AllPageProvider>(context, listen: false);
    value.getData();
    final pageValue = Provider.of<AuthorPagesProvider>(context, listen: false);
    pageValue.getData();
    final value2 = Provider.of<AllGroupProvider>(context, listen: false);
    value2.getData();
    final value3 = Provider.of<AuthorGroupProvider>(context, listen: false);
    value3.getData();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController groupNameController = TextEditingController();

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Palette.scaffold,
        body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                // CastomAppbar(),
                Padding(
                  padding:
                      EdgeInsets.only(top: height * 0.06, left: width * 0.1),
                  child: Text(
                    "Group Catagory ",
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
                                width: width * 0.4,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF656B87),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Center(
                                  child: DropdownButton<String>(
                                    dropdownColor: Palette.primary,
                                    value: provider.catagoryValue,
                                    items: provider.items
                                        .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                color: Colors.white,
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
                    "Group name ",
                    style: GoogleFonts.lato(fontSize: height * 0.03),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: height * 0.03, left: width * 0.17),
                  child: Container(
                    height: height * 0.05,
                    width: width * 0.7,
                    decoration: BoxDecoration(
                        color: const Color(0xffEBF5FF),
                        borderRadius: BorderRadius.circular(5)),
                    child: TextField(
                      controller: groupNameController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green)),
                        alignLabelWithHint: true,
                        hintText: "input group Name",
                        hintStyle: GoogleFonts.lato(),
                      ),
                    ),
                  ),
                ),
                Consumer<CreateGroupProvider>(
                    builder: (context, provider, child) {
                  return Padding(
                    padding: EdgeInsets.only(top: height * 0.04),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          if (groupNameController.text.isEmpty) {
                            showMessage(
                              message: "Please fill all ther form",
                              context: context,
                            );
                          } else {
                            provider.creategroup(
                              groupNameController.text,
                              provider.catagoryValue,
                            );
                            if (provider.success == false) {
                              Fluttertoast.showToast(
                                  msg: "Group has been created");
                              _refresh();
                              Get.to(const Flag());
                            }
                            // Get.to(const AdminViewPage());
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
