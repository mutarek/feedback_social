import 'package:als_frontend/old_code/const/palette.dart';
import 'package:als_frontend/provider/chat_provider.dart';
import 'package:als_frontend/provider/search_provider.dart';
import 'package:als_frontend/screens/chat/components/chat_card.dart';
import 'package:als_frontend/screens/chat/message_screen.dart';
import 'package:als_frontend/screens/search/search_screen.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/widgets/circle_button.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ChatProvider>(context, listen: false).initializeAllChats(context);
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
      body: Consumer<ChatProvider>(
        builder: (context, chatProvider, child) => chatProvider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: chatProvider.allChatsLists.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => ChatCard(
                  chat: chatProvider.allChatsLists[index],
                  press: () => Navigator.push(
                      context, MaterialPageRoute(builder: (context) => MessagesScreen(chatProvider.allChatsLists[index], index))),
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
