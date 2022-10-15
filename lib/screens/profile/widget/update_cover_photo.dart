import 'package:als_frontend/old_code/provider/provider.dart';
import 'package:als_frontend/provider/profile_provider.dart';
import 'package:als_frontend/screens/profile/profile_screen.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
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
        title: Text("Upload a ${isCoverPhotoUpload ? "Cover" : "Profile"} picture", style: latoStyle800ExtraBold.copyWith(fontSize: 16)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color.fromARGB(255, 68, 51, 51)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Consumer<ProfileProvider>(builder: (context, profileProvider, child) {
        return ModalProgressHUD(
          inAsyncCall: profileProvider.isLoadingForUploadPhoto,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (profileProvider.image) == null
                    ? Expanded(
                        child: CachedNetworkImage(
                            imageUrl: isCoverPhotoUpload
                                ? profileProvider.userprofileData.coverImage!
                                : profileProvider.userprofileData.profileImage!))
                    : Expanded(child: Image.file(profileProvider.image!)),
                ElevatedButton(onPressed: () => profileProvider.pickImage(), child: const Text("Pick image")),
                ElevatedButton(
                    onPressed: () => profileProvider.uploadPhoto((bool status) {
                          if (status) {
                            Navigator.of(context).pop();
                          }
                        }, isCover: isCoverPhotoUpload),
                    child: const Text("Update"))
              ],
            ),
          ),
        );
      }),
    );
  }
}
