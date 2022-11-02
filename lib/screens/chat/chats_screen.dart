import 'package:als_frontend/data/model/response/chat/AllMessageChatListModel.dart';
import 'package:als_frontend/old_code/const/palette.dart';
import 'package:als_frontend/provider/chat_provider.dart';
import 'package:als_frontend/provider/search_provider.dart';
import 'package:als_frontend/screens/chat/components/chat_card.dart';
import 'package:als_frontend/screens/chat/message_screen.dart';
import 'package:als_frontend/screens/search/search_screen.dart';
import 'package:als_frontend/widgets/circle_button.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  Future<void> _refresh(BuildContext context) async {
    Provider.of<ChatProvider>(context, listen: false).initializeAllChats(isFirstTime: false);
  }

  ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ChatProvider>(context, listen: false).initializeAllChats();

    controller.addListener(() {
      if (controller.offset >= controller.position.maxScrollExtent &&
          !controller.position.outOfRange &&
          Provider.of<ChatProvider>(context, listen: false).hasNextData) {
        Provider.of<ChatProvider>(context, listen: false).updatePageNoAllChats();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: CustomText(title: 'Chat ', color: Palette.primary, fontWeight: FontWeight.bold, fontSize: 27),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          CircleButton(
            radius: 35.0,
            icon: Icons.search,
            iconSize: 20.0,
            onPressed: () {
              Provider.of<SearchProvider>(context, listen: false).resetFirstTime();
              Get.to(SearchScreen());
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return _refresh(context);
        },
        child: Consumer<ChatProvider>(
          builder: (context, chatProvider, child) => chatProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  controller: controller,
                  child: Column(
                    children: [
                      ListView.builder(
                        itemCount: chatProvider.allChatsLists.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => ChatCard(
                            chat: chatProvider.allChatsLists[index],
                            press: () {
                              AllMessageChatListModel allMessageChatListModel = chatProvider.allChatsLists[index];
                              chatProvider.changeChantModel(allMessageChatListModel);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MessagesScreen(
                                            index: index,
                                            imageURL: allMessageChatListModel.roomType == "G"
                                                ? allMessageChatListModel.chatGroup!.avatar!
                                                : allMessageChatListModel.users![0].profileImage!,
                                            name: allMessageChatListModel.roomType == "G"
                                                ? allMessageChatListModel.chatGroup!.name!
                                                : allMessageChatListModel.users![0].fullName!,
                                          )));
                            }),
                      ),
                      chatProvider.isBottomLoading
                          ? Container(
                              width: MediaQuery.of(context).size.width,
                              height: 100,
                              alignment: Alignment.center,
                              child: const CupertinoActivityIndicator())
                          : const SizedBox.shrink()
                    ],
                  ),
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue,
        child: const Icon(Icons.person_add_alt_1, color: Colors.white),
      ),
    );
  }
}
