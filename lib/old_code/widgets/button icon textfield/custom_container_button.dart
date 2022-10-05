import 'package:flutter/material.dart';

import '../../const/palette.dart';

// ignore: must_be_immutable
class CustomConatinerButton extends StatelessWidget {
  VoidCallback ontap;
  Widget child;
  CustomConatinerButton({
    required this.ontap,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 60,
        width: 60,
        child: child,
        decoration: BoxDecoration(
            color: Palette.primary,
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            border: Border.all(
              color: Colors.white,
              width: 2.5,
            )),
      ),
    );
  }
}
