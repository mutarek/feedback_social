// import 'package:als_frontend/provider/provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class SinglePhotoView extends StatelessWidget {
//   const SinglePhotoView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Consumer<AllPageProvider>(builder: (context, provider, child) {
//         return Center(
//           child: Image.network(
//             "${provider.pages![provider.pageIndex].photos[provider.singleImageIndex]["image"]}",
//             fit: BoxFit.cover,
//           ),
//         );
//       }),
//     );
//   }
// }
