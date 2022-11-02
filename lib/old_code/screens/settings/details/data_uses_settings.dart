import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../provider/provider.dart';
import '../../../../widgets/snackbar_message.dart';
import '../../../widgets/settings widgets/setteings_widget.dart';

class DataUses extends StatefulWidget {
  const DataUses({Key? key}) : super(key: key);

  @override
  State<DataUses> createState() => _DataUsesState();
}

class _DataUsesState extends State<DataUses> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Consumer3<DataUsesvalueProvider, AutoplayProvider, DatasaveProvider>(
        builder: (context, provalue, autoplay, datasaver, child) {
      return ExpansionTile(
        title: SettingsWidget(
          width: width,
          height: height * 0.02,
          iconName: FontAwesomeIcons.wifi,
          boxName: " Data Uses ",
          boxDetails: "Check data policy to save your data.",
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Autoplay",
                  style: GoogleFonts.lato(
                      fontWeight: FontWeight.w800, fontSize: 14),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Text(
                  "Select whether videos and GIFs should play automatically on this device. ",
                  style: GoogleFonts.lato(
                      fontWeight: FontWeight.w400, fontSize: 12),
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          provalue.onCellularbool();
                          if (autoplay.success = false) {
                            showMessage(
                              message: "Something went wrong",
                              context: context,
                            );
                          } else {
                            autoplay.loading = true;
                            autoplay.updateautoplay(
                                provalue.onCellular.toString(),
                                provalue.wifi.toString());

                            if (autoplay.success == true) {
                              autoplay.message;
                            }
                          }
                        },
                        icon: Icon(
                          (provalue.onCellular == false)
                              ? FontAwesomeIcons.square
                              : FontAwesomeIcons.squareCheck,
                          color: (provalue.onCellular == false)
                              ? Colors.red
                              : Colors.green,
                          size: 15,
                        )),
                    Text(
                      "On Cellular",
                      style: GoogleFonts.lato(),
                    )
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          provalue.wifibool();
                          if (autoplay.success = false) {
                            showMessage(
                              message: "Something went wrong",
                              context: context,
                            );
                          } else {
                            autoplay.loading = true;
                            autoplay.updateautoplay(
                                provalue.onCellular.toString(),
                                provalue.wifi.toString());

                            if (autoplay.success == true) {
                              autoplay.message;
                            }
                          }
                        },
                        icon: Icon(
                          (provalue.wifi == false)
                              ? FontAwesomeIcons.square
                              : FontAwesomeIcons.squareCheck,
                          color: (provalue.wifi == false)
                              ? Colors.red
                              : Colors.green,
                          size: 15,
                        )),
                    Text(
                      "Wi-Fi",
                      style: GoogleFonts.lato(),
                    )
                  ],
                ),
                Text(
                  "Data Saver ",
                  style: GoogleFonts.lato(
                      fontWeight: FontWeight.w800, fontSize: 14),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Text(
                  " If selected, it will consume less network data. ",
                  style: GoogleFonts.lato(
                      fontWeight: FontWeight.w400, fontSize: 12),
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          provalue.dataserverbool();
                          if (datasaver.success = false) {
                            showMessage(
                              message: "Something went wrong",
                              context: context,
                            );
                          } else {
                            datasaver.loading = true;
                            datasaver
                                .updatedatasave(provalue.dataserver.toString());

                            if (datasaver.success == true) {
                              datasaver.message;
                            }
                          }
                        },
                        icon: Icon(
                          (provalue.dataserver == false)
                              ? FontAwesomeIcons.square
                              : FontAwesomeIcons.squareCheck,
                          color: (provalue.dataserver == false)
                              ? Colors.red
                              : Colors.green,
                          size: 15,
                        )),
                    Text(
                      "Data saver",
                      style: GoogleFonts.lato(),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      );
    });
  }
}
