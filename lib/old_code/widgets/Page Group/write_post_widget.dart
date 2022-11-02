import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WritePostWidget extends StatelessWidget {
  const WritePostWidget({
    Key? key,
    required this.videoPost,
    required this.photoPost,
    required this.share,
    required this.textFieldWidget,
  }) : super(key: key);
  final VoidCallback photoPost;
  final VoidCallback videoPost;
  final VoidCallback share;
  final Widget textFieldWidget;
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return AspectRatio(
      aspectRatio: 5.9 / 2,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Row(
              children: [
                
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: textFieldWidget
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: height * 0.0299),
              child: Container(
                height: height * 0.04,
                width: width,
                decoration: const BoxDecoration(
                    color: Color(0xffEDF9FF),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    )),
                child: Row(
                  children: [
                    SizedBox(
                      width: width * 0.04,
                    ),
                    Icon(
                      FontAwesomeIcons.image,
                      size: height * 0.021,
                    ),
                    InkWell(onTap: photoPost, child: const Text("  Photo")),
                    SizedBox(
                      width: width * 0.06,
                    ),
                    InkWell(
                        onTap: videoPost,
                        child: Icon(
                          FontAwesomeIcons.video,
                          size: height * 0.021,
                        )),
                    const Text("  video"),
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.366),
                      child: InkWell(
                        onTap: share,
                        child: Container(
                            height: height,
                            width: width * 0.12,
                            decoration: const BoxDecoration(
                                color: Color(0xffC8EDFF),
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(5),
                                )),
                            child: Icon(FontAwesomeIcons.solidPaperPlane,
                                size: height * 0.021)),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
