
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PageHomeScreenShimmer extends StatelessWidget {


  const PageHomeScreenShimmer( {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 20,left: 10,right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(width: 1,),
                Shimmer.fromColors(
                    baseColor: Colors.black.withOpacity(.1),
                    highlightColor: Colors.grey.withOpacity(.1),
                    child:Container(
                      height: 40,
                      width: width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)
                      ),

                    )
                ),
                SizedBox(height: height*0.02,),
                Shimmer.fromColors(
                    baseColor: Colors.black.withOpacity(.1),
                    highlightColor: Colors.grey.withOpacity(.1),
                    child:Container(
                      height: 40,
                      width: width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)
                      ),

                    )
                ),
                SizedBox(height: height*0.02,),
                const Divider(height: 1, color: Colors.black45),

                SizedBox(height: height*0.03,),

             Shimmer.fromColors(
                  baseColor: Colors.black.withOpacity(.1),
                  highlightColor: Colors.grey.withOpacity(.1),
                  child: const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                  ),
                ),
                SizedBox(height: height*0.03,),
                Shimmer.fromColors(
                  baseColor: Colors.black.withOpacity(.1),
                  highlightColor: Colors.grey.withOpacity(.1),
                  child: const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                  ),
                ),
                SizedBox(height: height*0.03,),
                Shimmer.fromColors(
                  baseColor: Colors.black.withOpacity(.1),
                  highlightColor: Colors.grey.withOpacity(.1),
                  child: const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                  ),
                ),
                SizedBox(height: height*0.03,),
                Shimmer.fromColors(
                  baseColor: Colors.black.withOpacity(.1),
                  highlightColor: Colors.grey.withOpacity(.1),
                  child: const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}
