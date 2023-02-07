
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';

class NewSuggestPageShimmer extends StatelessWidget {


  const NewSuggestPageShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          body:  MasonryGridView.count(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              itemCount: 10,
              crossAxisCount: 2,
              crossAxisSpacing: 6,
              mainAxisSpacing: 14,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {

                return  Shimmer.fromColors(
                    baseColor: Colors.black.withOpacity(.1),
                    highlightColor: Colors.grey.withOpacity(.1),
                    child:Container(
                      height: 150,
                      width: width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)
                      ),

                    )
                );
              }),
          )
      );

  }
}
