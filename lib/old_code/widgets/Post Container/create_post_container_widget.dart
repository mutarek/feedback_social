import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../provider/post/create_post_provider.dart';

// ignore: must_be_immutable
class CreatePostContainerWidget extends StatefulWidget {
  // final User? currentUser;
  TextEditingController postController = TextEditingController();
  String image;

  VoidCallback submit;
  VoidCallback imageOnTap;
  VoidCallback onPhotoPressed;
  VoidCallback onVideoPressed;
  CreatePostContainerWidget({
    Key? key,
    required this.onVideoPressed,
    required this.image,
    required this.postController,
    required this.submit,
    required this.imageOnTap,
    required this.onPhotoPressed,
  }) : super(key: key);

  @override
  State<CreatePostContainerWidget> createState() => _CreatePostContainerWidgetState();
}

class _CreatePostContainerWidgetState extends State<CreatePostContainerWidget> {
  File? image;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: width * 0.05, vertical: height * 0.14),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: const Color(0xffFFFFFF)),
      child: Column(children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: width * 0.015, top: height * 0.01),
              child: InkWell(
                onTap: widget.imageOnTap,
                child: CircleAvatar(
                  radius: 20.0,
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(widget.image),
                ),
              ),
            ),
            SizedBox(
              width: width * 0.015,
            ),
            Expanded(
              child: TextField(
                maxLines: null,
                controller: widget.postController,
                decoration: InputDecoration.collapsed(
                    hintText: "what's in your mind?",
                    hintStyle: GoogleFonts.lato()),
              ),
            )
          ],
        ),
        SizedBox(
          height: height * 0.02,
        ),
       
        SizedBox(
          height: height * 0.04,
        ),
        Container(
          color: const Color(0xffEDF9FF),
          height: height * 0.05,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                  onPressed: widget.onPhotoPressed,
                  icon: Icon(
                    FontAwesomeIcons.camera,
                    size: height * 0.02,
                  ),
                  label: Text("Photo", style: GoogleFonts.lato())),
              TextButton.icon(
                  onPressed: widget.onVideoPressed,
                  icon: Icon(
                    FontAwesomeIcons.video,
                    size: height * 0.02,
                  ),
                  label: Text("Video", style: GoogleFonts.lato())),
              SizedBox(
                width: width * 0.3,
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(5)),
                  color: Color(0xffC8EDFF),
                ),
                child: Center(
                  child: IconButton(
                    onPressed: widget.submit,
                    icon: Icon(
                      FontAwesomeIcons.paperPlane,
                      size: height * 0.02,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
         SizedBox(
          height: height * 0.4,
          child: Consumer<CreatePostProvider>(
              builder: (context, postProvider, snapshot) {
            return (postProvider.image.isEmpty)
                ? Container()
                : SingleChildScrollView(
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            postProvider.image.length == 1 ? 1 : 2,
                        crossAxisSpacing: 2.0,
                        mainAxisSpacing: 2.0,
                      ),
                      itemCount: postProvider.image.length,
                      itemBuilder: (context, index2) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.file(
                              File(postProvider.image[index2].path),
                              height: (postProvider.image.length == 1)
                                  ? height * 0.3
                                  : height * 0.2,
                              fit: BoxFit.fill,
                            )
                          ],
                        );
                      },
                    ),
                  );
          }),
        ),
      ]),
    );
  }
}
