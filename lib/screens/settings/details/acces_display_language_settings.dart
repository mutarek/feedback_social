
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../const/palette.dart';
import '../../../provider/provider.dart';
import '../../../widgets/card container/snackbar_message.dart';
import '../../../widgets/settings widgets/privacy_safety_widget.dart';
import '../../../widgets/settings widgets/setteings_widget.dart';

class AccesDisplayLanguageSettings extends StatefulWidget {
  const AccesDisplayLanguageSettings({Key? key}) : super(key: key);

  @override
  State<AccesDisplayLanguageSettings> createState() =>
      _AccesDisplayLanguageSettingsState();
}

class _AccesDisplayLanguageSettingsState
    extends State<AccesDisplayLanguageSettings> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Consumer<AbilityProvider>(
        builder: (context, provalue, child) {
      return ExpansionTile(
        title: SettingsWidget(
          width: width,
          height: height * 0.04,
          iconName: FontAwesomeIcons.personCircleCheck,
          boxName: "Accessibility and languages  ",
          boxDetails: "Manage how content is displayed to you.",
        ),
        children: [
          Consumer<colorUpProvider>(
              builder: (context, incrsecolor, child) {
            return ExpansionTile(
              title: PrivacysafetyWidget(
                icon: FontAwesomeIcons.shield,
                name: "Accessibility",
                width: width,
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Manage aspects of your experience such as limiting color contrast and motion",
                    style: GoogleFonts.lato(
                        color: const Color.fromARGB(
                          45,
                          45,
                          45,
                          65,
                        ),
                        fontSize: 12),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          provalue.increaseColorbool();
                          if (incrsecolor.success = false) {
                            showMessage(
                              message: "Something went wrong",
                              context: context,
                            );
                          } else {
                            incrsecolor.loading = true;
                            incrsecolor.updateincrasecolor(
                                provalue.increaseColor.toString());

                            if (incrsecolor.success == true) {
                              incrsecolor.message;
                            }
                          }
                        },
                        icon: Icon(
                          (provalue.increaseColor == false)
                              ? FontAwesomeIcons.square
                              : FontAwesomeIcons.squareCheck,
                          color: (provalue.increaseColor == false)
                              ? Colors.red
                              : Colors.green,
                          size: 15,
                        )),
                    Text(
                      "Increase Color Contrast",
                      style: GoogleFonts.lato(),
                    )
                  ],
                ),
              ],
            );
          }),
          Consumer<DisplayProvider>(builder: (context, display, child) {
            return ExpansionTile(
              title: PrivacysafetyWidget(
                icon: FontAwesomeIcons.display,
                name: "Display ",
                width: width,
              ),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        const Icon(FontAwesomeIcons.display),
                        const Text("Default"),
                        IconButton(
                            onPressed: () {
                              provalue.defultbool();

                              if (display.success = false) {
                                showMessage(
                                  message: "Something went wrong",
                                  context: context,
                                );
                              } else {
                                display.loading = true;
                                display.updatedisplay(provalue.dark.toString(),
                                    provalue.defult.toString());

                                if (display.success == true) {
                                  display.message;
                                }
                              }
                            },
                            icon: Icon(
                              (provalue.defult == false)
                                  ? FontAwesomeIcons.square
                                  : FontAwesomeIcons.squareCheck,
                              color: (provalue.defult == false)
                                  ? Colors.red
                                  : Colors.green,
                              size: 15,
                            )),
                      ],
                    ),
                    SizedBox(
                      width: width * 0.07,
                    ),
                    Column(
                      children: [
                        const Icon(
                          FontAwesomeIcons.display,
                          color: Colors.black,
                        ),
                        const Text("Dark"),
                        IconButton(
                            onPressed: () {
                              provalue.darkbool();

                              if (display.success = false) {
                                showMessage(
                                  message: "Something went wrong",
                                  context: context,
                                );
                              } else {
                                display.loading = true;
                                display.updatedisplay(provalue.dark.toString(),
                                    provalue.defult.toString());

                                if (display.success == true) {
                                  display.message;
                                }
                              }
                            },
                            icon: Icon(
                              (provalue.dark == false)
                                  ? FontAwesomeIcons.square
                                  : FontAwesomeIcons.squareCheck,
                              color: (provalue.dark == false)
                                  ? Colors.red
                                  : Colors.green,
                              size: 15,
                            )),
                      ],
                    ),
                  ],
                ),
              ],
            );
          }),
          ExpansionTile(
            title: PrivacysafetyWidget(
              icon: FontAwesomeIcons.language,
              name: "Languages",
              width: width,
            ),
            children: [
              Container(
                height: height * 0.03,
                width: width * 0.3,
                decoration: BoxDecoration(
                    color: Palette.scaffold,
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                    child: Text(
                  "English",
                  style: GoogleFonts.lato(),
                )),
              )
            ],
          )
        ],
      );
    });
  }
}
