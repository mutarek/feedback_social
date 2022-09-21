import 'package:als_frontend/const/palette.dart';
import 'package:als_frontend/provider/Group%20Page/Group/group_images_provider.dart';
import 'package:als_frontend/provider/provider.dart';
import 'package:als_frontend/screens/profile/user/edit_profile.dart';
import 'package:als_frontend/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';


void main(){
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return 
    MultiProvider(
    providers: [
      

              
      ChangeNotifierProvider(create: (_) => LoginProvider()),
      ChangeNotifierProvider(create: (_) => RegistrationProvider()),
      ChangeNotifierProvider(create: (_) => ShowPasswordProvider()),
      ChangeNotifierProvider(create: (_) => DatabaseProvider()),
      ChangeNotifierProvider(create: (_) => NotificationsProvider()),
      ChangeNotifierProvider(create: (_) => NewsFeedPostProvider()),
      ChangeNotifierProvider(create: (_) => LikeCommentShareProvider()),
      ChangeNotifierProvider(create: (_) => GetInfoFromDb()),
      ChangeNotifierProvider(create: (_) => AddAnimalProvider()),
      ChangeNotifierProvider(create: (_) => UserProfileProvider()),
      ChangeNotifierProvider(create: (_) => FriendRequestProvider()),
      ChangeNotifierProvider(create: (_) => ConfirmFriendRequestProvider()),
      ChangeNotifierProvider(create: (_) => AddFriendProvider()),
      ChangeNotifierProvider(create: (_) => CreatePageProvider()),
      ChangeNotifierProvider(create: (_) => AllPageProvider()),
      ChangeNotifierProvider(create: (_) => CreateGroupProvider()),
      ChangeNotifierProvider(create: (_) => AllGroupProvider()),
      ChangeNotifierProvider(create: (_) => AuthorPagesProvider()),
      ChangeNotifierProvider(create: (_) => EmailVerifyProvider()),
      ChangeNotifierProvider(create: (_) => AuthorGroupProvider()),
      ChangeNotifierProvider(create: (_) => WritePagePostProvider()),
      ChangeNotifierProvider(create: (_) => OwnerAnimalProvider()),
      ChangeNotifierProvider(create: (_) => AnimalSearchProvider()),
      ChangeNotifierProvider(create: (_) => EditProfileProvider()),
      ChangeNotifierProvider(create: (_) => CreatePostProvider()),
      ChangeNotifierProvider(create: (_) => SinglePostProvider()),
      ChangeNotifierProvider(create: (_) => ProfileDetailsProvider()),
      ChangeNotifierProvider(create: (_) => UpdateCoverPhotProvider()),
      ChangeNotifierProvider(create: (_) => UpdateProfileImageProvider()),
      ChangeNotifierProvider(create: (_) => UpdatePageProfileImageProvider()),
      // ChangeNotifierProvider(create: (_) => ProfileNewsFeedPostProvider()),
      // ChangeNotifierProvider(create: (_) => OtherProfileNewsFeedPostProvider()),
      ChangeNotifierProvider(create: (_) => ForgotPasswordProvider()),
      ChangeNotifierProvider(create: (_) => GroupMembersProvider()),  
      ChangeNotifierProvider(create: (_) => ShareTimeLinePostProvider()),
      ChangeNotifierProvider(create: (_) => FriendsListProvider()),
      ChangeNotifierProvider(create: (_) => PublicProfileDetailsProvider()), 
      ChangeNotifierProvider(create: (_) => AuthorPageDetailsProvider()), 
      ChangeNotifierProvider(create: (_) => SuggestedPageDetailsProvider()),
      ChangeNotifierProvider(create: (_) => GroupDetailsProvider()),  
      ChangeNotifierProvider(create: (_) => UnFriendProvider()),  
      ChangeNotifierProvider(create: (_) => PrivacyPolicyProvider()), 
      ChangeNotifierProvider(create: (_) => TermsAndConditionsProvider()),
      ChangeNotifierProvider(create: (_) => SearchProvider()), 
      ChangeNotifierProvider(create: (_) => PagePostProvider()),
      ChangeNotifierProvider(create: (_) => PageLikePostShareProvider()), 
      ChangeNotifierProvider(create: (_) => CreatePagePost()),  
      ChangeNotifierProvider(create: (_) => GroupPostProvider()), 
      ChangeNotifierProvider(create: (_) => CreateGroupPost()),  
      ChangeNotifierProvider(create: (_) => UserNewsfeedPostProvider()), 
      ChangeNotifierProvider(create: (_) => PageLikeProvider()),
      ChangeNotifierProvider(create: (_) => ProfileImagesProvider()), 
      ChangeNotifierProvider(create: (_) => GroupImagesProvider()),
      ChangeNotifierProvider(create: (_) => PageImagesProvider()),
      ChangeNotifierProvider(create: (_) => GroupInviteProvider()), 
      ChangeNotifierProvider(create: (_) => GroupInviteFriendListProvider()),
      ChangeNotifierProvider(create: (_) => GroupFriendSearchProvider()),
      ChangeNotifierProvider(create: (_) => JoinGroupProvider()), 
      ChangeNotifierProvider(create: (_) => GroupPostLikeCommentProvider()), 
      ChangeNotifierProvider(create: (_) => EditGroupProvider()),  
      ChangeNotifierProvider(create: (_) => EditPageProvider()), 
      ChangeNotifierProvider(create: (_) => PostImagesPreviewProvider()), 
      ChangeNotifierProvider(create: (_) => SingleVideoShowProvider()), 
      ChangeNotifierProvider(create: (_) => ProfileVideosProvider()), 
      ChangeNotifierProvider(create: (_) => PageVideoProvider()), 
      ChangeNotifierProvider(create: (_) => GroupVideoProvider()),

       ChangeNotifierProvider(create: (_) => UpdateAccountProvider()),
          ChangeNotifierProvider(create: (_) => PasswordUpdateProviders()),
          ChangeNotifierProvider(create: (_) => NotificationUpdateProvider()),
          ChangeNotifierProvider(create: (_) => SecurityUpdateProvider()),
          ChangeNotifierProvider(create: (_) => SecurityGmailUpdateProvider()),
          ChangeNotifierProvider(create: (_) => ParivacyAudienceTagProvider()),
          ChangeNotifierProvider(
              create: (_) => ParivacyDirectMessagesProvider()),
          ChangeNotifierProvider(create: (_) => LcsProvider()),
          ChangeNotifierProvider(create: (_) => PLikeProvider()),
          ChangeNotifierProvider(create: (_) => ParivacyCommnetProvider()),
          ChangeNotifierProvider(create: (_) => ParivacyShareProvider()),
          ChangeNotifierProvider(create: (_) => BlockUpProvider()),
          ChangeNotifierProvider(create: (_) => UnblockProvider()),
          ChangeNotifierProvider(
              create: (_) => DiscoversbilityProvider()),
          ChangeNotifierProvider(create: (_) => AbilityProvider()),
          ChangeNotifierProvider(create: (_) => colorUpProvider()),
          ChangeNotifierProvider(create: (_) => DisplayProvider()),
          ChangeNotifierProvider(create: (_) => DataUsesvalueProvider()),
          ChangeNotifierProvider(create: (_) => AutoplayProvider()),
          ChangeNotifierProvider(create: (_) => DatasaveProvider()),
          ChangeNotifierProvider(create: (_) => SettingsNotificationProvider()),
          ChangeNotifierProvider(create: (_) => SettingsSecurityProvider()),
          ChangeNotifierProvider(create: (_) => SettingsAudienceTagProvider()),
          ChangeNotifierProvider(
              create: (_) => SettingsDrectMassagesProvider()),
          ChangeNotifierProvider(
              create: (_) => ReportPostProvider()),
     
    ],
    child: GetMaterialApp(
      theme: Theme.of(context).copyWith(
        
      colorScheme: Theme.of(context).colorScheme.copyWith(
        primary: Palette.primary,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      )
    );
  }
}
