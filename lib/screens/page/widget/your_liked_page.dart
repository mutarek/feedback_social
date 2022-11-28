
import 'package:als_frontend/localization/language_constrants.dart';
import 'package:als_frontend/provider/page_provider.dart';
import 'package:als_frontend/screens/page/public_page_screen.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';

class YourLikedPage extends StatelessWidget {
  const YourLikedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text( getTranslated("liked page", context),style: latoStyle800ExtraBold,),

        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Consumer<PageProvider>(
          builder: (context, pageProvider, child) {
            final double height = MediaQuery.of(context).size.height;
            final double width = MediaQuery.of(context).size.width;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  itemCount: pageProvider.likedPageLists.length,
                  itemBuilder: (context,index){
                    return InkWell(
                      onTap: () {
                        Get.to(PublicPageScreen(
                            pageProvider.likedPageLists[index].id.toString()));
                      },
                      child: ListTile(
                          leading: CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.black12,
                            backgroundImage:
                            NetworkImage(pageProvider.likedPageLists[index].avatar),
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
                              Text(pageProvider.likedPageLists[index].name,
                                  style: latoStyle700Bold),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                  "${pageProvider.likedPageLists[index].followers.toString()} ${getTranslated("Followers", context)}",
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
