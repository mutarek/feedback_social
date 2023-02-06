
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NewPageDetailsShimmer extends StatelessWidget {


  const NewPageDetailsShimmer( {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 20,left: 10,right: 10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                      baseColor: Colors.black.withOpacity(.1),
                      highlightColor: Colors.grey.withOpacity(.1),
                      child:Container(
                        height: 200,
                        width: width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                        ),

                      )
                  ),
                  SizedBox(height: height*0.05,),
                  Row(
                    children: [
                      Shimmer.fromColors(
                          baseColor: Colors.black.withOpacity(.1),
                          highlightColor: Colors.grey.withOpacity(.1),
                          child:Container(
                            height: 30,
                            width: 120,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)
                            ),

                          )
                      ),
                      const SizedBox(width: 10,),
                      Shimmer.fromColors(
                          baseColor: Colors.black.withOpacity(.1),
                          highlightColor: Colors.grey.withOpacity(.1),
                          child:Container(
                            height: 30,
                            width: width*0.3,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)
                            ),

                          )
                      ),
                      const SizedBox(width: 10,),
                      Shimmer.fromColors(
                          baseColor: Colors.black.withOpacity(.1),
                          highlightColor: Colors.grey.withOpacity(.1),
                          child:Container(
                            height: 30,
                            width: width*0.2,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)
                            ),

                          )
                      ),
                    ],
                  ),
                  SizedBox(height: height*0.02,),
                  const Divider(height: 1, color: Colors.black45),
                  SizedBox(height: height*0.03,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.black.withOpacity(.1),
                        highlightColor: Colors.grey.withOpacity(.1),
                        child: const CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                        ),
                      ),
                      SizedBox(width: 10,),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Shimmer.fromColors(
                                baseColor: Colors.black.withOpacity(.1),
                                highlightColor: Colors.grey.withOpacity(.1),
                                child:Container(
                                  height: 20,
                                  width: width*0.4,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(3)
                                  ),

                                )
                            ),
                            SizedBox(height: 2,),
                            Shimmer.fromColors(
                                baseColor: Colors.black.withOpacity(.1),
                                highlightColor: Colors.grey.withOpacity(.1),
                                child:Container(
                                  height: 10,
                                  width: width*0.2,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)
                                  ),

                                )
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Shimmer.fromColors(
                      baseColor: Colors.black.withOpacity(.1),
                      highlightColor: Colors.grey.withOpacity(.1),
                      child:Container(
                        height: 200,
                        width: width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)
                        ),

                      )
                  ),
                  SizedBox(height: height*0.03,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.black.withOpacity(.1),
                        highlightColor: Colors.grey.withOpacity(.1),
                        child: const CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                        ),
                      ),
                      SizedBox(width: 10,),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Shimmer.fromColors(
                                baseColor: Colors.black.withOpacity(.1),
                                highlightColor: Colors.grey.withOpacity(.1),
                                child:Container(
                                  height: 20,
                                  width: width*0.4,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(3)
                                  ),

                                )
                            ),
                            SizedBox(height: 2,),
                            Shimmer.fromColors(
                                baseColor: Colors.black.withOpacity(.1),
                                highlightColor: Colors.grey.withOpacity(.1),
                                child:Container(
                                  height: 10,
                                  width: width*0.2,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)
                                  ),

                                )
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Shimmer.fromColors(
                      baseColor: Colors.black.withOpacity(.1),
                      highlightColor: Colors.grey.withOpacity(.1),
                      child:Container(
                        height: 200,
                        width: width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)
                        ),

                      )
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}
