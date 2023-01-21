import 'package:flutter/material.dart';

class PageCommentView extends StatefulWidget {
  const PageCommentView({Key? key}) : super(key: key);

  @override
  State<PageCommentView> createState() => _PageCommentViewState();
}

class _PageCommentViewState extends State<PageCommentView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 150,
              width: double.infinity,
              child: Row(
                children: [
                  Container(
                    height: 150,
                    color: Colors.blue,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
