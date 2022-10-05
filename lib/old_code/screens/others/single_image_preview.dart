import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';

import '../../provider/provider.dart';

// class SingleImagePreview extends StatelessWidget {
//   SingleImagePreview({Key? key}) : super(key: key);

//   final urlImages = [
//     "https://meektecbacekend.s3.amazonaws.com/media/profile/image_picker6772086054507196796.png",
//     "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1200px-Image_created_with_a_mobile_phone.png",
//     "https://meektecbacekend.s3.amazonaws.com/media/post/image/image_picker2711369192416421990.jpg",
//     "https://meektecbacekend.s3.amazonaws.com/media/profile/image_picker6772086054507196796.png",
//     "https://meektecbacekend.s3.amazonaws.com/media/post/image/image_picker3425586063771089664.jpg"
//   ];

//   void saveImage(path) async {
//     await GallerySaver.saveImage(path, albumName: "feedback");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Consumer<PostImagesPreviewProvider>(
//           builder: (context, imagePreviewProvider, child) {
//           return Center(
//             child: InkWell(
//               child: Ink.image(
//                 image: NetworkImage(imagePreviewProvider.iamges.first),
//                 height: 300,
//               ),
//               onTap:()=> openGellary(),
//             ),
//           );
//         }
//       ),
//     );
//   }

//   void openGellary() => Get.to(() => GalleryWidget(urlImages: urlImages));
// }

class SingleImagePreview extends StatefulWidget {
  final List<dynamic> urlImages;
  // ignore: use_key_in_widget_constructors
  const SingleImagePreview({required this.urlImages});

  @override
  State<SingleImagePreview> createState() => _SingleImagePreviewState();
}

class _SingleImagePreviewState extends State<SingleImagePreview> {

  void saveImage(path) async {
    await GallerySaver.saveImage(path, albumName: "feedback");
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<PostImagesPreviewProvider>(
          builder: (context, imagePreviewProvider, child) {
        return Scaffold(
          body: InkWell(
            onLongPress: (){
              showModalBottomSheet(
                    context: context,
                    builder: (context) => ElevatedButton(
                        child: const Text("Download"),
                        onPressed: () {
                          saveImage(imagePreviewProvider.image);
                          print("downloaded");
                          Navigator.pop(context);
                        }
                        ));
            },
            child: PhotoViewGallery.builder(
                itemCount: imagePreviewProvider.iamges.length,
                builder: (context, index) {
                  final urlImage = imagePreviewProvider.iamges[index];
                  return PhotoViewGalleryPageOptions(
                      imageProvider: NetworkImage(urlImage));
                }),
          ),
        );
      }
    );
  }
}
