import 'package:als_frontend/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class EditGroupPostScreen extends StatefulWidget {
  const EditGroupPostScreen({Key? key}) : super(key: key);

  @override
  State<EditGroupPostScreen> createState() => _EditGroupPostScreenState();
}

class _EditGroupPostScreenState extends State<EditGroupPostScreen> {
  TextEditingController descriptionController = TextEditingController();

  void refresh() {
    final data = Provider.of<GroupPostProvider>(context, listen: false);
    data.getData();
  }

  @override
  void initState() {
    final value = Provider.of<CreateGroupPost>(context, listen: false);

    setState(() {
      descriptionController.text = value.description;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Edit this post",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Consumer<CreateGroupPost>(builder: (context, provider, child) {
            return ElevatedButton(
              child: const Text("Delete"),
              onPressed: () {
                provider.delete();
                final data =
                    Provider.of<PagePostProvider>(context, listen: false);
                data.getData();
                Get.back();
              },
            );
          })
        ],
        elevation: 0,
      ),
      body: Consumer<CreateGroupPost>(builder: (context, provider, child) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: SizedBox(
                    height: 100,
                    width: 380,
                    child: TextField(
                      controller: descriptionController,
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: null,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  const BorderSide(color: Colors.teal))),
                    ),
                  ),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    provider.editPost(descriptionController.text);
                    refresh();
                    Get.back();
                  },
                  child: const Text("Submit"),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
