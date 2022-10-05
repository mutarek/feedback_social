// import 'package:flutter/material.dart';
// import 'package:get/route_manager.dart';
// import 'package:provider/provider.dart';

// import '../../../provider/provider.dart';
// import '../../../widgets/widgets.dart';
// import '../../screens.dart';

// class UserPostTab extends StatelessWidget {
//   const UserPostTab({
//     Key? key,
//     required this.height,
//   }) : super(key: key);

//   final double height;

//   @override
//   Widget build(BuildContext context) {
//     List poplist = ["Edit", "Delete"];
//     List poplist2 = ["Report this post"];
//     return Column(children: [
//       Consumer<UserProfileProvider>(builder: (context, provider, child) {
//         return PostWidget(
//             userProfilePhoto: (provider.loading == false)
//                 ? provider.userprofileData.profileImage!
//                 : "https://meektecbacekend.s3.amazonaws.com/media/profile/default.jpeg",
//             writeToPost: () {},
//             videoPost: () {},
//             photoPost: () {},
//             share: () {});
//       }),
//       SizedBox(
//         height: height * 0.01,
//       ),
//       Consumer5<ProfileNewsFeedPostProvider, LikeCommentShareProvider,
//               CreatePostProvider, ProfileDetailsProvider, SinglePostProvider>(
//           builder: (context, provider, provider2, provider3, provider4,
//               provider5, child) {
//         return Visibility(
//           visible: provider.isLoaded,
//           child: ListView.builder(
//               physics: const NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               itemCount: provider.posts?.length,
//               itemBuilder: (context, index) {
//                 return Column(
//                   children: [
//                     PostContainer(
//                       poplist: (provider.id == provider.posts![index].author)
//                           ? poplist
//                           : poplist2,
//                       delete: () {
//                         provider3.postId = provider.posts![index].id;
//                         provider3.delete();
//                         if (provider3.postDeleted == true) {
//                           provider.refresh();
//                         }
//                       },
//                       edit: () {
//                         provider3.postId = provider.posts![index].id;
//                         provider5.description =
//                             provider.posts![index].description;
//                         Get.to(() => const EditPostScreen());
//                       },
//                       reportThisPost: () {
//                         provider3.postId = provider.posts![index].id;
//                         Get.to(() => const ReportPostScreen());
//                       },
//                       profileOnTap: () {
//                         provider4.id = provider.posts![index].author;
//                         (provider.posts![index].author == provider4.userId)
//                             ? Get.to(() => const ProfileScreen())
//                             : Get.to(() => const ProfileDetailsScreen());
//                       },
//                       likeCountColor: (provider.posts![index].like == true)
//                           ? Colors.red
//                           : Colors.grey,
//                       likeText: (provider.posts![index].like == true)
//                           ? "Liked"
//                           : "Like",
//                       likeIconColor: (provider.posts![index].like == true)
//                           ? Colors.red
//                           : Colors.black,
//                       postHeight: (provider.posts![index].totalImage != 0)
//                           ? (provider.posts![index].description.length > 215)
//                               ? 450 +
//                                   ((provider.posts![index].description.length -
//                                               215) /
//                                           43) *
//                                       (height * 0.01)
//                               : 400
//                           : 200,
//                       imageHeight: (provider.posts![index].totalImage != 0)
//                           ? (provider.posts![index].totalImage > 1)
//                               ? 200
//                               : 200
//                           : 0,
//                       name: provider.posts![index].authorName,
//                       time: provider.posts![index].created,
//                       description: provider.posts![index].description,
//                       image: provider.posts![index].authorProfilePicture,
//                       postImage: (provider.posts![index].totalImage != 0)
//                           ? Column(
//                               children: [
//                                 Expanded(
//                                   child: GridView.builder(
//                                     physics:
//                                         const NeverScrollableScrollPhysics(),
//                                     shrinkWrap: true,
//                                     gridDelegate:
//                                         SliverGridDelegateWithFixedCrossAxisCount(
//                                       crossAxisCount: (provider
//                                                   .posts![index].totalImage <=
//                                               3)
//                                           ? provider.posts![index].totalImage
//                                           : 3,
//                                       crossAxisSpacing: 5.0,
//                                       mainAxisSpacing: 5.0,
//                                     ),
//                                     itemCount:
//                                         provider.posts![index].totalImage,
//                                     itemBuilder: (context, index2) {
//                                       return Column(
//                                         mainAxisAlignment:
//                                             (provider.posts![index].totalImage >
//                                                     1)
//                                                 ? MainAxisAlignment.center
//                                                 : MainAxisAlignment.start,
//                                         children: [
//                                           (index2.isEven &&
//                                                   provider.posts![index].images
//                                                       .isNotEmpty)
//                                               ? Expanded(
//                                                   child: Image.network(
//                                                     "${provider.posts![index].images[index2]["image"]}",
//                                                     fit: BoxFit.cover,
//                                                   ),
//                                                 )
//                                               : Expanded(
//                                                   child: Container(
//                                                     color: Colors.green,
//                                                   ),
//                                                 )
//                                         ],
//                                       );
//                                     },
//                                   ),
//                                 ),

//                                 // provider.posts![index].totalImage > 3
//                                 //     ? Text(
//                                 //         "See ${provider.posts![index].totalImage - 3} more images")
//                                 //     : const Text(""),
//                               ],
//                             )
//                           // ? Image.network("${provider.posts![index].images[0]["image"]}", fit: BoxFit.cover,)
//                           : Container(),
//                       likeCount: provider.posts![index].likes,
//                       commentCount: provider.posts![index].comments.length,
//                       like: () {
//                         provider2.postId = provider.posts![index].id.toString();
//                         provider2.like();
//                         provider.refresh();
//                       },
//                       comment: () {
//                         provider2.postId = provider.posts![index].id.toString();
//                         provider.index = index;
//                         Get.to(const CommentsScreen());
//                       },
//                       share: () {},
//                       moreButton: () {},
//                       largeImage: () {
//                         Get.to(const ShowPostImage());
//                         provider.index = index;
//                         provider.postCaption =
//                             provider.posts![index].description;
//                         for (int i = 0;
//                             i < provider.posts![index].totalImage;
//                             i++) {
//                           provider.postImages
//                               .add(provider.posts![index].images[i]["image"]);
//                         }
//                       },
//                     ),
//                   ],
//                 );
//               }),
//           replacement: const Center(child: CircularProgressIndicator()),
//         );
//       }),
//     ]);
//   }
// }
