import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/provider.dart';

class SingleImagePreview extends StatelessWidget {
  const SingleImagePreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
     body: Consumer<PostImagesPreviewProvider>(
          builder: (context, imagePreviewProvider, child) {
         return Center(
                  child:SizedBox(
                    child: Image.network(imagePreviewProvider.image)
                              ),
                  );
       }
     )
            );
  }
}