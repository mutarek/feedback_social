import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

openFeedbackMessengerApp() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = (prefs.getString('token') ?? '');
  String url = 'feedback://chatting.com/$token';

  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

openFeedbackAppOnPlayStore() async {
  String url = 'https://play.google.com/store/apps/details?id=com.als.feedback';

  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

openNewEmail(String mail) async{
  // print("Mail called");
  // Email email = Email(
  //     to: [mail],
  //     subject: 'Seeking For Help',
  //     body: 'Hello I am user of Feedback Social , now i am seeking for help');
  // await EmailLauncher.launch(email);
}
