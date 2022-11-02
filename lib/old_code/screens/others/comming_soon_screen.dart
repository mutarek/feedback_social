import 'package:flutter/material.dart';

import '../../const/palette.dart';

class CommingSoonScreen extends StatelessWidget {
  const CommingSoonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Palette.scaffold,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "FeedBack",
          style: TextStyle(
              color: Palette.primary,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: -1.2),
        ),
      ),
      body: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            return Padding(
              padding:  EdgeInsets.only(left: width*0.01,bottom: height*0.02,),
              child: Stack(
                children: [
                  Container(
                    height: height*0.1,
                    width: width*0.94,
                    
                   decoration: BoxDecoration(
                    color: Colors.amber,borderRadius: BorderRadius.circular(8)
                   ),
               child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: width*0.3,
                  )
                ],
               ),
          
                  ),
                ],
              ),
            );

          }),
    );
  }
}
