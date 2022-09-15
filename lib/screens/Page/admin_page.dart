import 'package:als_frontend/const/palette.dart';
import 'package:als_frontend/screens/Page/page_images_tab.dart';
import 'package:als_frontend/screens/Page/page_videos_tab.dart';
import 'package:als_frontend/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../provider/provider.dart';
import '../../widgets/widgets.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  TextEditingController writePostController = TextEditingController();
  List poplist = ["Edit", "Delete"];

  @override
  void initState() {
    final value = Provider.of<AuthorPagesProvider>(context, listen: false);
    value.getData();
    final value2 =
        Provider.of<AuthorPageDetailsProvider>(context, listen: false);
    value2.getData();

    final pagePostValue = Provider.of<PagePostProvider>(context, listen: false);
    pagePostValue.getData();

    final pageImages = Provider.of<PageImagesProvider>(context, listen: false);
    pageImages.pageId = pagePostValue.id;

    final pageVideos = Provider.of<PageVideoProvider>(context, listen: false);
    pageVideos.pageId = pagePostValue.id;
    super.initState();
  }

  void refresh() {
    final pagePostValue = Provider.of<PagePostProvider>(context, listen: false);
    pagePostValue.getData();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Palette.scaffold,
        body: NestedScrollView(
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            // Setting floatHeaderSlivers to true is required in order to float
            // the outer slivers over the inner scrollable.
            floatHeaderSlivers: true,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverList(
                    delegate: SliverChildListDelegate([
                  SafeArea(
                    child: GestureDetector(onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    }, child: Consumer5<
                            UpdatePageProfileImageProvider,
                            AuthorPageDetailsProvider,
                            PagePostProvider,
                            ProfileImagesProvider,
                            EditPageProvider>(
                        builder: (context,
                            imageProvider,
                            authorPageDetailsProvider,
                            pagePostProvider,
                            profileImageProvider,
                            editPageProvider,
                            child) {
                      return (authorPageDetailsProvider.pageDetails == null)
                          ? const Center(child: CircularProgressIndicator())
                          : SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: height * 0.36,
                                    child: Stack(
                                      children: [
                                        CoverPhotoWidget(
                                            back: () {
                                              Get.back();
                                            },
                                            coverphoto:
                                                "${authorPageDetailsProvider.pageDetails.coverPhoto}",
                                            coverphotochange: () {},
                                            viewCoverPhoto: () {
                                              profileImageProvider.imageUrl =
                                                  authorPageDetailsProvider
                                                      .pageDetails.coverPhoto;
                                              Get.to(() =>
                                                  const SingleImageView());
                                            }),
                                        Positioned(
                                          top: height * 0.21,
                                          child: Container(
                                            height: height,
                                            width: width,
                                            decoration: const BoxDecoration(
                                              color: Palette.scaffold,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                            ),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: height * 0.06),
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            authorPageDetailsProvider
                                                                .pageDetails
                                                                .name,
                                                            style: GoogleFonts.lato(
                                                                fontSize:
                                                                    height *
                                                                        0.03,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Text(
                                                              authorPageDetailsProvider
                                                                  .pageDetails
                                                                  .category,
                                                              style: GoogleFonts
                                                                  .lato())
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: height * 0.03,
                                                          left: width * 0.3),
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            "${authorPageDetailsProvider.pageDetails.totalLike}",
                                                            style: GoogleFonts.lato(
                                                                fontSize:
                                                                    height *
                                                                        0.03,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Text(
                                                            "Followers",
                                                            style: GoogleFonts
                                                                .lato(),
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                height * 0.014,
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              editPageProvider
                                                                      .pageId =
                                                                  authorPageDetailsProvider
                                                                      .pageDetails
                                                                      .id;
                                                              Get.to(() =>
                                                                  const EditPage());
                                                            },
                                                            child: Container(
                                                              height: height *
                                                                  0.036,
                                                              width:
                                                                  width * 0.2,
                                                              decoration: BoxDecoration(
                                                                  color: Palette
                                                                      .primary,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              child: Row(
                                                                children: [
                                                                  const Icon(
                                                                    Icons
                                                                        .create_outlined,
                                                                    size: 16,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  Text(
                                                                    "Edit page",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            height *
                                                                                0.015,
                                                                        color: Colors
                                                                            .white),
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
                                              ],
                                            ),
                                          ),
                                        ), //name
                                        ProfilePhotowidget(
                                            viewProfilePhoto: () {
                                              profileImageProvider.imageUrl =
                                                  authorPageDetailsProvider
                                                      .pageDetails.avatar;
                                              Get.to(() =>
                                                  const SingleImageView());
                                            },
                                            profilePhotoChange: () {
                                              imageProvider.imageUrl =
                                                  authorPageDetailsProvider
                                                      .pageDetails.avatar;
                                              imageProvider.id =
                                                  authorPageDetailsProvider
                                                      .pageDetails.id;
                                              Get.to(() =>
                                                  const UpdatePageProfilePic());
                                            },
                                            profileImage:
                                                authorPageDetailsProvider
                                                    .pageDetails.avatar)
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: height * 0.035,
                                      width: width,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      child: TabBar(tabs: [
                                        Text("Post",
                                            style: GoogleFonts.lato(
                                                color: Colors.black)),
                                        Text("Photos",
                                            style: GoogleFonts.lato(
                                                color: Colors.black)),
                                        Text("Videos",
                                            style: GoogleFonts.lato(
                                                color: Colors.black)),
                                      ]),
                                    ),
                                  ),
                                ],
                              ),
                            );
                    })),
                  ),
                ]))
              ];
            },
            body: Consumer4<PagePostProvider, AuthorPageDetailsProvider,
                    CreatePagePost, SingleVideoShowProvider>(
                builder: (context, pagePostProvider, authorPageDetailsProvider,
                    createPagePost, singleVideoShowProvider, child) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: TabBarView(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xffF6F6F6),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child:
                          Consumer2<CreatePagePost, PostImagesPreviewProvider>(
                              builder: (context, provider, postImageProvider,
                                  child) {
                        return SingleChildScrollView(
                          physics: const ScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.all(7.0),
                                  child: WritePostWidget(
                                    videoPost: () {
                                      provider.pickVideo();
                                    },
                                    photoPost: () {
                                      provider.pickImage();
                                    },
                                    share: () {
                                      if (writePostController.text.isNotEmpty) {
                                        provider.createPost(
                                            writePostController.text);
                                        if (provider.success == true) {
                                          setState(() {
                                            writePostController.text = '';
                                            provider.image = [];
                                            provider.video = null;
                                          });
                                          
                                          refresh();
                                        }
                                      } else {
                                        Fluttertoast.showToast(
                                            msg:
                                                "Please write somthing to post");
                                      }
                                    },
                                    textFieldWidget: SizedBox(
                                      height: height * 0.07,
                                      width: width * 0.7,
                                      child: TextField(
                                        controller: writePostController,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          hintText: "Write something",
                                        ),
                                      ),
                                    ),
                                  )),
                              /*----------------------------------------Newsfeed---------------------------------*/
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: pagePostProvider.pagePosts!.length,
                                  itemBuilder: ((context, index) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  authorPageDetailsProvider
                                                      .pageDetails.avatar),
                                              radius: 27,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: width * 0.08,
                                                    top: height * 0.02),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  authorPageDetailsProvider
                                                    .pageDetails.name,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  ),
                                                Text(pagePostProvider
                                                    .pagePosts![index]
                                                    .timestamp)
                                              ],
                                            )
                                          ],
                                        ),
                                        Text(pagePostProvider
                                            .pagePosts![index].description),
                                        SizedBox(
                                          height: (pagePostProvider
                                                      .pagePosts![index]
                                                      .totalImage !=
                                                  0)
                                              ? 200
                                              : 0,
                                          child:
                                              (pagePostProvider
                                                          .pagePosts![index]
                                                          .totalImage ==
                                                      0)
                                                  ? Container()
                                                  : (pagePostProvider
                                                              .pagePosts![index]
                                                              .totalImage ==
                                                          1)
                                                      ? Center(
                                                          child: InkWell(
                                                            onTap: () {
                                                              postImageProvider
                                                                  .iamges = [];

                                                              postImageProvider
                                                                  .iamges
                                                                  .add(pagePostProvider
                                                                      .pagePosts![
                                                                          index]
                                                                      .images[0]
                                                                      .image);
                                                              Get.to(() =>
                                                                  const PostImagesPreview());
                                                            },
                                                            child: Container(
                                                                color: Colors
                                                                    .white,
                                                                height: 150,
                                                                width: width,
                                                                child: Image
                                                                    .network(
                                                                  pagePostProvider
                                                                      .pagePosts![
                                                                          index]
                                                                      .images[0]
                                                                      .image,
                                                                  fit: BoxFit
                                                                      .contain,
                                                                )),
                                                          ),
                                                        )
                                                      :Expanded(
                                                    child: GridView.builder(
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      gridDelegate:
                                                          SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount:
                                                            (pagePostProvider
                                                                    .pagePosts![
                                                                        index]
                                                                    .totalImage ==
                                                                    1)
                                                                ? 1
                                                                : 2,
                                                        crossAxisSpacing: 2.0,
                                                        mainAxisSpacing: 2.0,
                                                      ),
                                                      itemCount:
                                                          (pagePostProvider
                                                                    .pagePosts![
                                                                        index]
                                                                    .totalImage < 4)?pagePostProvider
                                                                    .pagePosts![
                                                                        index]
                                                                    .totalImage : 4,
                                                      itemBuilder:
                                                          (context, index2) {
                                                            
                                                        return InkWell(
                                                          onTap: () {
                                                            postImageProvider
                                                                    .iamges = [];
                                                                for (int i = 0;
                                                                    i <
                                                                        pagePostProvider
                                                                    .pagePosts![
                                                                        index]
                                                                    .images
                                                                            .length;
                                                                    i++) {
                                                                  postImageProvider.iamges.add(pagePostProvider
                                                                            .pagePosts![index]
                                                                            .images[i]
                                                                            .image);
                                                                  Get.to(() =>
                                                                      const PostImagesPreview());
                                                                }
                                                            },
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Expanded(
                                                                child:(pagePostProvider
                                                                    .pagePosts![
                                                                        index]
                                                                    .totalImage > 4 && index2 == 3) ?
                                                                    Container(
                                                                      child: const Center(
                                                                        child: Text(
                                                                          "More images",
                                                                          style: TextStyle(
                                                                            color: Colors.black,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 20,
                                                                            
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      decoration: BoxDecoration(
                                                                        image: DecorationImage(
                                                                        image: NetworkImage(pagePostProvider
                                                                            .pagePosts![index]
                                                                            .images[index2]
                                                                            .image,),
                                                                        fit: BoxFit.cover,
                                                                        )
                                                                      ),
                                                                    )
                                                                    :Image
                                                                    .network(
                                                                  pagePostProvider
                                                                            .pagePosts![index]
                                                                            .images[index2]
                                                                            .image,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  )
                                                      // : Expanded(
                                                      //     child:
                                                      //         GridView.builder(
                                                      //       physics:
                                                      //           const NeverScrollableScrollPhysics(),
                                                      //       shrinkWrap: true,
                                                      //       gridDelegate:
                                                      //           const SliverGridDelegateWithFixedCrossAxisCount(
                                                      //         crossAxisCount: 2,
                                                      //         crossAxisSpacing:
                                                      //             5.0,
                                                      //         mainAxisSpacing:
                                                      //             5.0,
                                                      //       ),
                                                      //       itemCount:
                                                      //           pagePostProvider
                                                      //               .pagePosts![
                                                      //                   index]
                                                      //               .totalImage,
                                                      //       itemBuilder:
                                                      //           (context,
                                                      //               index2) {
                                                      //         return Column(
                                                      //           mainAxisAlignment:
                                                      //               MainAxisAlignment
                                                      //                   .center,
                                                      //           children: [
                                                      //             InkWell(
                                                      //               onTap: () {
                                                      //                 postImageProvider
                                                      //                     .iamges = [];
                                                      //                 for (int i =
                                                      //                         0;
                                                      //                     i < pagePostProvider.pagePosts![index].images.length;
                                                      //                     i++) {
                                                      //                   postImageProvider.iamges.add(pagePostProvider
                                                      //                       .pagePosts![index]
                                                      //                       .images[i]
                                                      //                       .image);
                                                      //                   Get.to(() =>
                                                      //                       const PostImagesPreview());
                                                      //                 }
                                                      //               },
                                                      //               child:
                                                      //                   Expanded(
                                                      //                 child: Image
                                                      //                     .network(
                                                      //                   pagePostProvider
                                                      //                       .pagePosts![index]
                                                      //                       .images[index2]
                                                      //                       .image,
                                                      //                   fit: BoxFit
                                                      //                       .fill,
                                                      //                 ),
                                                      //               ),
                                                      //             )
                                                      //           ],
                                                      //         );
                                                      //       },
                                                      //     ),
                                                      //   ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        (pagePostProvider.pagePosts![index]
                                                    .totalVideo !=
                                                0)
                                            ? InkWell(
                                                onTap: () {
                                                  singleVideoShowProvider
                                                          .videoUrl =
                                                      pagePostProvider
                                                          .pagePosts![index]
                                                          .videos[0]
                                                          .video;
                                                  Get.to(() =>
                                                      const ShowVideoPage());
                                                },
                                                child: Container(
                                                  height: 150,
                                                  width: width,
                                                  child: Image.asset(
                                                      "assets/background/video_pause.jpg"),
                                                  color: Colors.black,
                                                ),
                                              )
                                            : Container(),
                                        LikeCommentCount(
                                          editOnPressed: () {
                                            createPagePost.pageId =
                                                authorPageDetailsProvider
                                                    .pageDetails.id;
                                            createPagePost.postId =
                                                pagePostProvider
                                                    .pagePosts![index].id;
                                            createPagePost.description =
                                                pagePostProvider
                                                    .pagePosts![index]
                                                    .description;
                                            Get.to(() =>
                                                const EditPagePostScreen());
                                          },
                                          editText: "Edit",
                                          likeText: (pagePostProvider
                                                      .pagePosts![index].like ==
                                                  false)
                                              ? "Like"
                                              : "Liked",
                                          likeCount: pagePostProvider
                                              .pagePosts![index].totalLike,
                                          commentCount: pagePostProvider
                                              .pagePosts![index].totalComment,
                                          likeCountColor: (pagePostProvider
                                                      .pagePosts![index].like ==
                                                  false)
                                              ? Colors.black
                                              : Colors.red,
                                        ),
                                        Consumer<PageLikePostShareProvider>(
                                            builder:
                                                (context, likeComment, child) {
                                          return LikeCommentShare(
                                            likeText: "Liked",
                                            like: () {
                                              likeComment.pageId =
                                                  pagePostProvider
                                                      .pagePosts![index]
                                                      .page
                                                      .id;
                                              likeComment.postId =
                                                  pagePostProvider
                                                      .pagePosts![index].id
                                                      .toString();
                                              likeComment.like();
                                              refresh();
                                            },
                                            comment: () {
                                              likeComment.pageId =
                                                  pagePostProvider
                                                      .pagePosts![index]
                                                      .page
                                                      .id;
                                              likeComment.postId =
                                                  pagePostProvider
                                                      .pagePosts![index].id
                                                      .toString();
                                              pagePostProvider.index = index;
                                              Get.to(
                                                  const PageCommentsScreen());
                                            },
                                            share: () {
                                              likeComment.pageId =
                                                  pagePostProvider
                                                      .pagePosts![index]
                                                      .page
                                                      .id;
                                              likeComment.postId =
                                                  pagePostProvider
                                                      .pagePosts![index].id
                                                      .toString();
                                              Get.to(
                                                  const PagePostShareScreen());
                                            },
                                            likeIconColor: (pagePostProvider
                                                        .pagePosts![index]
                                                        .like ==
                                                    false)
                                                ? Colors.black
                                                : Colors.red,
                                          );
                                        })
                                      ],
                                    );
                                  }))
                            ],
                          ),
                        );
                      }),
                    ),
                    const PageImagesTab(), //vedios
                    const PageVideosTab(), //photos
                  ],
                ),
              );
            })),
      ),
    );
  }
}
