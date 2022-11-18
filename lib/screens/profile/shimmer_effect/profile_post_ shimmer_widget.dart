import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProfilePostShimmerWidget extends StatelessWidget {


  const ProfilePostShimmerWidget( {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
            itemCount: 1,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(

                children: [
                  SizedBox(
                    height: 250,
                    child: Stack(
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.black.withOpacity(.1),
                          highlightColor: Colors.grey.withOpacity(.1),
                          child: Container(
                            color:Colors.white,
                            height: 200,
                          ),),
                        Positioned(
                          top: 150,
                          left: 20,
                          child: Shimmer.fromColors(
                              baseColor: Colors.black.withOpacity(.1),
                              highlightColor: Colors.grey.withOpacity(.1),
                              child: const CircleAvatar(
                                radius: 40,
                                  backgroundColor: Colors.white)),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10,),
                  Container(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.black.withOpacity(.1),
                          highlightColor: Colors.grey.withOpacity(.1),
                          child: Container(
                            color: Colors.white,
                            height: 30,
                            width: 320,
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Shimmer.fromColors(
                          baseColor: Colors.black.withOpacity(.1),
                          highlightColor: Colors.grey.withOpacity(.1),
                          child: Container(
                           decoration: BoxDecoration(
                             color: Colors.white,
                             borderRadius: BorderRadius.circular(10)
                           ),
                            height: 150,
                            width: 320,
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          children: [
                            Shimmer.fromColors(
                                baseColor: Colors.black.withOpacity(.1),
                                highlightColor: Colors.grey.withOpacity(.1),
                                child: const CircleAvatar(backgroundColor: Colors.white)),
                            const SizedBox(width: 8.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Shimmer.fromColors(
                                      baseColor: Colors.black.withOpacity(.1),
                                      highlightColor: Colors.grey.withOpacity(.1),
                                      child: Container(
                                        height: 15,
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
                                      )),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Shimmer.fromColors(
                                          baseColor: Colors.black.withOpacity(.1),
                                          highlightColor: Colors.grey.withOpacity(.1),
                                          child: Container(
                                            height: 10,
                                            width: 100,
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
                                          )),
                                      const SizedBox(width: 5),
                                      Shimmer.fromColors(
                                          baseColor: Colors.black.withOpacity(.1),
                                          highlightColor: Colors.grey.withOpacity(.1),
                                          child: const CircleAvatar(backgroundColor: Colors.white, radius: 5)),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(width: 10)
                          ],
                        ),

                        Shimmer.fromColors(
                            baseColor: Colors.black.withOpacity(.1),
                            highlightColor: Colors.grey.withOpacity(.1),
                            child: Container(
                              height: 80,
                              margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
                            )),
                        const SizedBox(height: 10,),
                        Row(
                          children: [
                            Shimmer.fromColors(
                                baseColor: Colors.black.withOpacity(.1),
                                highlightColor: Colors.grey.withOpacity(.1),
                                child: const CircleAvatar(backgroundColor: Colors.white)),
                            const SizedBox(width: 8.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Shimmer.fromColors(
                                      baseColor: Colors.black.withOpacity(.1),
                                      highlightColor: Colors.grey.withOpacity(.1),
                                      child: Container(
                                        height: 15,
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
                                      )),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Shimmer.fromColors(
                                          baseColor: Colors.black.withOpacity(.1),
                                          highlightColor: Colors.grey.withOpacity(.1),
                                          child: Container(
                                            height: 10,
                                            width: 100,
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
                                          )),
                                      const SizedBox(width: 5),
                                      Shimmer.fromColors(
                                          baseColor: Colors.black.withOpacity(.1),
                                          highlightColor: Colors.grey.withOpacity(.1),
                                          child: const CircleAvatar(backgroundColor: Colors.white, radius: 5)),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(width: 10)
                          ],
                        ),

                        Shimmer.fromColors(
                            baseColor: Colors.black.withOpacity(.1),
                            highlightColor: Colors.grey.withOpacity(.1),
                            child: Container(
                              height: 80,
                              margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
                            )),

                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
