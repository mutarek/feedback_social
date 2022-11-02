import 'package:als_frontend/helper/secret_key.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../const/palette.dart';
import '../../provider/provider.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    final value = Provider.of<GetInfoFromDb>(context, listen: false);
    value.info();
    final data = Provider.of<NewsFeedPostProvider>(context, listen: false);
    data.getData();
    controller.addListener(() {
      if (controller.offset >= controller.position.maxScrollExtent && !controller.position.outOfRange) {
        data.getData();
      }
    });
    // final data2 =
    //     Provider.of<ProfileNewsFeedPostProvider>(context, listen: false);
    // data2.getData();
    final video = Provider.of<SingleVideoShowProvider>(context, listen: false);
    video.videoUrl = "";
    final profileDetails = Provider.of<ProfileDetailsProvider>(context, listen: false);
    profileDetails.getUserData();
    data.checkConnection();
    final profieImage = Provider.of<UserProfileProvider>(context, listen: false);
    profieImage.getUserData();
    final notification = Provider.of<OldNotificationsProvider>(context, listen: false);
    notification.getData();
    notification.check();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  _openMap() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString('token') ?? '');
    // String url = 'feedback://chatting.com/${encryptedText(token)}';
    String url = 'feedback://chatting.com/${token}';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
            context: context,
            builder: (context) {
              Fluttertoast.showToast(msg: "Press back button again to exit");
              return const NavScreen();
            });

        return value == true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            "FeedBack",
            style: TextStyle(color: Palette.primary, fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: -1.2),
          ),
          actions: [
            Consumer<LoginProvider>(builder: (context, provider, child) {
              return CustomIconButton(
                  iconName: Icons.search,
                  onPressed: () {
                    Get.to(() => const SearchScreen());
                  });
            }),
            CustomIconButton(
                iconName: MdiIcons.facebookMessenger,
                onPressed: () {
                  //Get.to(() => const CommingSoonScreen());
                  _openMap();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Coming soon...')));
                })
          ],
        ),
        body: SingleChildScrollView(
          controller: controller,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: width * 0.1, top: height * 0.014),
                child: Consumer2<ProfileDetailsProvider, UserNewsfeedPostProvider>(builder: (context, provider, provide2, child) {
                  return NewsfeedPostWidget(
                    height: height,
                    width: width,
                    progilePhoto: (provider.userprofileData.profileImage == null)
                        ? "https://meektecbacekend.s3.amazonaws.com/media/profile/default.jpeg"
                        : provider.userprofileData.profileImage!,
                    goToPostScreen: () {
                      provide2.id = provider.userId!;
                      Get.to(() => const ProfileScreen());
                    },
                    goToProfile: () {
                      Get.to(() => const CreateNewPostScreen());
                    },
                  );
                }),
              ),
              Consumer6<NewsFeedPostProvider, LikeCommentShareProvider, CreatePostProvider, ProfileDetailsProvider, SinglePostProvider,
                      PublicProfileDetailsProvider>(
                  builder: (context, newsfeedProvider, likeCommentShareProvider, postCreateProvider, profileProvider, singlePostProvider,
                      publicProfileProvider, child) {
                return (newsfeedProvider.results.isEmpty)
                    ? Padding(padding: EdgeInsets.only(top: height * 0.3), child: const Center(child: CupertinoActivityIndicator()))
                    : Consumer6<UserNewsfeedPostProvider, CreatePostProvider, CreateGroupPost, CreatePagePost, SingleVideoShowProvider,
                            ReportPostProvider>(
                        builder: (context, userNewsfeedPostProvider, createPostProvider, createGroupPost, createPagePost,
                            singleVideoShowProvider, reportPostProvider, child) {
                        return SizedBox();
                      });
              })
            ],
          ),
        ),
      ),
    );
  }
}
