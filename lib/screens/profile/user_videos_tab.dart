import 'package:als_frontend/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../screens.dart';

class UserVideoTab extends StatefulWidget {
  const UserVideoTab({
    Key? key,
  }) : super(key: key);

  @override
  State<UserVideoTab> createState() => _UserVideoTabState();
}

class _UserVideoTabState extends State<UserVideoTab> {
  @override
  void initState() {
    final value = Provider.of<ProfileVideosProvider>(context, listen: false);
    value.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ProfileVideosProvider, SingleVideoShowProvider>(builder: (context, provider,singleVideoProvider, child) {
      return (provider.videos == null)
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
              itemCount: provider.videos!.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    singleVideoProvider.videoUrl = provider.videos![index].video;
                    Get.to(() => const ShowVideoPage());
                  },
                  child: Container(
                      color: Colors.grey,
                      child: Image.asset("assets/background/video_pause.jpg")),
                );
              },
            );
    });
  }
}
