import 'package:als_frontend/widgets/custom_button.dart';
import 'package:als_frontend/widgets/network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';

class SingleImageView extends StatelessWidget {
  final String imageURL;

  const SingleImageView({this.imageURL = '', Key? key}) : super(key: key);

  void saveImage(path) async {
    bool? status = await GallerySaver.saveImage(path, albumName: "feedback");
    if (status!) {
      Fluttertoast.showToast(msg: "Save Successfully");
    } else {
      Fluttertoast.showToast(msg: "Failed to save Image");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(child: zoomableCustomNetworkImage(context, imageURL, height: 0)),
            Positioned(
              right: 10,
              top: 10,
              child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) => CustomButton(
                            btnTxt: 'Download',
                            textWhiteColor: true,
                            fontSize: 16,
                            radius: 2,
                            onTap: () {
                              saveImage(imageURL);
                              Navigator.pop(context);
                            }));
                  },
                  child: const CircleAvatar(backgroundColor: Colors.blue, child: Icon(Icons.save, color: Colors.white))),
            )
          ],
        ),
      ),
    );
  }
}
