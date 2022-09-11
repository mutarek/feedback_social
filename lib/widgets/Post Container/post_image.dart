import 'package:flutter/material.dart';

class PostImage extends StatelessWidget {

   final Widget? image;
   final double? imageHeight;
   final VoidCallback largeImage;
  const PostImage(
    {
      this.image,
      required this.imageHeight,
      required this.largeImage,
      Key? key
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: largeImage,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child:Container(
            height: imageHeight,
            width: double.maxFinite,
            child: image,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius:const BorderRadius.all(Radius.circular(13))
        
            ),
          ),
      ),
    );
  }
}

