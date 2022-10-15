import 'package:als_frontend/helper/number_helper.dart';
import 'package:als_frontend/data/model/response/news_feed_model.dart';
import 'package:als_frontend/screens/home/widget/profile_avatar.dart';
import 'package:als_frontend/screens/profile/public_profile_screen.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter/material.dart';

class PostHeaderWidget extends StatelessWidget {
  final NewsFeedData post;

  const PostHeaderWidget({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileAvatar(profileImageUrl: post.author!.profileImage!),
        const SizedBox(width: 8.0),
        Expanded(
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => PublicProfileScreen(post.author!.id.toString())));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(post.author!.fullName!, style: latoStyle500Medium.copyWith(fontWeight: FontWeight.w600)),
                Row(
                  children: [
                    Text(getDate(post.timestamp!, context), style: latoStyle400Regular.copyWith(color: Colors.grey[600], fontSize: 12.0)),
                    Icon(Icons.public, color: Colors.grey[600], size: 12.0)
                  ],
                )
              ],
            ),
          ),
        ),
        IconButton(icon: const Icon(Icons.more_horiz), onPressed: () => print('More')),
      ],
    );
  }
}
