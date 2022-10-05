import 'package:als_frontend/old_code/provider/post/news_feed_post_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SinglePostImage extends StatelessWidget {
  const SinglePostImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Consumer<NewsFeedPostProvider>(
        builder: (context, provider, child) {
          return Center(
            child: Image.network("${provider.posts![provider.index].images[provider.singleImageIndex]["image"]}",
              fit: BoxFit.cover,
            ),
          );
        }
      ),
    );
  }
}