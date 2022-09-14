import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gallery_saver/gallery_saver.dart';
import '../../provider/provider.dart';

class SingleImagePreview extends StatelessWidget {
  const SingleImagePreview({Key? key}) : super(key: key);

  void saveImage(path) async {
    await GallerySaver.saveImage(path, albumName: "feedback");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Consumer<PostImagesPreviewProvider>(
            builder: (context, imagePreviewProvider, child) {
          return InkWell(
            onLongPress: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) => ElevatedButton(
                      child: const Text("Download"),
                      onPressed: () {
                        saveImage(imagePreviewProvider.image);
                        print("downloaded");
                        Navigator.pop(context);
                      }));
            },
            child: Center(
              child: InteractiveViewer(
                maxScale: 5,
                child: Image.network(imagePreviewProvider.image),
              ),
            ),
          );
        }));
  }
}
