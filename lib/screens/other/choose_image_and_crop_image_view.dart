import 'package:als_frontend/provider/group_provider.dart';
import 'package:als_frontend/provider/other_provider.dart';
import 'package:als_frontend/provider/page_provider.dart';
import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ChooseImageAndCropImageView extends StatefulWidget {
  final double ratioX;
  final double ratioY;
  final int width;
  final int height;
  final bool isProfile;
  final bool isCover;
  final bool isPage;
  final bool isGroup;
  final int index;
  final int pageGroupID;

  const ChooseImageAndCropImageView(this.ratioX, this.ratioY, this.width, this.height,
      {this.isCover = false, this.isProfile = false, this.isGroup = false, this.index = 0, this.isPage = false, this.pageGroupID = 0, Key? key})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ChooseImageAndCropImageViewState createState() => _ChooseImageAndCropImageViewState();
}

class _ChooseImageAndCropImageViewState extends State<ChooseImageAndCropImageView> {
  @override
  Widget build(BuildContext context) {
    return Consumer3<OtherProvider, PageProvider, GroupProvider>(
        builder: (context, otherProvider, pageProvider, groupProvider, child) => Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              actions: [
                IconButton(
                    onPressed: () {
                      if (widget.isProfile == true) {
                        otherProvider.setProfile();
                      } else if (widget.isCover == true) {
                        otherProvider.setCover();
                      }


                      if (widget.isPage == true) {
                        pageProvider.updateCoverAndAvatar(widget.isCover ? otherProvider.pageCoverFile! : otherProvider.pageProfileFile,
                            widget.pageGroupID, widget.index, widget.isCover);
                      } else if (widget.isGroup == true) {
                        groupProvider.uploadGroupCover(otherProvider.pageCoverFile!, widget.pageGroupID, widget.index);
                      }


                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.download_done_rounded, color: Colors.black))
              ],
            ),
            body: Stack(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    otherProvider.selectedFile != null
                        ? Image.file(otherProvider.selectedFile!,
                            width: widget.width.toDouble(), height: widget.height.toDouble(), fit: BoxFit.fill)
                        : Image.asset("assets/background/profile_placeholder.jpg",
                            width: widget.width.toDouble(), height: widget.height.toDouble(), fit: BoxFit.fill),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        MaterialButton(
                            color: Colors.green,
                            child: Text(LocaleKeys.camera.tr(), style: const TextStyle(color: Colors.white)),
                            onPressed: () {
                              otherProvider.getImage(ImageSource.camera, widget.ratioX, widget.ratioY, widget.width, widget.height);
                            }),
                        MaterialButton(
                            color: Colors.deepOrange,
                            child: Text(LocaleKeys.device.tr(), style: const TextStyle(color: Colors.white)),
                            onPressed: () {
                              otherProvider.getImage(ImageSource.gallery, widget.ratioX, widget.ratioY, widget.width, widget.height);
                            })
                      ],
                    )
                  ],
                ),
              ],
            )));
  }
}
