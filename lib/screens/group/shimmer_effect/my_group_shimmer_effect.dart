import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MyGroupShimmerWidget extends StatelessWidget {


  const MyGroupShimmerWidget( {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: 1,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(5),
              child: SingleChildScrollView(
                child: Column(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                        baseColor: Colors.black.withOpacity(.1),
                        highlightColor: Colors.grey.withOpacity(.1),
                        child: Container(
                          height: 150,
                          margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
                        )),
                   Row(
                     children: [
                       Shimmer.fromColors(
                           baseColor: Colors.black.withOpacity(.1),
                           highlightColor: Colors.grey.withOpacity(.1),
                           child: Container(
                             height: 30,
                             width: 100,
                             margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                             decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
                           )),
                       const Spacer(),
                       Shimmer.fromColors(
                           baseColor: Colors.black.withOpacity(.1),
                           highlightColor: Colors.grey.withOpacity(.1),
                           child: Container(
                             height: 30,
                             width: 100,
                             margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                             decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
                           )),

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
            );
          }),
    );
  }
}
