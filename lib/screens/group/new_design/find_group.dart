import 'package:als_frontend/screens/page/widget/page_app_bar.dart';
import 'package:als_frontend/screens/page/widget/popup_menu_widget.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../util/image.dart';

class FindGroup extends StatelessWidget {
  const FindGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PageAppBar(title: 'Find Groups'),
      body: Padding(
        padding: const EdgeInsets.only(left: 10,right: 10,top: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  height: 48.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primaryColorLight),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        child: TextField(
                          decoration:
                          InputDecoration(border: InputBorder.none, hintText: "Search..", hintStyle: TextStyle(color: Colors.black)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: AppColors.primaryColorLight),
                          height: 38,
                          width: 71,
                          child: Center(
                            child: Text('Search', style: robotoStyle300Light.copyWith(fontSize: 12,color: Colors.white)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 1200,
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (_,index){
                    return Card(
                      elevation: 1,
                      color: (const Color(0xffFAFAFA)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: SizedBox(
                        height: 112,
                        width: double.infinity,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: SizedBox(
                                      height: 36,
                                        width: 36,
                                        child: customNetworkImage("https://res.cloudinary.com/dhakacity/images/f_auto,q_auto/v1670167422/Travel-logo-transparency/Travel-logo-transparency.png",height: 36,boxFit: BoxFit.fitWidth))
                                  ),
                                  const SizedBox(width: 10,),

                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Govt Job BD',style: robotoStyle700Bold.copyWith(fontSize: 15,color: AppColors.primaryColorLight)),
                                      Row(
                                        children: [
                                          Text('570K Members - 10+ Post a Day',style: robotoStyle500Medium.copyWith(fontSize: 10,color: AppColors.primaryColorLight),),
                                          const SizedBox(width: 10,),
                                          Row(
                                            children: [
                                              SvgPicture.asset("assets/svg/last_minute_icon.svg", width: 14, height: 14),
                                              const SizedBox(width: 2),
                                              Text('Last active 50 minutes ago', style: robotoStyle500Medium.copyWith(fontSize: 9)),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20,right: 20),
                                child: Row(
                                  children: [
                                    Card(
                                      elevation: 1,
                                      color: index%2==0?const Color(0xffFAFAFA):const Color(0xff080C2F),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)
                                      ),
                                      child: SizedBox(
                                        height: 37,
                                        width: 250,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset("assets/svg/join_group_svg.svg",height: 17,width: 20,color: index%2==0?AppColors.primaryColorLight:Colors.white,),
                                            const SizedBox(width: 5,),
                                            Text(index%2==0?"Join Group":"Joined",style: robotoStyle700Bold.copyWith(fontSize: 15,color: index%2==0?AppColors.primaryColorLight:Colors.white))
                                          ],
                                        ),
                                      ),
                                    ),
                                    Card(
                                      elevation: 1,
                                      color: (const Color(0xffFAFAFA)),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)
                                      ),
                                      child: SizedBox(
                                        height: 37,
                                        width: 70,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children:  [
                                            PopupMenuButton(
                                                itemBuilder: (context) => [
                                                  // PopupMenuItem 1
                                                  PopupMenuItem(
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        PopUpMenuWidget(ImagesModel.visitGroupIcons, 'Visit Group', () {},isShowAssetImage: false,),
                                                        const SizedBox(
                                                          height: 18,
                                                        ),
                                                        PopUpMenuWidget(ImagesModel.copyIcons, 'Copy Link', () {},isShowAssetImage: false,),
                                                      ],
                                                    ),
                                                  ),
                                                  // PopupMenuItem 2
                                                ],
                                                offset: const Offset(0, 58),
                                                color: Colors.white,
                                                elevation: 4,
                                                shape: const RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                                child: const Icon(Icons.more_horiz)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
