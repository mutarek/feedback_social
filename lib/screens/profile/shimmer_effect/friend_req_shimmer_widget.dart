
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FriendReqShimmerWidget extends StatelessWidget {


  const FriendReqShimmerWidget( {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
            itemCount: 20,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(

                children: [

                  Shimmer.fromColors(
              baseColor: Colors.black.withOpacity(.1),
              highlightColor: Colors.grey.withOpacity(.1),
                    child: Padding(
                      padding:  const EdgeInsets.only(left: 10,right: 10,top: 5,),
                      child: Container(
                        height: 50,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:Colors.white
                        ),
                        child: Row(
                          children: [
                            Shimmer.fromColors(
                              baseColor: Colors.black.withOpacity(.1),
                              highlightColor: Colors.grey.withOpacity(.1),
                              child: const CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.white,
                              ),
                            ),
                            Shimmer.fromColors(
                              baseColor: Colors.black.withOpacity(.1),
                              highlightColor: Colors.grey.withOpacity(.1),
                              child: Container(
                                height: 10,
                                width: 40,
                                color:Colors.white
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              );
            }),
      ),
    );
  }
}
