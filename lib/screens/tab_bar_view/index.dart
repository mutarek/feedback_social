// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:provider/provider.dart';

// import '../../const/palette.dart';
// import '../../provider/provider.dart';
// import '../../widgets/widgets.dart';
// import '../screens.dart';

// class Index extends StatefulWidget {
//   const Index({Key? key}) : super(key: key);

//   @override
//   State<Index> createState() => _IndexState();
// }

// class _IndexState extends State<Index> {
//   TextEditingController postController = TextEditingController();

//   List poplist = ["Edit", "Delete"];
//   List poplist2 = ["Report this post"];

//   @override
//   void initState() {
//     final value = Provider.of<GetInfoFromDb>(context, listen: false);
//     value.info();
//     final data = Provider.of<NewsFeedPostProvider>(context, listen: false);
//     data.getData();
//     final data2 =
//         Provider.of<ProfileNewsFeedPostProvider>(context, listen: false);
//     data2.getData();
//     data.checkConnection();
//     final profieImage =
//         Provider.of<UserProfileProvider>(context, listen: false);
//     profieImage.getUserData();
//     final notification =
//         Provider.of<NotificationsProvider>(context, listen: false);
//     notification.getData();
//     notification.check();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: const Text(
//           "ALS",
//           style: TextStyle(
//               color: Palette.primary,
//               fontSize: 28,
//               fontWeight: FontWeight.bold,
//               letterSpacing: -1.2),
//         ),
//         actions: [
//           Consumer<LoginProvider>(builder: (context, provider, child) {
//             return CustomIconButton(
//                 iconName: Icons.search,
//                 onPressed: () {
//                   Get.to(() => const SearchScreen());
//                 });
//           }),
//           CustomIconButton(
//               iconName: MdiIcons.facebookMessenger,
//               onPressed: () {
//                 DatabaseProvider().logout(context);
//               }),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Consumer2<CreatePostProvider, UserProfileProvider>(
//                 builder: (context, provider, profileImage, child) {
//               return CreatePostContainer(
//                 imageOnTap: () => Get.to(const ProfileScreen()),
//                 postController: postController,
//                 image: (profileImage.userprofileData.profileImage != null)
//                     ? profileImage.userprofileData.profileImage!
//                     : "https://meektecbacekend.s3.amazonaws.com/media/profile/default.jpeg",
//                 addAnimal: () {
//                   GetInfoFromDb().info();
//                   Get.to(const AddAnimalScreen());
//                 },
//                 onPhotoPressed: () {
//                   provider.image.clear();
//                   provider.pickImage();
//                 },
//                 onVideoPressed: () {
//                   provider.pickVideo();
//                 },
//                 submit: () {
//                   provider.createPost(postController.text);
//                   NewsFeedPostProvider().refresh();
//                   setState(() {
//                     postController.value = TextEditingValue.empty;
//                   });
//                 },
//               );
//             }),
//             Consumer6<
//                     NewsFeedPostProvider,
//                     LikeCommentShareProvider,
//                     CreatePostProvider,
//                     ProfileDetailsProvider,
//                     SinglePostProvider,
//                     OtherProfileNewsFeedPostProvider>(
//                 builder: (context,
//                     newsfeedProvider,
//                     likeCommentShareProvider,
//                     postCreateProvider,
//                     profileProvider,
//                     singlePostProvider,
//                     otherNewsfeedProvider,
//                     child) {
//               return Visibility(
//                 visible: newsfeedProvider.isLoaded,
//                 child: (newsfeedProvider.results.isEmpty)
//                     ? Padding(
//                         padding: EdgeInsets.only(top: height * 0.3),
//                         child: const Center(
//                           child: Text(
//                               "              Nothing to show. \n Add new friends to see new posts."),
//                         ),
//                       )
//                     : ListView.builder(
//                         physics: const NeverScrollableScrollPhysics(),
//                         shrinkWrap: true,
//                         itemCount: newsfeedProvider.results.length,
//                         itemBuilder: (context, index) {
//                           return Consumer<ShareTimeLinePostProvider>(
//                               builder: (context, sharePostProvider, child) {
//                             return PostContainer(
//                               sharerName: (newsfeedProvider
//                                           .results[index].author !=
//                                       null)
//                                   ? "${newsfeedProvider.results[index].author!.fullName}"
//                                   : "",
//                               sharerImage:
//                                   (newsfeedProvider.results[index].author !=
//                                           null)
//                                       ? newsfeedProvider
//                                           .results[index].author!.profileImage!
//                                       : "",
//                               sharerDescription: (newsfeedProvider
//                                           .results[index].isShare ==
//                                       true)
//                                   ? newsfeedProvider.results[index].description!
//                                   : "",
//                               isShare: newsfeedProvider.results[index].isShare!,
//                               groupName: (newsfeedProvider
//                                           .results[index].group !=
//                                       null)
//                                   ? newsfeedProvider.results[index].group!.name!
//                                   : "",
//                               postType: (newsfeedProvider
//                                           .results[index].postType !=
//                                       null)
//                                   ? newsfeedProvider.results[index].postType!
//                                   : "timeline",
//                               profileImage: (newsfeedProvider
//                                           .results[index].group !=
//                                       null)
//                                   ? newsfeedProvider
//                                       .results[index].author!.profileImage!
//                                   : "https://meektecbacekend.s3.amazonaws.com/media/profile/image_picker7197194014052842726.jpg",
//                               postHeight:
//                                   (newsfeedProvider.results[index].totalImage !=
//                                           0)
//                                       ? (newsfeedProvider.results[index].sharePost !=
//                                                   null &&
//                                               newsfeedProvider.results[index]
//                                                       .sharePost.totalImage !=
//                                                   0)
//                                           ? 400
//                                           : 200
//                                       : 200,
//                               imageHeight:
//                                   (newsfeedProvider.results[index].totalImage !=
//                                           0)
//                                       ? (newsfeedProvider.results[index].sharePost !=
//                                                   null &&
//                                               newsfeedProvider.results[index]
//                                                       .sharePost!.totalImage !=
//                                                   0)
//                                           ? 200
//                                           : 0
//                                       : 0,
//                               moreButton: () {},
//                               name: (newsfeedProvider.results[index].sharePost !=
//                                       null)
//                                   ? "${newsfeedProvider.results[index].sharePost!.author!.firstName} ${newsfeedProvider.results[index].sharePost!.author!.lastName}"
//                                   : "${newsfeedProvider.results[index].author!.firstName} ${newsfeedProvider.results[index].author!.lastName}",
//                               time: newsfeedProvider.results[index].timestamp,
//                               description:
//                                   (newsfeedProvider.results[index].sharePost != null)
//                                       ? newsfeedProvider
//                                           .results[index].sharePost!.description!
//                                       : newsfeedProvider
//                                           .results[index].description!,
//                               image: (newsfeedProvider
//                                           .results[index].postType !=
//                                       null)
//                                   ? (newsfeedProvider.results[index].postType ==
//                                           'timeline')
//                                       ? newsfeedProvider
//                                           .results[index].author!.profileImage
//                                       : (newsfeedProvider
//                                                   .results[index].postType ==
//                                               'page')
//                                           ? newsfeedProvider
//                                               .results[index].page!.avatar
//                                           : newsfeedProvider
//                                               .results[index].group!.avatar
//                                   : "https://meektecbacekend.s3.amazonaws.com/media/profile/image_picker7197194014052842726.jpg",
//                               postImage: (newsfeedProvider
//                                               .results[index].images !=
//                                           null &&
//                                       newsfeedProvider
//                                           .results[index].images!.isNotEmpty)
//                                   ? Column(
//                                       children: [
//                                         Expanded(
//                                           child: GridView.builder(
//                                             physics:
//                                                 const NeverScrollableScrollPhysics(),
//                                             shrinkWrap: true,
//                                             gridDelegate:
//                                                 const SliverGridDelegateWithFixedCrossAxisCount(
//                                               crossAxisCount: 2,
//                                               crossAxisSpacing: 5.0,
//                                               mainAxisSpacing: 5.0,
//                                             ),
//                                             itemCount: newsfeedProvider
//                                                 .results[index].totalImage,
//                                             itemBuilder: (context, index2) {
//                                               return Column(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.center,
//                                                 children: [
//                                                   (newsfeedProvider
//                                                               .results[index]
//                                                               .totalImage !=
//                                                           0)
//                                                       ? Image.network(
//                                                           newsfeedProvider
//                                                               .results[index]
//                                                               .images![index2]
//                                                               .image!)
//                                                       : Container()
//                                                 ],
//                                               );
//                                             },
//                                           ),
//                                         ),
//                                       ],
//                                     )
//                                   : Container(
//                                       color: Colors.red,
//                                     ),
//                               likeCount:
//                                   newsfeedProvider.results[index].totalLike,
//                               commentCount:
//                                   newsfeedProvider.results[index].totalComment,
//                               like: () {
//                                 likeCommentShareProvider.postId =
//                                     newsfeedProvider.results[index].id
//                                         .toString();
//                                 likeCommentShareProvider.like();
//                                 newsfeedProvider.refresh();
//                                 print(newsfeedProvider.results[index].postType);
//                               },
//                               comment: () {
//                                 likeCommentShareProvider.postId =
//                                     newsfeedProvider.results[index].id
//                                         .toString();
//                                 newsfeedProvider.index = index;
//                                 Get.to(const CommentsScreen());
//                               },
//                               share: () {
//                                 Get.to(() => const SharePostScreen());
//                                 (newsfeedProvider.results[index].isShare ==
//                                         false)
//                                     ? sharePostProvider.postId =
//                                         newsfeedProvider.results[index].id
//                                     : sharePostProvider.postId =
//                                         newsfeedProvider
//                                             .results[index].sharePost!.id;
//                                 print(newsfeedProvider.results[index].sharePost!.id);
//                               },
//                               largeImage: () {
//                                 Get.to(const ShowPostImage());
//                                 newsfeedProvider.index = index;
//                                 newsfeedProvider.postCaption = newsfeedProvider
//                                     .results[index].description!;
//                                 for (int i = 0;
//                                     i <
//                                         newsfeedProvider
//                                             .results[index].images!.length;
//                                     i++) {
//                                   newsfeedProvider.postImages.add(
//                                       newsfeedProvider
//                                           .results[index].images![i].image!);
//                                 }
//                               },
//                               likeIconColor:
//                                   (newsfeedProvider.results[index].like == true)
//                                       ? Colors.red
//                                       : Colors.black,
//                               likeCountColor:
//                                   (newsfeedProvider.results[index].like == true)
//                                       ? Colors.red
//                                       : Colors.black,
//                               likeText:
//                                   (newsfeedProvider.results[index].like == true)
//                                       ? "Liked"
//                                       : "Like",
//                               profileOnTap: () {
//                                 profileProvider.id =
//                                     newsfeedProvider.results[index].author!.id;
//                                 otherNewsfeedProvider.id =
//                                     newsfeedProvider.results[index].author!.id;
//                                 (newsfeedProvider.results[index].author!.id ==
//                                         profileProvider.userId)
//                                     ? Get.to(() => const ProfileScreen())
//                                     : Get.to(
//                                         () => const ProfileDetailsScreen());
//                               },
//                               poplist: (newsfeedProvider.id ==
//                                       newsfeedProvider
//                                           .posts.results[index].author.id)
//                                   ? poplist
//                                   : poplist2,
//                               delete: () {
//                                 postCreateProvider.postId =
//                                     newsfeedProvider.posts![index].id;
//                                 postCreateProvider.delete();
//                                 if (postCreateProvider.postDeleted == true) {
//                                   newsfeedProvider.refresh();
//                                 }
//                               },
//                               edit: () {
//                                 postCreateProvider.postId =
//                                     newsfeedProvider.posts![index].id;
//                                 singlePostProvider.description =
//                                     newsfeedProvider.posts![index].description;
//                                 Get.to(() => const EditPostScreen());
//                               },
//                               reportThisPost: () {
//                                 postCreateProvider.postId =
//                                     newsfeedProvider.posts![index].id;
//                                 Get.to(() => const ReportPostScreen());
//                               },
//                             );
//                           });
//                         }),
//               );
//             })
//           ],
//         ),
//       ),
//     );
//   }
// }
