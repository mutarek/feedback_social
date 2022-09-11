// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';

// import '../../provider/provider.dart';
// import '../../widgets/widgets.dart';
// import '../screens.dart';

// class PagePost extends StatefulWidget {
//   const PagePost({Key? key}) : super(key: key);

//   @override
//   State<PagePost> createState() => _PagePostState();
// }

// class _PagePostState extends State<PagePost> {
//   Future<void> _refresh() async {
//     final data = Provider.of<NewsFeedPostProvider>(context, listen: false);
//     data.getData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Consumer2<AllPageProvider, LikeCommentShareProvider>(
//                 builder: (context, provider, provider2, child) {
//               return Visibility(
//                 visible: provider.isLoaded,
//                 child: ListView.builder(
//                     physics: const NeverScrollableScrollPhysics(),
//                     shrinkWrap: true,
//                     itemCount: provider.pages![provider.pageIndex].posts.length,
//                     itemBuilder: (context, index) {
//                       return Column(
//                         children: [
//                           PostContainer(
//                             likeCountColor:
//                                 (provider.pages![provider.pageIndex].like == true)
//                                     ? Colors.red
//                                     : Colors.grey,
//                             likeText: (provider.posts![index].like == true)
//                                 ? "Liked"
//                                 : "Like",
//                             likeIconColor: (provider.posts![index].like == true)
//                                 ? Colors.red
//                                 : Colors.grey,
//                             postHeight: (provider.posts![index].totalImage != 0)
//                                 ? (provider.posts![index].description.length >
//                                         215)
//                                     ? 450 +
//                                         ((provider.posts![index].description
//                                                         .length -
//                                                     215) /
//                                                 43) *
//                                             (height * 0.01)
//                                     : 400
//                                 : 200,
//                             imageHeight:
//                                 (provider.posts![index].totalImage != 0)
//                                     ? (provider.posts![index].totalImage > 1)
//                                         ? 150
//                                         : 200
//                                     : 0,
//                             name: provider.posts![index].authorName,
//                             time: provider.posts![index].created,
//                             description: provider.posts![index].description,
//                             image: provider.posts![index].authorProfilePicture,
//                             postImage: (provider.posts![index].totalImage != 0)
//                                 ? Column(
//                                     children: [
//                                       Expanded(
//                                         child: GridView.builder(
//                                           physics:
//                                               const NeverScrollableScrollPhysics(),
//                                           shrinkWrap: true,
//                                           gridDelegate:
//                                               SliverGridDelegateWithFixedCrossAxisCount(
//                                             crossAxisCount: (provider
//                                                         .posts![index]
//                                                         .totalImage <=
//                                                     3)
//                                                 ? provider
//                                                     .posts![index].totalImage
//                                                 : 3,
//                                             crossAxisSpacing: 5.0,
//                                             mainAxisSpacing: 5.0,
//                                           ),
//                                           itemCount:
//                                               provider.posts![index].totalImage,
//                                           itemBuilder: (context, index2) {
//                                             return Column(
//                                               mainAxisAlignment: (provider
//                                                           .posts![index]
//                                                           .totalImage >
//                                                       1)
//                                                   ? MainAxisAlignment.center
//                                                   : MainAxisAlignment.start,
//                                               children: [
//                                                 Image.network(
//                                                   "${provider.posts![index].images[index2]["image"]}",
//                                                   fit: BoxFit.cover,
//                                                 ),
//                                               ],
//                                             );
//                                           },
//                                         ),
//                                       ),
//                                       provider.posts![index].totalImage > 3
//                                           ? Text(
//                                               "See ${provider.posts![index].totalImage - 3} more images")
//                                           : const Text(""),
//                                     ],
//                                   )
//                                 // ? Image.network("${provider.posts![index].images[0]["image"]}", fit: BoxFit.cover,)
//                                 : Container(),
//                             likeCount: provider.posts![index].likes,
//                             commentCount:
//                                 provider.posts![index].comments.length,
//                             like: () {
//                               provider2.postId =
//                                   provider.posts![index].id.toString();
//                               provider2.like();
//                               _refresh();
//                             },
//                             comment: () {
//                               provider2.postId =
//                                   provider.posts![index].id.toString();
//                               provider.index = index;
//                               Get.to(const CommentsScreen());
//                             },
//                             share: () {},
//                             moreButton: () {},
//                             largeImage: () {
//                               Get.to(const ShowPostImage());
//                               provider.index = index;
//                               provider.postCaption =
//                                   provider.posts![index].description;
//                               for (int i = 0;
//                                   i < provider.posts![index].totalImage;
//                                   i++) {
//                                 provider.postImages.add(
//                                     provider.posts![index].images[i]["image"]);
//                               }
//                             },
//                           ),
//                         ],
//                       );
//                     }),
//                 replacement: const Center(child: CircularProgressIndicator()),
//               );
//             }),
//           ],
//         ),
//       ),
//     );
//   }
// }
