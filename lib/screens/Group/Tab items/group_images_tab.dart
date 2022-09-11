import 'package:als_frontend/provider/Group%20Page/Group/group_images_provider.dart';
import 'package:als_frontend/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupImagesTab extends StatefulWidget {
  const GroupImagesTab({
    Key? key,
  }) : super(key: key);

  @override
  State<GroupImagesTab> createState() => _GroupImagesTabState();
}

class _GroupImagesTabState extends State<GroupImagesTab> {
  @override
  void initState() {
    final value = Provider.of<GroupImagesProvider>(context, listen: false);
    value.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GroupImagesProvider>(builder: (context, provider, child) {
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
                return Container(
                    color: Colors.grey,
                    child: Image.network(provider.images![index].image));
              },
            );
    });
  }
}
