import 'package:als_frontend/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditPostScreen extends StatefulWidget {
  const EditPostScreen({Key? key}) : super(key: key);

  @override
  State<EditPostScreen> createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  TextEditingController descriptionController = TextEditingController();

 void refresh(){
  final data = Provider.of<NewsFeedPostProvider>(context, listen: false);
    data.getData();
 }
  @override
  void initState() {
    final value = Provider.of<CreatePostProvider>(context, listen: false);

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
          Consumer<CreatePostProvider>(builder: (context, provider, child) {
            return ElevatedButton(
              child: const Text("Delete"),
              onPressed: () {
                provider.delete();
                final data =
                    Provider.of<NewsFeedPostProvider>(context, listen: false);
                data.getData();
              },
            );
          })
        ],
        elevation: 0,
      ),
      body: Consumer2<CreatePostProvider, SinglePostProvider>(
          builder: (context, provider, provider2, child) {
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
