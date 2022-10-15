import 'package:als_frontend/widgets/custom_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
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
        child: InkWell(
          onLongPress: () {
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
          child: CachedNetworkImage(
              imageUrl: imageURL,
              height: MediaQuery.of(context).size.height,
              imageBuilder: (context, imageProvider) =>
                  Container(decoration: BoxDecoration(image: DecorationImage(image: imageProvider, fit: BoxFit.fitWidth))),
              placeholder: ((context, url) => Container(
                    alignment: Alignment.center,
                    child: const CupertinoActivityIndicator(),
                  ))),
        ),
      ),
    );
  }
}
