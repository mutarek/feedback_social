
import 'package:flutter/material.dart';

class FaqSceeen extends StatelessWidget {
  const FaqSceeen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FQA"),
      ),
      body: Column(
        children: const [
          ExpansionTile(
            title: Text("What happens when you Login?"),
            leading: Icon(Icons.login), //add icon
            childrenPadding: EdgeInsets.only(left:60), //children padding
            children: [
              ListTile(
                title: Text("This will authenticate your user and populate a shared instance of an authentication token. The additional information from the authentication call will be used to populate the shared User Profile instance with basic fields."),

              ),


              //more child menu
            ],
          ),
          ExpansionTile(
            title: Text("What happens when you Login?"),
            leading: Icon(Icons.login), //add icon
            childrenPadding: EdgeInsets.only(left:60), //children padding
            children: [
              ListTile(
                title: Text("This will authenticate your user and populate a shared instance of an authentication token. The additional information from the authentication call will be used to populate the shared User Profile instance with basic fields."),

              ),
              //more child menu
            ],
          ),

        ],
      ),
    );
  }
}

