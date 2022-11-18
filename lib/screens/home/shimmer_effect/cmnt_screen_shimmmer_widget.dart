
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CommentShimmerWidget extends StatelessWidget {


  const CommentShimmerWidget( {Key? key}) : super(key: key);

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
            children: [

              Row(
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.black.withOpacity(.1),
                    highlightColor: Colors.grey.withOpacity(.1),
                    child: const CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 5,),
                  Shimmer.fromColors(
                      baseColor: Colors.black.withOpacity(.1),
                      highlightColor: Colors.grey.withOpacity(.1),
                      child:Container(
                        height: 20,
                        width: 100,
                       decoration: BoxDecoration(
                           color: Colors.white,
                         borderRadius: BorderRadius.circular(5)
                       ),
                      )
                  ),
                ],
              ),
              SizedBox(height: height*0.02,),
              Shimmer.fromColors(
                  baseColor: Colors.black.withOpacity(.1),
                  highlightColor: Colors.grey.withOpacity(.1),
                  child:Container(
                    height: height*0.4,
                    width: width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)
                    ),
                  )
              ),

              SizedBox(height: height*0.03,),
              Shimmer.fromColors(
                  baseColor: Colors.black.withOpacity(.1),
                  highlightColor: Colors.grey.withOpacity(.1),
                  child:Container(
                    height: height*0.06,
                    width: width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)
                    ),
                  )
              ),
              SizedBox(height: height*0.01,),
              Shimmer.fromColors(
                  baseColor: Colors.black.withOpacity(.1),
                  highlightColor: Colors.grey.withOpacity(.1),
                  child:Container(
                    height: height*0.06,
                    width: width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)
                    ),
                  )
              ),
              SizedBox(height: height*0.01,),
              Shimmer.fromColors(
                  baseColor: Colors.black.withOpacity(.1),
                  highlightColor: Colors.grey.withOpacity(.1),
                  child:Container(
                    height: height*0.06,
                    width: width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)
                    ),
                  )
              ),
              SizedBox(height: height*0.01,),
              Shimmer.fromColors(
                  baseColor: Colors.black.withOpacity(.1),
                  highlightColor: Colors.grey.withOpacity(.1),
                  child:Container(
                    height: height*0.06,
                    width: width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)
                    ),
                  )
              ),
            ],
          ),
        )
      ),
    );
  }
}
