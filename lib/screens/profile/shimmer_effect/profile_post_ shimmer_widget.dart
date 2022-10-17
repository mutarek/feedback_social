import 'package:als_frontend/old_code/const/palette.dart';
import 'package:als_frontend/screens/page/widget/cover_photo_widget.dart';
import 'package:als_frontend/screens/profile/widget/profile_photo_widget.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class profilePostShimmerWidget extends StatelessWidget {


  const profilePostShimmerWidget( {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
            itemCount: 1,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(

                children: [
                  Container(
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
                              child: CircleAvatar(
                                radius: 40,
                                  backgroundColor: Colors.white)),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.all(5),
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
                        SizedBox(height: 10,),
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
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Shimmer.fromColors(
                                baseColor: Colors.black.withOpacity(.1),
                                highlightColor: Colors.grey.withOpacity(.1),
                                child: CircleAvatar(backgroundColor: Colors.white)),
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
                                  SizedBox(height: 5),
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
                                      SizedBox(width: 5),
                                      Shimmer.fromColors(
                                          baseColor: Colors.black.withOpacity(.1),
                                          highlightColor: Colors.grey.withOpacity(.1),
                                          child: CircleAvatar(backgroundColor: Colors.white, radius: 5)),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(width: 10)
                          ],
                        ),

                        Shimmer.fromColors(
                            baseColor: Colors.black.withOpacity(.1),
                            highlightColor: Colors.grey.withOpacity(.1),
                            child: Container(
                              height: 80,
                              margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
                            )),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Shimmer.fromColors(
                                baseColor: Colors.black.withOpacity(.1),
                                highlightColor: Colors.grey.withOpacity(.1),
                                child: CircleAvatar(backgroundColor: Colors.white)),
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
                                  SizedBox(height: 5),
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
                                      SizedBox(width: 5),
                                      Shimmer.fromColors(
                                          baseColor: Colors.black.withOpacity(.1),
                                          highlightColor: Colors.grey.withOpacity(.1),
                                          child: CircleAvatar(backgroundColor: Colors.white, radius: 5)),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(width: 10)
                          ],
                        ),

                        Shimmer.fromColors(
                            baseColor: Colors.black.withOpacity(.1),
                            highlightColor: Colors.grey.withOpacity(.1),
                            child: Container(
                              height: 80,
                              margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
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
