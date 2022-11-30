import 'package:als_frontend/provider/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class FaqAllQuestion extends StatelessWidget {
  const FaqAllQuestion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Consumer<SettingsProvider>(builder: (context, provider, child) {
          return ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    provider.updateSingleItem(index);
                  },
                  child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: const Color(0xffF5F7FA)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(child: Text("whats your mind")),
                              provider.oldIndex == index ? Icon(FontAwesomeIcons.arrowDown) : Icon(FontAwesomeIcons.arrowRight)
                            ],
                          ),
                          Text(
                            "sdvklsndvkslvsvknkvwnkvlnkvn         ebwfbwnfwn        wjfwbwjbv      wewe  vjjvjvskncsdncksdckncwcsdc   svsvsjvsjv      jvsvsvk",
                            maxLines: provider.oldIndex == index ? null : 1,
                          )
                        ],
                      )),
                );
              });
        }));
  }
}
