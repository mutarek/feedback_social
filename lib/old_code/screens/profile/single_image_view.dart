import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
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
          child: CachedNetworkImage(
                imageUrl: imageProvider.imageUrl,
                imageBuilder: (context, imageProvider) => Container(
                                                                    
                decoration: BoxDecoration(
                image: DecorationImage(
                image:imageProvider,
                fit: BoxFit.fitWidth
                )
              )
            ),
            placeholder:
            ((context, url) =>
              Container(
              alignment: Alignment.center,
              child: const CupertinoActivityIndicator(),
              ))),
          
        );
      }),
    );
  }
}
