import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PostHeader extends StatelessWidget {

  final VoidCallback delete;
  final VoidCallback edit;
  final VoidCallback reportThisPost;
  final String? name;
  final String? profileImage;
  final VoidCallback onProfileTap;
  final String? time;
  final String? postType;
  final String groupName;
  final String groupImage;
  final String pageName;
  final String pageRole;
  final String pageImage;
  final VoidCallback moreOnPressed;
  const PostHeader(
      {
      required this.delete,
      required this.edit,
      required this.reportThisPost,
      required this.name,
      required this.time,
      required this.profileImage,
      required this.onProfileTap,
      required this.postType,
      required this.moreOnPressed,
      this.groupImage = "",
      this.groupName = "",
      this.pageName = "",
      this.pageRole = "",
      this.pageImage = "",
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: onProfileTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (postType == "timeline")
                    ? CircleAvatar(
                        backgroundColor: Colors.grey,
                        backgroundImage: NetworkImage(profileImage!))
                    : (postType == "group")
                        ? CircleAvatar(
                            backgroundColor: Colors.red,
                            radius: 27,
                            backgroundImage: NetworkImage(groupImage),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 15.0, left: 15.0),
                              child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.grey,
                                  backgroundImage: NetworkImage(profileImage!)),
                            ),
                          )
                        : CircleAvatar(
                            backgroundColor: Colors.green,
                            backgroundImage: NetworkImage(pageImage)),
                Padding(
                  padding:
                      EdgeInsets.only(left: width * 0.02, top: height * 0.006),
                  child: (postType == "timeline")
                      ? Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name!,
                                  style: GoogleFonts.lato(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  time!,
                                  style: GoogleFonts.lato(
                                    fontSize: 8,
                                  ),
                                ),
                              ],
                            ),
                             
                          ],
                        )
                      : (postType == "group")
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  groupName,
                                  style: GoogleFonts.lato(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  name!,
                                  style: GoogleFonts.lato(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  time!,
                                  style: GoogleFonts.lato(
                                    fontSize: 8,
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  pageName,
                                  style: GoogleFonts.lato(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  pageRole,
                                  style: GoogleFonts.lato(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  time!,
                                  style: GoogleFonts.lato(
                                    fontSize: 8,
                                  ),
                                ),
                              ],
                            ),
                ),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
