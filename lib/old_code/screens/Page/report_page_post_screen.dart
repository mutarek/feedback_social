import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ReportPagePostScreen extends StatefulWidget {
  const ReportPagePostScreen({Key? key}) : super(key: key);

  @override
  State<ReportPagePostScreen> createState() => _ReportPagePostScreenState();
}

enum PagePostReportReason {
  violence,
  spam,
  falseInformation,
  nudity,
  somthingElse
}

class _ReportPagePostScreenState extends State<ReportPagePostScreen> {
  PagePostReportReason? _result;
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Please select a problem",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                value: PagePostReportReason.violence,
                groupValue: _result,
                onChanged: (PagePostReportReason? value) {
                  setState(() {
                    _result = value!;
                    showTextField = false;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Spam'),
              leading: Radio(
                value: PagePostReportReason.spam,
                groupValue: _result,
                onChanged: (PagePostReportReason? value) {
                  setState(() {
                    _result = value!;
                    showTextField = false;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('False information'),
              leading: Radio(
                value: PagePostReportReason.falseInformation,
                groupValue: _result,
                onChanged: (PagePostReportReason? value) {
                  setState(() {
                    _result = value!;
                    showTextField = false;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Nudity'),
              leading: Radio(
                value: PagePostReportReason.nudity,
                groupValue: _result,
                onChanged: (PagePostReportReason? value) {
                  setState(() {
                    _result = value!;
                    showTextField = false;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Something else'),
              leading: Radio(
                value: PagePostReportReason.somthingElse,
                groupValue: _result,
                onChanged: (PagePostReportReason? value) {
                  setState(() {
                    _result = value!;
                    showTextField = true;
                  });
                },
              ),
            ),
            (showTextField == true)
                ? const SizedBox(
                    height: 100,
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: null,
                      decoration: InputDecoration(
                          hintText: "Please write your opinion.",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal))),
                    ),
                  )
                : const SizedBox(),
            ElevatedButton(
                onPressed: () {
                  Fluttertoast.showToast(
                      msg: "Thanks for helping the community better.");
                  Get.back();
                },
                child: const Text("Submit")),
          ],
        ),
      ),
    );
  }
}
