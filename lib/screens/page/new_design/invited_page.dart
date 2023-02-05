import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/page_provider.dart';
import '../widget/page_app_bar.dart';

class InvitedPage extends StatefulWidget {
  const InvitedPage({Key? key}) : super(key: key);

  @override
  State<InvitedPage> createState() => _InvitedPageState();
}

class _InvitedPageState extends State<InvitedPage> {
  @override
  void initState() {
    Provider.of<PageProvider>(context, listen: false).getAllInvitedPages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PageAppBar(title: 'Invited Pages'),
      body: Consumer<PageProvider>(builder: (context, pageProvider, child) {
        return Padding(
          padding: const EdgeInsets.all(5),
          child: pageProvider.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : pageProvider.invitedPageLists.isEmpty
                  ? const Center(
                      child: Text("Ops You have no invited pages."),
                    )
                  : ListView.builder(
                      itemCount: pageProvider.invitedPageLists.length,
                      itemBuilder: (_, index) {
                        var data = pageProvider.invitedPageLists[index];
                        return ListTile(
                          title: Text(data.page!.name!),
                        );
                      },
                    ),
        );
      }),
    );
  }
}
