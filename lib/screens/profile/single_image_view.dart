import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:provider/provider.dart';

import '../../provider/profile/profile_images_provider.dart';

class SingleImageView extends StatelessWidget {
  const SingleImageView({Key? key}) : super(key: key);

  void saveImage(path) async {
    await GallerySaver.saveImage(path, albumName: "feedback");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProfileImagesProvider>(
          builder: (context, imageProvider, child) {
        return InkWell(
          onLongPress: (){
            showModalBottomSheet(
                context: context,
                builder: (context) => ElevatedButton(
                    child: const Text("Download"),
                    onPressed: () {
                      saveImage(imageProvider.imageUrl);
                      Navigator.pop(context);
                    }));
          },
          child: Center(
            child: Image.network(imageProvider.imageUrl),
            
          ),
        );
      }),
    );
  }
}
