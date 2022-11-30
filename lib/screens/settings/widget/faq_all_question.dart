import 'package:als_frontend/provider/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class FaqAllQuestion extends StatelessWidget {
  const FaqAllQuestion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool indexValue = false;
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Consumer<SettingsProvider>(builder: (context, provider, child) {
          return ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return Container(
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8), color: const Color(0xffF5F7FA)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text("whats your mind"),
                            IconButton(
                                onPressed: () {
                                  provider.updateSingleItem(index);
                                },
                                icon: provider.oldIndex ==index && provider.indexValue == true
                                    ? Icon(FontAwesomeIcons.arrowDown)
                                    : Icon(FontAwesomeIcons.arrowRight))
                          ],
                        ),
                        Text(
                          "sdvklsndvkslvsvknkvwnkvlnkvn         ebwfbwnfwn        wjfwbwjbv      wewe  vjjvjvskncsdncksdckncwcsdc   svsvsjvsjv      jvsvsvk",
                          maxLines: provider.oldIndex == index && provider.indexValue == true ? 3 : 1,
                        )
                      ],
                    ));
              });
        }));
  }
}
