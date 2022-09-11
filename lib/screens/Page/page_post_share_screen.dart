import 'package:als_frontend/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class PagePostShareScreen extends StatelessWidget {
  const PagePostShareScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController descriptionController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Consumer<PageLikePostShareProvider>(
            builder: (context, postShare, child) {
          return Column(
            children: [
              const Center(
                child: Text("Share"),
              ),
              TextField(
                controller: descriptionController,
              ),
              ElevatedButton(
                  onPressed: () {
                    postShare.share(descriptionController.text);
                    if (postShare.success == true) {
                      Get.back();
                    }
                  },
                  child: const Text("Share"))
            ],
          );
        }),
      ),
    );
  }
}
