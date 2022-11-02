import 'package:als_frontend/old_code/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupvideosTab extends StatefulWidget {
  const GroupvideosTab({
    Key? key,
  }) : super(key: key);

  @override
  State<GroupvideosTab> createState() => _GroupvideosTabState();
}

class _GroupvideosTabState extends State<GroupvideosTab> {
  @override
  void initState() {
    final value = Provider.of<GroupVideoProvider>(context, listen: false);
    value.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<GroupVideoProvider, ProfileImagesProvider>(
        builder: (context, provider, profileImages, child) {
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
                    profileImages.imageUrl = provider.videos![index].video;
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
