import 'package:als_frontend/new_page_degsin/widget/Page_view_card.dart';
import 'package:als_frontend/new_page_degsin/widget/like_invite_find.dart';
import 'package:als_frontend/provider/page_provider.dart';
import 'package:als_frontend/util/palette.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreatePage extends StatelessWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          "Feedback Pages",
          style: latoStyle700Bold.copyWith(color: Palette.primary),
        ),
        actions: [
          PopupMenuButton(
            icon: CircleAvatar(
                backgroundColor: AppColors.primaryColorLight,
                radius: 20,
                child: Icon(
                  Icons.settings,
                  color: Colors.white,
                )),
            itemBuilder: (context) => [
              // PopupMenuItem 1
              PopupMenuItem(
                value: 1,
                // row with 2 children
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Notifications Setting",
                      style: latoStyle600SemiBold.copyWith(color: Palette.primary),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.notifications_active,
                          color: Palette.primary,
                          size: 20,
                        ),
                        Text(
                          "Notifications",
                          style: latoStyle400Regular.copyWith(color: Palette.primary),
                        ),
                        SizedBox(
                          height: 30,
                          width: 30,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: CupertinoSwitch(
                              value: true,
                              onChanged: (value) {},
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.message,
                          color: Palette.primary,
                          size: 20,
                        ),
                        Text(
                          "Message",
                          style: latoStyle400Regular.copyWith(color: Palette.primary),
                        ),
                        SizedBox(
                          height: 30,
                          width: 30,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: CupertinoSwitch(
                              value: true,
                              onChanged: (value) {},
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              // PopupMenuItem 2
            ],
            offset: Offset(0, 58),
            color: Colors.white,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Consumer<PageProvider>(

          builder: (context,pageProvider,child) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration:
                        BoxDecoration(color: Color(0xffEDEFF2), borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.flag,
                              color: AppColors.primaryColorLight,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Your Pages",
                                style: latoStyle600SemiBold.copyWith(color: AppColors.primaryColorLight),
                              ),
                              Text(
                                "You can manage them by click on page switch mode button.",
                                style: latoStyle300Light.copyWith(
                                    color: AppColors.primaryColorLight, fontSize: 8),
                              )
                            ],
                          ),
                          SizedBox(width: 10,),
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: AppColors.primaryColorLight,
                            child: InkWell(
                              onTap: (){
                                pageProvider.changeExpended();
                                print(pageProvider.pageExpended);
                              },

                                child: pageProvider.pageExpended==true?Icon(Icons.arrow_drop_down,color: Colors.white,):Icon(Icons.arrow_drop_up,color: Colors.white,)),
                          )
                        ],
                      ),
                    ),
                  ),

               pageProvider.pageExpended == true? Container(
                   height: 250,
                   child: ListView.builder(
                       itemCount: 4,
                       itemBuilder: (context,index){
                         return PageviewCard(ontap: () {  }, name: 'Your Pages', icon: Icons.favorite, message: '20 message',);
                       })):SizedBox.shrink(),

                  SizedBox(height: 10,),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.imageBGColorLight,borderRadius: BorderRadius.circular(30)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 7,
                          backgroundColor: AppColors.primaryColorLight,
                          child: CircleAvatar(
                            radius: 6,
                            backgroundColor:  AppColors.imageBGColorLight,
                            child: Icon(Icons.add,size: 12,color: AppColors.primaryColorLight,),
                          ),
                        ),
                        SizedBox(width: 3,),
                        Text("Create a new Pages",style: latoStyle700Bold.copyWith(color: AppColors.primaryColorLight,fontSize: 18),)
                      ],
                    ),
                  ),
                  SizedBox(height: 5,),
                  Divider(
                    height: 1,
                    color: Colors.black45,
                  ),
                  SizedBox(height: 5,),
                  LikeInviteFindWidget(
                    icon: Icons.thumb_up,
                    name: "Your liked pages",
                    extraArguments: " 30 pages",
                  ),
                  SizedBox(height: 10,),
                  LikeInviteFindWidget(
                    icon: Icons.inventory_outlined,
                    name: "Invite Pages",
                    extraArguments: " 25 new invites",
                  ),
                  SizedBox(height: 10,),
                  LikeInviteFindWidget(
                    icon: Icons.search,
                    name: "Find pages",
                    // extraArguments: " 30 pages",
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
