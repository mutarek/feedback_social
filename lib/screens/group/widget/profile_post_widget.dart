import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:als_frontend/util/palette.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostWidget extends StatelessWidget {
  const PostWidget(
      {Key? key,
      required this.userProfilePhoto,
      required this.videoPost,
      required this.photoPost,
      required this.share,
      required this.writingContoller})
      : super(key: key);

  final VoidCallback photoPost;
  final VoidCallback videoPost;
  final VoidCallback share;
  final String userProfilePhoto;
  final TextEditingController writingContoller;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Card(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: height * 0.025,
              backgroundColor: Palette.primary,
              child: CircleAvatar(
                radius: height * 0.022,
                backgroundImage: NetworkImage(
                  userProfilePhoto,
                ),
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: width * 0.16),
                child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: writingContoller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: LocaleKeys.write_Something.tr(),
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(top: height * 0.03),
                child: Container(
                  height: height * 0.05,
                  width: width,
                  color: Palette.scaffold,
                  child: Row(
                    children: [
                      SizedBox(
                        width: width * 0.04,
                      ),
                      Icon(
                        FontAwesomeIcons.image,
                        size: height * 0.021,
                      ),
                      InkWell(onTap: photoPost, child: Text(LocaleKeys.photo.tr())),
                      SizedBox(
                        width: width * 0.06,
                      ),
                      InkWell(
                          onTap: videoPost,
                          child: Icon(
                            FontAwesomeIcons.video,
                            size: height * 0.021,
                          )),
                      Text(LocaleKeys.video.tr()),
                      Padding(
                          padding: EdgeInsets.only(left: width * 0.384),
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
                                child: Icon(FontAwesomeIcons.solidPaperPlane, size: height * 0.021)),
                          ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
