import 'package:als_frontend/old_code/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../screens.dart';

class UpdateCoverPhoto extends StatelessWidget {
  const UpdateCoverPhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color.fromARGB(255, 68, 51, 51)),
          onPressed: () => Get.to(() => const ProfileScreen()),
        ),
      ),
      body: Consumer<UpdateCoverPhotProvider>(
          builder: (context, provider, child) {
        return ModalProgressHUD(
          inAsyncCall: provider.spinner,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Upload a profile picture",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ),
                (provider.image) == null
                    ? Image.network(
                        provider.imageUrl,
                        height: 200,
                        width: 200,
                      )
                    : Image.file(
                        provider.image!,
                        height: 200,
                        width: 200,
                      ),
                ElevatedButton(
                    onPressed: () => provider.pickImage(),
                    child: const Text("Pick image")),
                ElevatedButton(
                    onPressed: () => provider.uploadImage(),
                    child: const Text("Update"))
              ],
            ),
          ),
        );
      }),
    );
  }
}
