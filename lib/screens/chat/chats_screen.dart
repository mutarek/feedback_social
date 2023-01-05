import 'package:als_frontend/data/model/response/chat/all_message_chat_list_model.dart';
import 'package:als_frontend/provider/chat_provider.dart';
import 'package:als_frontend/screens/chat/components/chat_card.dart';
import 'package:als_frontend/screens/chat/message_screen.dart';
import 'package:als_frontend/screens/profile/shimmer_effect/friend_req_shimmer_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  Future<void> _refresh(BuildContext context) async {
    Provider.of<ChatProvider>(context, listen: false).initializeAllChats(isFirstTime: false);
  }

  ScrollController controller = ScrollController();
  bool hasConnection = false;

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
      body: RefreshIndicator(
        onRefresh: () {
          return _refresh(context);
        },
        child: Consumer<ChatProvider>(
          builder: (context, chatProvider, child) => chatProvider.isLoading
              ? const Center(child: FriendReqShimmerWidget())
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
                              chatProvider.initializeSocket(index);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MessagesScreen(
                                            index: index,
                                            isForGroup: allMessageChatListModel.roomType == "G" ? true : false,
                                            customerID: allMessageChatListModel.users![0].id as int,
                                            imageURL: allMessageChatListModel.users![0].profileImage!,
                                            name: allMessageChatListModel.users![0].fullName!,
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
