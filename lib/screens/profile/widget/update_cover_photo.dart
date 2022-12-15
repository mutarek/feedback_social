import 'package:als_frontend/provider/other_provider.dart';
import 'package:als_frontend/provider/profile_provider.dart';
import 'package:als_frontend/screens/other/choose_image_and_crop_image_view.dart';
import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class UpdateCoverPhoto extends StatelessWidget {
  final bool isCoverPhotoUpload;

  const UpdateCoverPhoto({this.isCoverPhotoUpload = false, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text("${LocaleKeys.upload_a.tr()} ${isCoverPhotoUpload ? LocaleKeys.cover.tr(): LocaleKeys.profile.tr()} ${LocaleKeys.picture.tr()}", style: latoStyle800ExtraBold.copyWith(fontSize: 16)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color.fromARGB(255, 68, 51, 51)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Consumer2<ProfileProvider, OtherProvider>(builder: (context, profileProvider, otherProvider, child) {
        return ModalProgressHUD(
          inAsyncCall: profileProvider.isLoadingForUploadPhoto,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (otherProvider.selectedFile) == null
                    ? Expanded(
                        child: CachedNetworkImage(
                            imageUrl: isCoverPhotoUpload
                                ? profileProvider.userprofileData.coverImage!
                                : profileProvider.userprofileData.profileImage!))
                    : Expanded(child: Image.file(otherProvider.selectedFile!)),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => isCoverPhotoUpload
                              ? const ChooseImageAndCropImageView(16, 9, 640, 260)
                              : const ChooseImageAndCropImageView(1, 1, 128, 128)));
                    },
                    child:  Text(LocaleKeys.pick_image.tr())),
                ElevatedButton(
                    onPressed: () => profileProvider.uploadPhoto(
                          (bool status) {
                            if (status) {
                              Provider.of<OtherProvider>(context, listen: false).clearImage();
                              Navigator.of(context).pop();
                            }
                          },
                          otherProvider.selectedFile!,
                          isCover: isCoverPhotoUpload,
                        ),
                    child:  Text(LocaleKeys.update.tr()))
              ],
            ),
          ),
        );
      }),
    );
  }
}
