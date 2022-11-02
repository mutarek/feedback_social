
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class CreatePostContainer extends StatelessWidget {
  // final User? currentUser;
  TextEditingController postController = TextEditingController();
  String image;
  VoidCallback addAnimal;
  VoidCallback submit;
  VoidCallback imageOnTap;
  VoidCallback onPhotoPressed;
  VoidCallback onVideoPressed;
  CreatePostContainer({
    Key? key,
    required this.onVideoPressed,
    required this.image,
    required this.addAnimal,
    required this.postController,
    required this.submit,
    required this.imageOnTap,
    required this.onPhotoPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: width * 0.03, vertical: height * 0.015),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color:const Color(0xffFFFFFF)),
      child: Column(children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: width * 0.015,top: height*0.01),
              child: InkWell(
                onTap: imageOnTap,
                child: CircleAvatar(
                  radius: 20.0,
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(image),
                ),
              ),
            ),
            SizedBox(
              width: width * 0.015,
            ),
            Expanded(
              child: TextField(
                controller: postController,
                decoration:  InputDecoration.collapsed(
                    hintText: "what's in your mind?",hintStyle: GoogleFonts.lato()),
              ),
            )
          ],
        ),
       SizedBox(height: height*0.04,),
        Container(
          color: const Color(0xffEDF9FF),
          height: height * 0.05,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                  onPressed: addAnimal,
                  icon: Icon(FontAwesomeIcons.paw,size: height*0.02,),
                  label: Text("Add animal",style: GoogleFonts.lato(),)),
              TextButton.icon(
                  onPressed: onPhotoPressed,
                  icon:  Icon(
                    FontAwesomeIcons.camera,
                    size: height * 0.02,
                  ),
                  label: Text("Photo",style: GoogleFonts.lato())),
              TextButton.icon(
                  onPressed: onVideoPressed,
                  icon:  Icon(
                    FontAwesomeIcons.video,
                    size: height * 0.02,
                  ),
                  label: Text("Video",style: GoogleFonts.lato())),
              Container(
                decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(5)),
                  color: Color(0xffC8EDFF),
                ),
                child: Center(
                  child: IconButton(
                    onPressed: submit,
                    icon:  Icon(
                      FontAwesomeIcons.paperPlane,
                      size: height * 0.02,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
