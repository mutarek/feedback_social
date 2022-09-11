import 'package:als_frontend/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../screens.dart';

class UserPhotosTab extends StatefulWidget {
  const UserPhotosTab({
    Key? key,
  }) : super(key: key);

  @override
  State<UserPhotosTab> createState() => _UserPhotosTabState();
}

class _UserPhotosTabState extends State<UserPhotosTab> {
  @override
  void initState() {
    final value = Provider.of<ProfileImagesProvider>(context, listen: false);
    value.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileImagesProvider>(builder: (context, provider, child) {
      return (provider.images == null)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
              ),
              itemCount: provider.images!.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    provider.imageUrl = provider.images![index].image;
                    Get.to(() => const SingleImageView());
                  },
                  child: Container(
                      color: Colors.grey,
                      child: Image.network(provider.images![index].image)),
                );
              },
            );
    });
  }
}
