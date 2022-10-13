import 'package:als_frontend/old_code/const/palette.dart';
import 'package:als_frontend/old_code/screens/Page/page_images_tab.dart';
import 'package:als_frontend/old_code/screens/Page/page_videos_tab.dart';
import 'package:als_frontend/old_code/screens/screens.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

import '../../provider/provider.dart';
import '../../widgets/widgets.dart';

class SuggestedPageView extends StatefulWidget {
  const SuggestedPageView({Key? key}) : super(key: key);

  @override
  State<SuggestedPageView> createState() => _SuggestedPageViewState();
}

class _SuggestedPageViewState extends State<SuggestedPageView> {
  TextEditingController writePostController = TextEditingController();

  @override
  void initState() {
    final value = Provider.of<AuthorPagesProvider>(context, listen: false);
    value.getData();
    final value2 = Provider.of<SuggestedPageDetailsProvider>(context, listen: false);
    value2.getData();

    final pagePost = Provider.of<PagePostProvider>(context, listen: false);
    pagePost.getData();

    final pageImages = Provider.of<PageImagesProvider>(context, listen: false);
    pageImages.pageId = pagePost.id;

    final pageVideos = Provider.of<PageVideoProvider>(context, listen: false);
    pageVideos.pageId = pagePost.id;
    super.initState();
  }

  List poplist = ["Edit", "Delete"];

  void refresh() {
    final pagePost = Provider.of<PagePostProvider>(context, listen: false);
    pagePost.getData();
  }

