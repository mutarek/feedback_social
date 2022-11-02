import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../provider/provider.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class CreateNewPostScreen extends StatefulWidget {
  const CreateNewPostScreen({Key? key}) : super(key: key);

  @override
  State<CreateNewPostScreen> createState() => _CreateNewPostScreenState();
}

class _CreateNewPostScreenState extends State<CreateNewPostScreen> {
  TextEditingController postController = TextEditingController();
  File? image;

  @override
  void initState() {
    final profileDetails = Provider.of<ProfileDetailsProvider>(context, listen: false);
    profileDetails.getUserData();

    final createPost = Provider.of<CreatePostProvider>(context, listen: false);
    createPost.image = [];
    super.initState();
  }

  void refresh() {
    final data = Provider.of<NewsFeedPostProvider>(context, listen: false);
    data.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Consumer2<CreatePostProvider, UserProfileProvider>(builder: (context, provider, profileImage, child) {
                return CreatePostContainerWidget(
                  imageOnTap: () => Get.to(const ProfileScreen()),
                  postController: postController,
                  image: (profileImage.userprofileData.profileImage != null)
                      ? profileImage.userprofileData.profileImage!
                      : "https://meektecbacekend.s3.amazonaws.com/media/profile/default.jpeg",
                  onPhotoPressed: () {
                    provider.image.clear();
                    provider.pickImage();
                  },
                  onVideoPressed: () {
                    provider.pickVideo();
                  },
                  submit: () {
                    provider.createPost(postController.text);
                    if (provider.success == true) {
                      provider.image = [];
                      provider.video = null;
                    }
                    NewsFeedPostProvider().refresh();
                    setState(() {
                      postController.value = TextEditingValue.empty;
                    });

                    final data = Provider.of<NewsFeedPostProvider>(context, listen: false);
                    data.getData();
                    Get.off(() => const NavScreen());
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
