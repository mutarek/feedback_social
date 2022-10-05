
import 'package:flutter/material.dart';

class OnwerInfoWidget extends StatelessWidget {

final String? image;
final String? name;
   const OnwerInfoWidget({
    Key? key,
    required this.image,
    required this.name
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 35,
          backgroundImage: NetworkImage(image!,)
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            Text(
            name!,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
          ),
            const Text(
              "Owner",
              style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500
              ),
            )
          ],
        )
      ],
    );
  }
}