  void refresh2() {
    final details = Provider.of<SuggestedPageDetailsProvider>(context, listen: false);
    details.getData();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SafeArea(
          child: GestureDetector(onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          }, child: Consumer6<UpdatePageProfileImageProvider, SuggestedPageDetailsProvider, PagePostProvider, PageLikeProvider,
                  ProfileImagesProvider, PostImagesPreviewProvider>(
              builder: (context, imageProvider, suggestedPageDetailsProvider, pagePostProvider, pageLikeProvider, profileImageProvider,
                  postImageProvider, child) {
            return (suggestedPageDetailsProvider.pageDetails == null)
                ? const Center(child: CircularProgressIndicator())
                : SizedBox(
                    height: height,
                    width: width,
                    child: Stack(
                      children: [
                        CoverPhotoWidget(
                            back: () {
                              Get.back();
                            },
                            coverphoto: "${suggestedPageDetailsProvider.pageDetails.coverPhoto}",
                            coverphotochange: () {},
                            viewCoverPhoto: () {
                              profileImageProvider.imageUrl = suggestedPageDetailsProvider.pageDetails.coverPhoto;
                              Get.to(() => const SingleImageView());
                            }),
                        Positioned(
                          top: height * 0.21,
                          child: Container(
                            height: height,
                            width: width,
                            decoration: const BoxDecoration(
                              color: Color(0xffF6F6F6),
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: height * 0.06),
                                      child: Column(
                                        children: [
                                          Text(
                                            suggestedPageDetailsProvider.pageDetails.name,
                                            style: TextStyle(fontSize: height * 0.03, fontWeight: FontWeight.bold),
                                          ),
                                          Text(suggestedPageDetailsProvider.pageDetails.category)
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: height * 0.03, left: width * 0.3),
                                      child: Column(
                                        children: [
                                          Text(
                                            "${suggestedPageDetailsProvider.pageDetails.totalLike}",
                                            style: TextStyle(fontSize: height * 0.03, fontWeight: FontWeight.bold),
                                          ),
                                          const Text("Followers"),
                                          SizedBox(
                                            height: height * 0.014,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              pageLikeProvider.like();
                                              refresh2();
                                            },
                                            child: Container(
                                              height: height * 0.036,
                                              width: width * 0.2,
                                              decoration: BoxDecoration(
                                                  color: (suggestedPageDetailsProvider.pageDetails.like == false)
                                                      ? Palette.primary
                                                      : Colors.green,
                                                  borderRadius: BorderRadius.circular(10)),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  const Icon(
                                                    Icons.thumb_up_sharp,
                                                    size: 16,
                                                    color: Colors.white,
                                                  ),
                                                  Text(
                                                    (suggestedPageDetailsProvider.pageDetails.like == false) ? "Like" : "Liked",
                                                    style: TextStyle(fontSize: height * 0.015, color: Colors.white),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.009,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: height * 0.035,
                                    width: width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      color: Palette.notificationColor,
                                    ),
                                    child: TabBar(
                                        indicator: BoxDecoration(color: Palette.primary, borderRadius: BorderRadius.circular(7)),
                                        tabs: const [
                                          Text("Post"),
                                          Text("Photos"),
                                          Text("Videos"),
                                        ]),
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.55,
                                  width: width,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TabBarView(
                                      children: [
                                        Container(
                                          decoration: const BoxDecoration(
                                            color: Color(0xffF6F6F6),
                                            borderRadius: BorderRadius.all(Radius.circular(20)),
                                          ),
                                          child: Consumer2<WritePagePostProvider, SingleVideoShowProvider>(
                                              builder: (context, provider, singleVideoShowProvider, child) {
                                            return SingleChildScrollView(
                                              physics: const ScrollPhysics(),
                                              child: Column(
                                                children: [
                                                  /*----------------------------------------Newsfeed---------------------------------*/
                                                  ListView.builder(
                                                      shrinkWrap: true,
                                                      physics: const NeverScrollableScrollPhysics(),
                                                      itemCount: pagePostProvider.pagePosts!.length,
                                                      itemBuilder: ((context, index) {
                                                        return Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                CircleAvatar(
                                                                  backgroundImage:
                                                                      NetworkImage(suggestedPageDetailsProvider.pageDetails.avatar),
                                                                  radius: 27,
                                                                  child: Padding(
                                                                    padding: EdgeInsets.only(left: width * 0.08, top: height * 0.02),
                                                                  ),
                                                                ),
                                                                Column(
                                                                  children: [
                                                                    Text(
                                                                      suggestedPageDetailsProvider.pageDetails.name,
                                                                      style: const TextStyle(
                                                                        fontSize: 16,
                                                                        fontWeight: FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                    Text(pagePostProvider.pagePosts![index].timestamp)
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                            Text(pagePostProvider.pagePosts![index].description),
                                                            SizedBox(
                                                                height: (pagePostProvider.pagePosts![index].totalImage != 0)
                                                                    ? (pagePostProvider.pagePosts![index].totalImage == 1)
                                                                        ? height * 0.35
                                                                        : (pagePostProvider.pagePosts![index].totalImage == 2)
                                                                            ? height * 0.2
                                                                            : height * 0.5
                                                                    : 0,
                                                                child: (pagePostProvider.pagePosts![index].totalImage == 0)
                                                                    ? Container()
                                                                    : (pagePostProvider.pagePosts![index].totalImage == 1)
                                                                        ? Center(
                                                                            child: InkWell(
                                                                              onTap: () {
                                                                                postImageProvider.iamges = [];

                                                                                postImageProvider.iamges.add(
                                                                                    pagePostProvider.pagePosts![index].images[0].image);
                                                                                Get.to(() => const PostImagesPreview());
                                                                              },
                                                                              child: CachedNetworkImage(
                                                                                  imageUrl:
                                                                                      pagePostProvider.pagePosts![index].images[0].image,
                                                                                  imageBuilder: (context, imageProvider) => Container(
                                                                                      height: height * 0.35,
                                                                                      decoration: BoxDecoration(
                                                                                          image: DecorationImage(
                                                                                              image: imageProvider, fit: BoxFit.fitWidth))),
                                                                                  placeholder: ((context, url) => Container(
                                                                                        alignment: Alignment.center,
                                                                                        child: const CircularProgressIndicator(),
                                                                                      ))),
                                                                            ),
                                                                          )
                                                                        : GridView.builder(
                                                                            physics: const NeverScrollableScrollPhysics(),
                                                                            shrinkWrap: true,
                                                                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                              crossAxisCount:
                                                                                  (pagePostProvider.pagePosts![index].totalImage == 1)
                                                                                      ? 1
                                                                                      : 2,
                                                                              crossAxisSpacing: 2.0,
                                                                              mainAxisSpacing: 2.0,
                                                                            ),
                                                                            itemCount: (pagePostProvider.pagePosts![index].totalImage < 4)
                                                                                ? pagePostProvider.pagePosts![index].totalImage
                                                                                : 4,
                                                                            itemBuilder: (context, index2) {
                                                                              return InkWell(
                                                                                onTap: () {
                                                                                  postImageProvider.iamges = [];
                                                                                  for (int i = 0;
                                                                                      i < pagePostProvider.pagePosts![index].images.length;
                                                                                      i++) {
                                                                                    postImageProvider.iamges.add(
                                                                                        pagePostProvider.pagePosts![index].images[i].image);
                                                                                    Get.to(() => const PostImagesPreview());
                                                                                  }
                                                                                },
                                                                                child: Column(
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                    (pagePostProvider.pagePosts![index].totalImage > 4 &&
                                                                                            index2 == 3)
                                                                                        ? Container(
                                                                                            child: Center(
                                                                                              child: Text(
                                                                                                "+${pagePostProvider.pagePosts![index].totalImage - 4}",
                                                                                                style: const TextStyle(
                                                                                                  color: Colors.white,
                                                                                                  fontWeight: FontWeight.bold,
                                                                                                  fontSize: 26,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            decoration: BoxDecoration(
                                                                                                image: DecorationImage(
                                                                                              image: NetworkImage(
                                                                                                pagePostProvider
                                                                                                    .pagePosts![index].images[index2].image,
                                                                                              ),
                                                                                              fit: BoxFit.cover,
                                                                                            )),
                                                                                          )
                                                                                        : CachedNetworkImage(
                                                                                            imageUrl: pagePostProvider
                                                                                                .pagePosts![index].images[index2].image,
                                                                                            imageBuilder: (context, imageProvider) =>
                                                                                                Container(
                                                                                                    width: 400,
                                                                                                    height: 200,
                                                                                                    decoration: BoxDecoration(
                                                                                                        image: DecorationImage(
                                                                                                            image: imageProvider,
                                                                                                            fit: BoxFit.fitWidth))),
                                                                                            placeholder: ((context, url) => Container(
                                                                                                  alignment: Alignment.center,
                                                                                                  child: const CircularProgressIndicator(),
                                                                                                )))
                                                                                  ],
                                                                                ),
                                                                              );
                                                                            },
                                                                          )),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            (pagePostProvider.pagePosts![index].totalVideo != 0)
                                                                ? InkWell(
                                                                    onTap: () {
                                                                      singleVideoShowProvider.videoUrl =
                                                                          pagePostProvider.pagePosts![index].videos[0].video;
                                                                      Get.to(() => const VideoDetailsScreen());
                                                                    },
                                                                    child: Container(
                                                                      height: 150,
                                                                      width: width,
                                                                      child: Image.asset("assets/background/video_pause.jpg"),
                                                                      color: Colors.black,
                                                                    ),
                                                                  )
                                                                : Container(),
                                                            Consumer2<ProfileDetailsProvider, ReportPostProvider>(
                                                                builder: (context, profileDetailsProvider, reportPostProvider, child) {
                                                              return LikeCommentCount(
                                                                editOnPressed: () {
                                                                  reportPostProvider.postId = pagePostProvider.pagePosts![index].id;
                                                                  reportPostProvider.postFrom = "page";
                                                                  Get.to(() => const ReportPostScreen());
                                                                },
                                                                editText: const Icon(
                                                                  Icons.report,
                                                                  color: Colors.orange,
                                                                ),
                                                                likeText:
                                                                    (pagePostProvider.pagePosts![index].like == false) ? "Like" : "Liked",
                                                                likeCount: pagePostProvider.pagePosts![index].totalLike,
                                                                commentCount: pagePostProvider.pagePosts![index].totalComment,
                                                                likeCountColor: (pagePostProvider.pagePosts![index].like == false)
                                                                    ? Colors.black
                                                                    : Colors.red,
                                                              );
                                                            }),
                                                            Consumer<PageLikePostShareProvider>(builder: (context, likeComment, child) {
                                                              return LikeCommentShare(
                                                                likeText: "Liked",
                                                                index: index,
                                                                like: () {
                                                                  likeComment.pageId = pagePostProvider.pagePosts![index].page.id;
                                                                  likeComment.postId = pagePostProvider.pagePosts![index].id.toString();
                                                                  likeComment.like();
                                                                  refresh();
                                                                },
                                                                comment: () {
                                                                  likeComment.pageId = pagePostProvider.pagePosts![index].page.id;
                                                                  likeComment.postId = pagePostProvider.pagePosts![index].id.toString();
                                                                  pagePostProvider.index = index;
                                                                  Get.to(const PageCommentsScreen());
                                                                },
                                                                share: () {
                                                                  likeComment.pageId = pagePostProvider.pagePosts![index].page.id;
                                                                  likeComment.postId = pagePostProvider.pagePosts![index].id.toString();
                                                                  Get.to(const PagePostShareScreen());
                                                                },
                                                                likeIconColor: (pagePostProvider.pagePosts![index].like == false)
                                                                    ? Colors.black
                                                                    : Colors.red,
                                                              );
                                                            })
                                                          ],
                                                        );
                                                      })),
                                                ],
                                              ),
                                            );
                                          }),
                                        ),
                                        const PageImagesTab(), //vedios
                                        const PageVideosTab(), //photos
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ), //name
                        ProfilePhotowidget(
                            viewProfilePhoto: () {
                              profileImageProvider.imageUrl = suggestedPageDetailsProvider.pageDetails.avatar;
                              Get.to(() => const SingleImageView());
                            },
                            profilePhotoChange: () {
                              imageProvider.imageUrl = suggestedPageDetailsProvider.pageDetails.avatar;
                              imageProvider.id = suggestedPageDetailsProvider.pageDetails.id;
                              Get.to(() => const UpdatePageProfilePic());
                            },
                            profileImage: suggestedPageDetailsProvider.pageDetails.avatar)
                      ],
                    ),
                  );
          })),
        ),
      ),
    );
  }
}
