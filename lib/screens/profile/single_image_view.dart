import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/profile/profile_images_provider.dart';

class SingleImageView extends StatelessWidget {
  const SingleImageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProfileImagesProvider>(
          builder: (context, imageProvider, child) {
        return Center(
          child: Image.network(imageProvider.imageUrl),
          
        );
      }),
    );
  }
}
