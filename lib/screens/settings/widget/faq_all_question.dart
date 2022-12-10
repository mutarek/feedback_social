import 'package:als_frontend/provider/settings_provider.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class FaqAllQuestion extends StatefulWidget {
  const FaqAllQuestion({Key? key}) : super(key: key);

  @override
  State<FaqAllQuestion> createState() => _FaqAllQuestionState();
}

class _FaqAllQuestionState extends State<FaqAllQuestion> {
  @override
  void initState() {
    Provider.of<SettingsProvider>(context, listen: false).initializeFaqQuestion();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Consumer<SettingsProvider>(builder: (context, provider, child) {
          return ListView.builder(
              itemCount: provider.faqLists.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return provider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : InkWell(
                        onTap: () {
                          provider.updateSingleItem(index);
                        },
                        child: Container(
                            margin: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: const Color(0xffF5F7FA)),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      provider.faqLists[index].question.toString(),
                                      style: latoStyle700Bold.copyWith(color: const Color(0xff293B5D)),
                                    )),
                                    provider.oldIndex == index
                                        ? const Icon(
                                            FontAwesomeIcons.arrowDown,
                                            size: 10,
                                            color: Colors.blue,
                                          )
                                        : Icon(
                                            FontAwesomeIcons.arrowRight,
                                            size: 10,
                                            color: Colors.blueAccent.shade400,
                                          )
                                  ],
                                ),
                                Text(
                                  provider.faqLists[index].answer.toString(),
                                  style: latoStyle500Medium.copyWith(color: const Color(0xff5C6D88)),
                                  maxLines: provider.oldIndex == index ? null : 1,
                                )
                              ],
                            )),
                      );
              });
        }));
  }
}
