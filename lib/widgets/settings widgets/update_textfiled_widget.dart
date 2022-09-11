import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingTextField extends StatelessWidget {
  SettingTextField(
      {Key? key,
      required this.height,
      required this.controller,
      required this.hintText,
      required this.textFildName})
      : super(key: key);

  final double height;
  String textFildName;
  String hintText;
  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          textFildName,
          style: GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: height * 0.013,
        ),
        Container(
          height: height * 0.05,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 219, 221, 224),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.white30)),
          child: TextField(
            controller: controller,
            inputFormatters: [
              LengthLimitingTextInputFormatter(35),
            ],
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              contentPadding: const EdgeInsets.fromLTRB(10, 0, 20.0, 10.0),
            ),
          ),
        )
      ],
    );
  }
}
