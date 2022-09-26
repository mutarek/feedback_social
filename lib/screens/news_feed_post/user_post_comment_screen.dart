// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import 'package:als_frontend/const/palette.dart';
import 'package:als_frontend/provider/provider.dart';
import 'package:als_frontend/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../screens.dart';

class UserPostCommentsScreen extends StatefulWidget {
  final WebSocketChannel channel = IOWebSocketChannel.connect(
      'wss://als-social.com/ws/post/10/comment/page_post/');

  UserPostCommentsScreen({Key? key}) : super(key: key);

  @override
  State<UserPostCommentsScreen> createState() =>
      _UserPostCommentsScreenState(channel: channel);
}

class _UserPostCommentsScreenState extends State<UserPostCommentsScreen> {
  List comments = [];
  List<Map> comment = [
    {
      "name": "dasdasdas",
      "image":
          "https://meektecbacekend.s3.amazonaws.com/media/post/image/R_2_YGl4y7y.jpeg",
      "comment": "asdadasdas"
    }
  ];
  final WebSocketChannel channel;
  _UserPostCommentsScreenState({required this.channel}) {
    channel.stream.listen((data) {
      print("websocket data: $data");
      comment.add({
        "name": "dasdasd",
        "image":
            "https://meektecbacekend.s3.amazonaws.com/media/post/image/R_2_YGl4y7y.jpeg",
        "comment": data
      });
      
  
    }, onDone: () {
      print("disconected");
    });
  }
  TextEditingController commentController = TextEditingController();

  Future<void> _refresh() async {
    
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          // body: Center(
          //   child: ElevatedButton(
          //     child: const Text("Press"),
          //     onPressed: () {
          //       channel.sink.add(jsonEncode({"description": "hello there"}));
          //     },
          //   ),
          // ),
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
                  Align(
                    alignment: Alignment.topCenter,
                    child: Consumer2<UserNewsfeedPostProvider,
                            ProfileDetailsProvider>(
                        builder: (context, provider, provider2, child) {
                      return ListView.builder(
                          itemCount: comment.length,
                          itemBuilder: (context, index) {
                            return (comment == null)
                                ? Container()
                                : SingleChildScrollView(
                                    physics: const ScrollPhysics(),
                                    child: CommentWidget(
                                      width: width,
                                      height: height,
                                      onTap: () {},
                                      image: comment[index]["image"],
                                      name: comment[index]["name"],
                                      comment: comment[index]["comment"],
                                    ));
                          });
                    }),
                  ),
                  Positioned.fill(
                      child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.03, bottom: height * 0.02),
                      child: Container(
                        height: height * 0.08,
                        width: width * 0.795,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: height * 0.01, left: width * 0.02),
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
                    child: Consumer<LikeCommentShareProvider>(
                        builder: (context, provider, child) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: height * 0.02),
                        child: SizedBox(
                          height: height * 0.079,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Palette.primary)),
                              onPressed: () {
                                channel.sink.add(
                                  jsonEncode(
                                  {
                                    "data": {
                                      "text": commentController.text
                                    }
                                  }
                                ),
                              );

                                comment.add({
                                  "name": "dasdasd",
                                  "image":
                                      "https://meektecbacekend.s3.amazonaws.com/media/post/image/R_2_YGl4y7y.jpeg",
                                  "comment": commentController.text
                                });
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

  @override
  void dispose() {
    commentController.dispose();
    channel.sink.close();
    super.dispose();
  }
}
