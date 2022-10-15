import 'package:flutter/material.dart';

class EditProfileWidget extends StatelessWidget {
  const EditProfileWidget(
      {Key? key,
        this.iconName,
        required this.hintText,
        required this.controller})
      : super(key: key);

  final Icon? iconName;
  final String hintText;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: height * 0.05,
          width: width * 0.9,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: TextField(
            controller: controller,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
                border: InputBorder.none,


                prefixIcon: iconName,
                hintText: hintText,
                hintStyle: const TextStyle(color: Colors.black)

            ),
          ),
        ),
      ),
    );
  }
}
