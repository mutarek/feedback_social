// ignore_for_file: unnecessary_null_comparison

import 'package:als_frontend/old_code/const/palette.dart';
import 'package:als_frontend/old_code/provider/provider.dart';
import 'package:als_frontend/old_code/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import '../screens.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({Key? key}) : super(key: key);

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  TextEditingController commentController = TextEditingController();

  Future<void> _refresh() async {
    // final data = Provider.of<NewsFeedPostProvider>(context, listen: false);
    // data.getData();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Palette.scaffold,
            centerTitle: true,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                FontAwesomeIcons.arrowLeft,
                color: Palette.primary,
              ),
            ),
          ),
          backgroundColor: Palette.scaffold,
          body: RefreshIndicator(
            onRefresh: _refresh,
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Stack(
                children: [
                  // Align(
                  //   alignment: Alignment.topCenter,
                  //   child: Consumer2<NewsFeedPostProvider, ProfileDetailsProvider>(builder: (context, provider, provider2, child) {
                  //     return ListView.builder(
                  //         itemCount: provider.results[provider.index].comments!.length,
                  //         itemBuilder: (context, index) {
                  //           return (provider.results[provider.index].comments![index] == null)
                  //               ? Container()
                  //               : SingleChildScrollView(
                  //                   physics: const ScrollPhysics(),
                  //                   child: CommentWidget(
                  //                       width: width,
                  //                       height: height,
                  //                       onTap: () {
                  //                         provider2.id = provider.posts![provider.index].comments[index]["user"];
                  //                         (provider.results[provider.index].comments![index].author!.id == provider2.userId)
                  //                             ? Get.to(() => const PublicProfileDetailsScreen())
                  //                             : Get.to(() => const PublicProfileDetailsScreen());
                  //                       },
                  //                       image: "${provider.results[provider.index].comments![index].author!.profileImage}",
                  //                       name:
                  //                           "${provider.results[provider.index].comments![index].author!.firstName!} ${provider.results[provider.index].comments![index].author!.lastName!}",
                  //                       comment: provider.results[provider.index].comments![index].comment!),
                  //                 );
                  //         });
                  //   }),
                  // ),
                  Positioned.fill(
                      child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: width * 0.03, bottom: height * 0.02),
                      child: Container(
                        height: height * 0.08,
                        width: width * 0.795,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(top: height * 0.01, left: width * 0.02),
                          child: TextField(
                            textAlign: TextAlign.start,
                            controller: commentController,
                            decoration: const InputDecoration.collapsed(
                              hintText: "Comment here..",
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),
                  Positioned.fill(
                      child: Align(
                    alignment: Alignment.bottomRight,
                    child: Consumer<LikeCommentShareProvider>(builder: (context, provider, child) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: height * 0.02),
                        child: SizedBox(
                          height: height * 0.079,
                          child: ElevatedButton(
                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Palette.primary)),
                              onPressed: () {
                                provider.comment(commentController.text);
                                _refresh();
                                commentController.text = "";
                                FocusScope.of(context).unfocus();
                              },
                              child: const Icon(FontAwesomeIcons.paperPlane)),
                        ),
                      );
                    }),
                  ))
                ],
              ),
            ),
          )),
    );
  }
}
