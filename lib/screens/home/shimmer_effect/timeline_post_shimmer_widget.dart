import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TimeLinePostShimmerWidget extends StatelessWidget {
  final int count;

  const TimeLinePostShimmerWidget(this.count, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: count,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
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
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
                    )),
              ],
            ),
          );
        });
  }
}
