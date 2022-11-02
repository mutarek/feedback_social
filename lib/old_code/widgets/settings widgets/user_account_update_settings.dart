import 'package:als_frontend/old_code/widgets/settings%20widgets/setteings_widget.dart';
import 'package:als_frontend/old_code/widgets/settings%20widgets/update_textfiled_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../const/palette.dart';
import '../../provider/provider.dart';
import '../../../widgets/snackbar_message.dart';

class UserAccountSettings extends StatefulWidget {
  const UserAccountSettings({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  State<UserAccountSettings> createState() => _UserAccountSettingsState();
}

class _UserAccountSettingsState extends State<UserAccountSettings> {
  DateTime _dateTime = DateTime.now();
  String dateTime = "";
  var buttonText = "Choose time";
  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(60),
            lastDate: DateTime.now())
        .then((value) {
      setState(() {
        _dateTime = value!;
        buttonText =
            "${_dateTime.year.toString()}-${_dateTime.month.toString()}-${_dateTime.day.toString()}";
        dateTime = buttonText;
      });
    });
  }

  TextEditingController updateNameContorller = TextEditingController();
  TextEditingController addMobileContorller = TextEditingController();
  TextEditingController lastNameContorller = TextEditingController();

  TextEditingController locationContorller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: ExpansionTile(
        title: SettingsWidget(
          width: widget.width,
          height: widget.height * 0.06,
          iconName: FontAwesomeIcons.user,
          boxName: "Your account",
          boxDetails:
              "See information about your account, download an archive of your data, or learn about your account deactivation options.",
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SettingTextField(
                  height: widget.height,
                  textFildName: "First Name",
                  controller: updateNameContorller,
                  hintText: "Update your Name",
                ),
                SizedBox(
                  height: widget.height * 0.01,
                ),
                SettingTextField(
                  height: widget.height,
                  textFildName: "Last Name",
                  controller: lastNameContorller,
                  hintText: "Last Name",
                ),
                SizedBox(
                  height: widget.height * 0.01,
                ),
                SizedBox(
                  height: widget.height * 0.01,
                ),
                SettingTextField(
                  height: widget.height,
                  textFildName: "Add Mobile Number",
                  controller: addMobileContorller,
                  hintText: "country Code and number please",
                ),
                SizedBox(
                  height: widget.height * 0.03,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 219, 221, 224),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.white30)),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: widget.width * 0.02),
                        child: const Text(
                          "Date of birth",
                          style: TextStyle(color: Colors.black54, fontSize: 17),
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      Container(
                        height: widget.height * 0.045,
                        width: widget.width * 0.4,
                        decoration: BoxDecoration(
                          color: Palette.primary,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: MaterialButton(
                          child: Text(
                            buttonText,
                            style: const TextStyle(color: Colors.white),
                          ),
                          onPressed: _showDatePicker,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: widget.height * 0.01,
                ),
                SettingTextField(
                  height: widget.height,
                  textFildName: "Your Location",
                  controller: locationContorller,
                  hintText: " Type your location",
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: widget.height * 0.01, left: widget.width * 0.3),
                  child: Consumer<UpdateAccountProvider>(
                      builder: (context, provider, child) {
                    return ElevatedButton(
                        onPressed: () {
                          if (provider.success = false) {
                            showMessage(
                              message: "User name already taken ",
                              context: context,
                            );
                          } else {
                            provider.loading = true;
                            provider.updateaccount(
                                updateNameContorller.text,
                                lastNameContorller.text,
                                addMobileContorller.text,
                                dateTime,
                                locationContorller.text);

                            if (provider.success == true) {
                              provider.loading = false;
                            }
                          }
                        },
                        child: Text(
                          "Update & Save",
                          style: GoogleFonts.lato(fontSize: 10),
                        ));
                  }),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
