import 'package:als_frontend/provider/other_provider.dart';
import 'package:als_frontend/provider/page_provider.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageProfileCover extends StatefulWidget {

  const PageProfileCover({Key? key}) : super(key: key);

  @override
  State<PageProfileCover> createState() => _PageProfileCoverState();
}

class _PageProfileCoverState extends State<PageProfileCover> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const CustomText(title: "Feedback Pages", color: AppColors.primaryColorLight, fontWeight: FontWeight.bold, fontSize: 27),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: const [
          CircleAvatar(
            backgroundColor: AppColors.primaryColorLight,
            child: Center(
              child: Icon(
                Icons.settings,
                size: 25.0,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
        ],
      ),
      body: Consumer2<OtherProvider, PageProvider>(builder: (context, otherProvider, pageProvider, child) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                const SizedBox(height: 5,),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    title: "Want to make your page more attractive ?",
                    fontSize: 22,
                    color: AppColors.primaryColorLight,
                    fontWeight: FontWeight.w500,
                    maxLines: 2,
                  ),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "you must select a profile picture and cover photo that describe your page perfectly.",
                    style: TextStyle(fontSize: 10, color: AppColors.primaryColorLight, fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 5,),
                Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 165,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              border: Border.all(color: AppColors.primaryColorLight,width: 1)
                          ),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    height: 35,
                                    width: 35,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.primaryColorLight,
                                    ),
                                    child: const Icon(Icons.camera_alt,color: Colors.white,),
                                  ),
                                )
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 50,),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: CustomText(
                            title: "Page Name Goes Here",
                            fontSize: 22,
                            color: AppColors.primaryColorLight,
                            fontWeight: FontWeight.w500,
                            maxLines: 2,
                          ),
                        ),
                        const SizedBox(height: 250,),
                        InkWell(
                          onTap: (){
                            //Helper.toScreen(PageProfileCover());
                          },
                          child: Container(
                            padding: EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: AppColors.primaryColorLight,
                            ),
                            child: const Center(
                              child: CustomText(
                                title: "Create Page",
                                fontSize: 25,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Positioned(
                      top: 100.0,
                      left: 7,// (background container size) - (circle height / 2)
                      child: Container(
                        height: 90.0,
                        width: 94.0,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primaryColorLight),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),

                        ),
                        child:  Stack(
                          children: [
                            Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: Container(
                                    padding: const EdgeInsets.all(1),
                                    height: 25,
                                    width: 25,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.primaryColorLight,
                                    ),
                                    child: const Icon(Icons.camera_alt,color: Colors.white,size: 15,),
                                  ),
                                )
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
