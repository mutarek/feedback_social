import 'package:als_frontend/localization/language_constrants.dart';
import 'package:als_frontend/util/palette.dart';
import 'package:als_frontend/provider/public_profile_provider.dart';
import 'package:als_frontend/screens/home/view/video_details_screen.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:als_frontend/widgets/single_image_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class PublicPhotoViewScreen extends StatelessWidget {
  final String userID;
  final bool isForImage;

  const PublicPhotoViewScreen(this.userID, {this.isForImage = true, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isForImage) {
      Provider.of<PublicProfileProvider>(context, listen: false)
          .initializeUserAllImages(userID);
    } else {
      Provider.of<PublicProfileProvider>(context, listen: false)
          .initializeUserAllVideo(userID);
    }
    final double height = MediaQuery
        .of(context)
        .size
        .height;
    final double width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Center(
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  border: Border.all(color: Colors.white, width: 2)),
              child: Padding(
                padding: EdgeInsets.only(
                    top: height * 0.001, left: width * 0.001),
                child: Icon(FontAwesomeIcons.angleLeft, color: Palette.scaffold,
                    size: height * 0.026),
              ),
            ),
          ),
        ),
        title: CustomText(title: '${getTranslated("User", context)} ${isForImage
            ? getTranslated("Photos", context)
            : getTranslated("Videos", context)}${getTranslated(
            "Lists", context)}', color: Colors.black),
      ),
      body: Consumer<PublicProfileProvider>(
        builder: (context, publicProfileProvider, child) =>
        publicProfileProvider.isLoading
            ? const Center(child: CupertinoActivityIndicator())
            : GridView.builder(
            physics: const BouncingScrollPhysics(),
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, crossAxisSpacing: 5.0, mainAxisSpacing: 5.0),
            itemCount: isForImage
                ? publicProfileProvider.publicAllImages.length
                : publicProfileProvider.publicAllVideo.length,
            itemBuilder: (context, index) {
              return InkWell(
                  onTap: () {
                    if (isForImage) {
                      Get.to(() =>
                          SingleImageView(imageURL: publicProfileProvider
                              .publicAllImages[index].image));
                    } else {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) =>
                              VideoDetailsScreen(videoURL: publicProfileProvider
                                  .publicAllVideo[index].video)));
                    }
                  },
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(2)
                        ),
                        child: Center(
                          child: CachedNetworkImage(
                              imageUrl: isForImage
                                  ? publicProfileProvider.publicAllImages[index]
                                  .image
                                  : publicProfileProvider.publicAllVideo[index]
                                  .thumbnail!,
                              fit: BoxFit.cover,
                              height: 200,
                              placeholder: ((context, url) =>
                                  Container(
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                        "assets/background/loading.gif",
                                        height: 200),
                                  ))),
                        ),
                      ),
                      !isForImage
                          ? Positioned(
                        left: 0,
                        right: 0,
                        top: -30,
                        bottom: 0,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(color: Colors.white
                              .withOpacity(.3)),
                          child: Icon(Icons.video_collection_rounded,
                              color: Colors.grey.withOpacity(.7), size: 38),
                        ),
                      )
                          : const SizedBox.shrink()
                    ],
                  ));
            }),
      ),
    );
  }
}
