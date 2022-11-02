import 'package:als_frontend/old_code/provider/provider.dart';
import 'package:als_frontend/provider/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  const TermsAndConditionsScreen({Key? key}) : super(key: key);

  @override
  State<TermsAndConditionsScreen> createState() =>
      _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  @override
  void initState() {
    final value =
    Provider.of<SettingsProvider>(context, listen: false).initializeTermsAndCondition();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Terms and Conditions"),
        ),
        body: Consumer<SettingsProvider>(
            builder: (context, provider, child) {
              return provider.isLoading== true? CircularProgressIndicator():ListView.builder(
                  itemCount: provider.privacyPolicyModel.length,
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                              child: Text(
                                provider.privacyPolicyModel[index].title.toString(),
                                style: GoogleFonts.lato(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              )),
                          Text(
                            provider.privacyPolicyModel[index].description.toString(),
                            style:
                            GoogleFonts.lato(fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    );
                  }));
            }));
  }
}
