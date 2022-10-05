import 'package:flutter/material.dart';

class PostCardHeader extends StatelessWidget {
  const PostCardHeader({
    Key? key,
    required this.width,
    required this.image,
    required this.name,
  }) : super(key: key);

  final double width;
  final String name;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(image),
        ),
        SizedBox(
          width: width * 0.01,
        ),
        Text(
          name,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}
