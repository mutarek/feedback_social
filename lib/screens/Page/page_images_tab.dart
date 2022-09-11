import 'package:als_frontend/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageImagesTab extends StatefulWidget {
  const PageImagesTab({
    Key? key,
  }) : super(key: key);

  @override
  State<PageImagesTab> createState() => _PageImagesTabState();
}

class _PageImagesTabState extends State<PageImagesTab> {
  @override
  void initState() {
    final value = Provider.of<PageImagesProvider>(context, listen: false);
    value.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<PageImagesProvider, ProfileImagesProvider>(
        builder: (context, provider, profileImages, child) {
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
                    profileImages.imageUrl = provider.images![index].image;
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
