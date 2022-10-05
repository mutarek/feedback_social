import 'package:als_frontend/old_code/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../screens.dart';

class PostImagesPreview extends StatelessWidget {
  const PostImagesPreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PostImagesPreviewProvider>(
          builder: (context, imagePreviewProvider, child) {
        return (imagePreviewProvider.iamges.length == 1)
            ? Center(
                child: InkWell(
                onTap: () {
                  imagePreviewProvider.image = imagePreviewProvider.iamges[0];
                  Get.to(() =>  SingleImagePreview(urlImages: imagePreviewProvider.iamges));
                },
                child: SizedBox(
                    height: 400,
                    child: Image.network(imagePreviewProvider.iamges[0])),
              ))
            : ListView.builder(
                shrinkWrap: true,
                itemCount: imagePreviewProvider.iamges.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      imagePreviewProvider.image = "";
                      imagePreviewProvider.image =
                          imagePreviewProvider.iamges[index];
                          
                      Get.to(() =>  SingleImagePreview(
                          urlImages: imagePreviewProvider.iamges));
                    },
                    child: SizedBox(
                        height: 400,
                        child:
                            Image.network(imagePreviewProvider.iamges[index])),
                  );
                },
              );
      }),
    );
  }
}
