import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FaqAllQuestion extends StatelessWidget {
  const FaqAllQuestion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10),
      child: ListView.builder(
        itemCount: 3,
          itemBuilder: (context,index){
          return Container(margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
                color: Color(0xffF5F7FA)
            ),
            child: ExpansionTile(title: Text("How can I LogIn my account"),
              collapsedIconColor: Colors.blueAccent,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("fubwfubfuwfuwbfuewfjduewfjewjdn efbuwibfwebf ibbuefbw "),
                ),
              ],
            ),
          );
          })
    );
  }
}
