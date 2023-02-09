import 'package:als_frontend/data/model/response/page/athour_pages_model.dart';
import 'package:als_frontend/provider/other_provider.dart';
import 'package:als_frontend/provider/page_provider.dart';
import 'package:als_frontend/screens/page/widget/page_app_bar.dart';
import 'package:als_frontend/screens/page/widget/popup_menu_widget.dart';
import 'package:als_frontend/util/image.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:als_frontend/widgets/network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class BlockedPageScreen extends StatefulWidget {
  const BlockedPageScreen({Key? key}) : super(key: key);

  @override
  State<BlockedPageScreen> createState() => _BlockedPageScreenState();
}

class _BlockedPageScreenState extends State<BlockedPageScreen> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<PageProvider>(context, listen: false).callForGetPageBlockLists(isFirstTime: true);

    controller.addListener(() {
      if (controller.offset >= controller.position.maxScrollExtent &&
          !controller.position.outOfRange &&
          Provider.of<PageProvider>(context, listen: false).hasNextDataBlockPage) {
        Provider.of<PageProvider>(context, listen: false).updateBlockPageNo();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<OtherProvider, PageProvider>(
      builder: (context, otherProvider, pageProvider, child) {
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: const PageAppBar(title: 'My Page Block'),
            body: pageProvider.isLoadingBlockPage
                ? const Center(child: CircularProgressIndicator())
                : pageProvider.blockPageLists.isNotEmpty
                    ? ModalProgressHUD(
                        inAsyncCall: pageProvider.isLoadingBlockPage2,
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                  controller: controller,
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  itemCount: pageProvider.blockPageLists.length,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    AuthorPageModel pageModel2 = pageProvider.blockPageLists[index];
                                    return Container(
                                      padding: const EdgeInsets.all(8.0),
                                      margin: const EdgeInsets.only(top: 6, bottom: 6),
                                      decoration: BoxDecoration(
                                          color: const Color(0xffFAFAFA),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey.withOpacity(.2),
                                                blurRadius: 10.0,
                                                spreadRadius: 3.0,
                                                offset: const Offset(0.0, 0.0))
                                          ],
                                          borderRadius: BorderRadius.circular(15)),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          circularImage(pageModel2.avatar!, 40, 40),
                                          const SizedBox(width: 15),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(pageModel2.name!, style: robotoStyle700Bold.copyWith(fontSize: 16)),
                                              const SizedBox(height: 5)
                                            ],
                                          ),
                                          const Spacer(),

                                          PopupMenuButton(
                                            itemBuilder: (context) => [
                                              // PopupMenuItem 1
                                              PopupMenuItem(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    PopUpMenuWidget(ImagesModel.blocksIcons, 'Unblock Post', () {
                                                      pageProvider.createUnBlock(pageModel2.id as int, index);
                                                      Navigator.of(context).pop();
                                                    }),
                                                  ],
                                                ),
                                              ),
                                              // PopupMenuItem 2
                                            ],
                                            offset: const Offset(0, 58),
                                            color: Colors.white,
                                            elevation: 4,
                                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                            child: Container(
                                              height: 24,
                                              width: 30,
                                              decoration:
                                                  BoxDecoration(color: const Color(0xffE4E6EB), borderRadius: BorderRadius.circular(10)),
                                              child: const Center(child: Icon(Icons.more_horiz)),
                                            ),
                                          ),

                                          // const CircleAvatar(radius: 15, backgroundColor: Color(0xffE4E6EB), child: Icon(Icons.more_horiz, color: colorText)),
                                          // ElevatedButton(
                                          //     onPressed: () {
                                          //       Helper.toScreen(AdminPageScreen());
                                          //     },
                                          //     child: Text("admin"))
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                            pageProvider.isBottomLoadingBlockPage
                                ? Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 100,
                                    alignment: Alignment.center,
                                    child: const CupertinoActivityIndicator())
                                : const SizedBox.shrink()
                          ],
                        ),
                      )
                    : const Center(child: CustomText(title: "You haven't any Block Page")));
      },
    );
  }
}
