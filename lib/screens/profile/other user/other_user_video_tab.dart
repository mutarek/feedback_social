import 'package:flutter/material.dart';

class OtherUserVideoTab extends StatelessWidget {
  const OtherUserVideoTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (context, index) {
            return const SizedBox(
              height: 50,
              child: Text(
                  "databiuerbrgiebrgberiugberbguerbgiuerbgjbvebvbeurbvjerbvubvjerbvevb iueubvuebbveubvb"),
            );
          }),
    );
  }
}
