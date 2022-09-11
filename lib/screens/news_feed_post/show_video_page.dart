import 'package:als_frontend/provider/provider.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class ShowVideoPage extends StatefulWidget {
  const ShowVideoPage({Key? key}) : super(key: key);

  @override
  State<ShowVideoPage> createState() => _ShowVideoPageState();
}

class _ShowVideoPageState extends State<ShowVideoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<SingleVideoShowProvider>(
        builder: (context, singleVideoShowProvider, child) {
          return BetterPlayer.network(singleVideoShowProvider.videoUrl);
        }
      ),
    );
  }
}
