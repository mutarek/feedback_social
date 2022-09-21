import 'package:als_frontend/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReportPostScreen extends StatefulWidget {
  const ReportPostScreen({Key? key}) : super(key: key);

  @override
  State<ReportPostScreen> createState() => _ReportPostScreenState();
}

enum ReportReason { violence, spam, falseInformation, nudity, somthingElse }

class _ReportPostScreenState extends State<ReportPostScreen> {
  TextEditingController descriptionController = TextEditingController();
  ReportReason? _result;
  String? reportReason;
  bool showTextField = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Report this post",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
      ),
      body: Consumer<ReportPostProvider>(builder: (context, reportPost, child) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Please select a problem",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Let us know what's wrong with this post to make the community better.",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black38),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: const Text('Violence'),
                leading: Radio(
                  value: ReportReason.violence,
                  groupValue: _result,
                  onChanged: (ReportReason? value) {
                    setState(() {
                      _result = value!;
                      reportReason = "Violance";
                      showTextField = false;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Spam'),
                leading: Radio(
                  value: ReportReason.spam,
                  groupValue: _result,
                  onChanged: (ReportReason? value) {
                    setState(() {
                      _result = value!;
                      reportReason = "Spam";
                      showTextField = false;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('False information'),
                leading: Radio(
                  value: ReportReason.falseInformation,
                  groupValue: _result,
                  onChanged: (ReportReason? value) {
                    setState(() {
                      _result = value!;
                      reportReason = "False information";
                      showTextField = false;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Nudity'),
                leading: Radio(
                  value: ReportReason.nudity,
                  groupValue: _result,
                  onChanged: (ReportReason? value) {
                    setState(() {
                      _result = value!;
                      reportReason = "Nudity";
                      showTextField = false;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Something else'),
                leading: Radio(
                  value: ReportReason.somthingElse,
                  groupValue: _result,
                  onChanged: (ReportReason? value) {
                    setState(() {
                      reportReason = descriptionController.text;
                      _result = value;
                      showTextField = true;
                    });
                  },
                ),
              ),
              (showTextField == true)
                  ? SizedBox(
                      height: 100,
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: null,
                        controller: descriptionController,
                        decoration: const InputDecoration(
                            hintText: "Please write your opinion.",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.teal))),
                      ),
                    )
                  : const SizedBox(),
              ElevatedButton(
                  onPressed: () {
                    print(reportPost.postId);
                    print(reportReason);
                    reportPost.reportPost(reportReason!);
                  },
                  child: const Text("Submit")),
            ],
          ),
        );
      }),
    );
  }
}
