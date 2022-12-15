
import 'package:als_frontend/provider/page_provider.dart';
import 'package:als_frontend/screens/page/public_page_screen.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../translations/locale_keys.g.dart';

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(LocaleKeys.my_Page.tr(),style: latoStyle800ExtraBold,),

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
                  itemCount: pageProvider.authorPageLists.length,
                  itemBuilder: (context,index){
                    return InkWell(
                      onTap: () {
                        Helper.toScreen(PublicPageScreen(pageProvider.authorPageLists[index].id.toString()));
                      },
                      child: ListTile(
                          leading: CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.black12,
                            backgroundImage:
                            NetworkImage(pageProvider.authorPageLists[index].avatar),
                          ),
                          trailing: Container(
                            height: height * 0.027,
                            width: width * 0.15,
                            decoration: BoxDecoration(
                                color: const Color(0xff090D2A),
                                borderRadius: BorderRadius.circular(4)),
                            child: Center(
                                child: Text(
                                  LocaleKeys.follow.tr(),
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
                              Text(pageProvider.authorPageLists[index].name,
                                  style: latoStyle700Bold),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                  "${pageProvider.authorPageLists[index].followers.toString()} ${LocaleKeys.followers.tr()}",
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
