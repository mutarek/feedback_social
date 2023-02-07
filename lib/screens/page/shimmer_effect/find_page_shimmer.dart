
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FindPageShimmer extends StatelessWidget {


  const FindPageShimmer( {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          body: Padding(
              padding: const EdgeInsets.only(top: 20,left: 10,right: 10),
              child: Column(
                children: [
                  Shimmer.fromColors(
                      baseColor: Colors.black.withOpacity(.1),
                      highlightColor: Colors.grey.withOpacity(.1),
                      child:Container(
                        height: 50,
                        width: width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)
                        ),

                      )
                  ),
                  const SizedBox(height: 10,),
                  Shimmer.fromColors(
                      baseColor: Colors.black.withOpacity(.1),
                      highlightColor: Colors.grey.withOpacity(.1),
                      child:Container(
                        height: 50,
                        width: width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)
                        ),

                      )
                  ),
                  const SizedBox(height: 10,),
                  Shimmer.fromColors(
                      baseColor: Colors.black.withOpacity(.1),
                      highlightColor: Colors.grey.withOpacity(.1),
                      child:Container(
                        height: 50,
                        width: width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)
                        ),

                      )
                  ),
                  const SizedBox(height: 10,),
                  Shimmer.fromColors(
                      baseColor: Colors.black.withOpacity(.1),
                      highlightColor: Colors.grey.withOpacity(.1),
                      child:Container(
                        height: 50,
                        width: width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)
                        ),

                      )
                  ),
                  const SizedBox(height: 10,)
                ],
              )
          )
      ),
    );
  }
}
