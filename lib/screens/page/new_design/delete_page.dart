import 'package:als_frontend/provider/page_provider.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_button.dart';
import 'package:als_frontend/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widget/page_app_bar.dart';

class DeletePage extends StatefulWidget {
  const DeletePage(this.pageId, this.index,{Key? key}) : super(key: key);
  final String pageId;
  final int index;

  @override
  State<DeletePage> createState() => _DeletePageState();
}

class _DeletePageState extends State<DeletePage> {
  final keyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PageAppBar(title: 'Delete Page'),
      body: Consumer<PageProvider>(builder: (context, pageProvider, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 300,
                width: double.infinity,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text("Are you absolutely sure?", style: robotoStyle500Medium.copyWith(fontSize: 12)),
                          const Icon(Icons.auto_delete, color: Colors.red)
                        ]),
                        const Divider(thickness: 2, color: Colors.black),
                        Text(
                            "This action cannot be undone. This will permanently delete the mutarek/sasasas repository, wiki, issues, comments, packages, secrets, workflow runs, and remove all collaborator associations.",
                            style: robotoStyle400Regular.copyWith(fontSize: 16)),
                        const SizedBox(height: 10),
                        Text.rich(TextSpan(children: [
                          TextSpan(text: "Please Type", style: robotoStyle300Light.copyWith(fontSize: 12)),
                          TextSpan(text: " MyPage ", style: robotoStyle700Bold.copyWith(fontSize: 15)),
                          TextSpan(text: "To Confrim", style: robotoStyle300Light.copyWith(fontSize: 12)),
                        ])),
                        const SizedBox(height: 5),
                        CustomTextField(
                          hintText: 'Your Key Name',
                          isShowBorder: true,
                          borderRadius: 11,
                          verticalSize: 14,
                          controller: keyController,
                        ),
                        const SizedBox(height: 5),
                        CustomButton(
                            btnTxt: 'Delete Page',
                            onTap: () {

                            },
                            radius: 100,
                            height: 48)
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}
