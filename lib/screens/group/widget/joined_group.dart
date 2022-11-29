
import 'package:als_frontend/localization/language_constrants.dart';
import 'package:als_frontend/provider/group_provider.dart';
import 'package:als_frontend/screens/page/public_page_screen.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';

class JoinedGroup extends StatelessWidget {
  const JoinedGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text( getTranslated("Joined group", context),style: latoStyle800ExtraBold,),

        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Consumer<GroupProvider>(
          builder: (context, groupProvider, child) {
            final double height = MediaQuery.of(context).size.height;
            final double width = MediaQuery.of(context).size.width;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  itemCount: groupProvider.myGroupList.length,
                  itemBuilder: (context,index){
                    return InkWell(
                      onTap: () {
                        Get.to(PublicPageScreen(
                            groupProvider.myGroupList[index].id.toString()));
                      },
                      child: ListTile(
                          leading: CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.black12,
                            backgroundImage:
                            NetworkImage(groupProvider.myGroupList[index].coverPhoto),
                          ),
                          trailing: Container(
                            height: height * 0.027,
                            width: width * 0.15,
                            decoration: BoxDecoration(
                                color: const Color(0xff090D2A),
                                borderRadius: BorderRadius.circular(4)),
                            child: Center(
                                child: Text(
                                  getTranslated("Follow", context),
                                  style: latoStyle600SemiBold.copyWith(
                                      color: Colors.white, fontSize: 10),
                                )),
                          ),
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: height * 0.01,
                              ),
                              Text(groupProvider.myGroupList[index].name,
                                  style: latoStyle700Bold),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                  "${groupProvider.myGroupList[index].totalMember.toString()} ${getTranslated("Followers", context)}",
                                  style: latoStyle100Thin.copyWith(fontSize: 10)),
                            ],
                          )),
                    );
                  }),
            );
          }
      ),
    );
  }
}
