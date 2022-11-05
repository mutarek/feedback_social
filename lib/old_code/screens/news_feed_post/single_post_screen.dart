import 'package:als_frontend/old_code/const/palette.dart';
import 'package:als_frontend/old_code/provider/post/like_comment_share_provider.dart';
import 'package:als_frontend/old_code/provider/post/single_post_provider.dart';
import 'package:als_frontend/old_code/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SinglePostScreen extends StatefulWidget {
  const SinglePostScreen({Key? key}) : super(key: key);

  @override
  State<SinglePostScreen> createState() => _SinglePostScreenState();
}

class _SinglePostScreenState extends State<SinglePostScreen> {
  // @override
  // void initState() {
  //   final value = Provider.of<SinglePostProvider>(context, listen: false);
  //   value.getUserData();
  //   super.initState();
  // }
  void refresh() {
    final value2 = Provider.of<SinglePostProvider>(context, listen: false);
    value2.getUserData();
  }

  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Consumer2<SinglePostProvider, LikeCommentShareProvider>(
        builder: (context, singlePostProvider, likeCommentProvider, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: (singlePostProvider.post == null)
            ? const Center(child: CircularProgressIndicator())
            : SafeArea(
                child: SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: height * 0.02, left: width * 0.03),
                        child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: CircleAvatar(
                              backgroundColor: Palette.primary,
                              radius: 17,
                              child: Icon(
                                FontAwesomeIcons.angleLeft,
                                color: Colors.white,
                                size: height * 0.03,
                              )),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: height * 0.02, left: width * 0.06),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 22,
                              child: CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(singlePostProvider
                                    .post.author.profileImage),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: height * 0.007,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    singlePostProvider.post.author.fullName,
                                    style: GoogleFonts.lato(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  ),
                                  Text(
                                    singlePostProvider.post.timestamp,
                                    style: GoogleFonts.lato(
                                        color: const Color(0xff9797BD),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 8),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: height * 0.01,
                            left: width * 0.06,
                            right: width * 0.04),
                        child: Text(
                          singlePostProvider.post.description,
                          style: GoogleFonts.lato(
                              fontWeight: FontWeight.w400, fontSize: 14),
                        ),
                      ),
                      GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              (singlePostProvider.post.images.length == 1)
                                  ? 1
                                  : 2,
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing: 5.0,
                        ),
                        itemCount: singlePostProvider.post.images.length,
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              (singlePostProvider.post.images.length == 1)
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                          left: width * 0.06,
                                          right: width * 0.1),
                                      child: Container(
                                        height: height * 0.4,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                singlePostProvider
                                                    .post.images[index].image,
                                              ),
                                              fit: BoxFit.cover,
                                            )),
                                      ),
                                    )
                                  : Expanded(
                                      child: Image.network(
                                        singlePostProvider
                                            .post.images[index].image,
                                        fit: BoxFit.fill,
                                      ),
                                    )
                            ],
                          );
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.03, right: width * 0.08),
                        child: LikeCommentCount(
                          editOnPressed: (){},
                          editText: const Icon(Icons.edit),
                          likeCount: singlePostProvider.post.totalLike,
                          commentCount: singlePostProvider.post.totalComment,
                          likeCountColor:
                              (singlePostProvider.post.like == false)
                                  ? Colors.black
                                  : Colors.red,
                          likeText: (singlePostProvider.post.like == false)
                              ? "Like"
                              : "liked",
                        ),
                      ),
                      LikeCommentShare(
                          index: 0,
                          likeText: (singlePostProvider.post.like == false)
                              ? "Like"
                              : "liked",
                          like: () {
                            likeCommentProvider.postId =
                                singlePostProvider.post.id.toString();
                            likeCommentProvider.like();
                            refresh();
                          },
                          comment: () {},
                          share: () {},
                          likeIconColor: (singlePostProvider.post.like == false)
                              ? Colors.black
                              : Colors.red),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: singlePostProvider.post.totalComment,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  top: height * 0.01,
                                  left: width * 0.03,
                                  right: width * 0.03,
                                  bottom: height * 0.01),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white30,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: height * 0.003,
                                              left: width * 0.01),
                                          child: CircleAvatar(
                                            radius: 18,
                                            backgroundColor:
                                                Palette.notificationColor,
                                            child: CircleAvatar(
                                              radius: 16,
                                              backgroundImage: NetworkImage(
                                                  singlePostProvider
                                                      .post
                                                      .comments[index]
                                                      .author
                                                      .profileImage),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: height * 0.01,
                                              left: width * 0.02),
                                          child: Text(
                                            "Full name",
                                              // "${singlePostProvider.post.comments[index].author.fullName}",
                                              style: GoogleFonts.lato(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14)),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: width * 0.13),
                                      child: Text(
                                          singlePostProvider
                                              .post.comments[index].addComment,
                                          style: GoogleFonts.lato(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12)),
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      )
                    ],
                  ),
                ),
              ),
        bottomSheet: Padding(
          padding: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
          child: Container(
            decoration: BoxDecoration(
                color: Palette.scaffold,
                borderRadius: BorderRadius.circular(40)),
            child: TextField(
              maxLines: null,
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      likeCommentProvider.postId =
                          singlePostProvider.post.id.toString();
                      likeCommentProvider.comment(commentController.text);
                      if (likeCommentProvider.success == true) {
                        commentController.text = "";
                        refresh();
                      }
                    },
                    icon: Icon(
                      FontAwesomeIcons.paperPlane,
                      color: Palette.primary,
                      size: height * 0.05 * .5,
                    ),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(
                      width * 0.04, height * 0.017, width * 0.02, 00),
                  hintText: "Comment",
                  hintStyle: GoogleFonts.lato(
                      fontWeight: FontWeight.w300, fontSize: 15),
                  border: InputBorder.none),
              controller: commentController,
            ),
          ),
        ),
      );
    });
  }
}
