import 'package:als_frontend/old_code/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class EditPagePostScreen extends StatefulWidget {
  const EditPagePostScreen({Key? key}) : super(key: key);

  @override
  State<EditPagePostScreen> createState() => _EditPagePostScreenState();
}

class _EditPagePostScreenState extends State<EditPagePostScreen> {
  TextEditingController descriptionController = TextEditingController();

  void refresh() {
    final data = Provider.of<PagePostProvider>(context, listen: false);
    data.getData();
  }

  @override
  void initState() {
    final value = Provider.of<CreatePagePost>(context, listen: false);

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
          Consumer<CreatePagePost>(builder: (context, provider, child) {
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
      body: Consumer<CreatePagePost>(builder: (context, provider, child) {
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
