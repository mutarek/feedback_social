import 'package:als_frontend/provider/policy%20and%20conditions/privacy_policy_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  void initState() {
    final value = Provider.of<PrivacyPolicyProvider>(context, listen: false);
    value.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Privacy Policy"),
        ),
        body: Consumer<PrivacyPolicyProvider>(
            builder: (context, provider, child) {
          return (provider.privacyPolicy!.isEmpty)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: provider.privacyPolicy!.length,
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                              child: Text(
                            provider.privacyPolicy![index].title,
                            style: GoogleFonts.lato(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          )),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                provider.privacyPolicy![index].description,
                                style: GoogleFonts.lato(
                                    fontWeight: FontWeight.w400)),
                          )
                        ],
                      ),
                    );
                  }));
        }));
  }
}
