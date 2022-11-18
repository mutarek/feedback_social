import 'package:als_frontend/localization/language_constrants.dart';
import 'package:als_frontend/provider/dashboard_provider.dart';
import 'package:als_frontend/provider/language_provider.dart';
import 'package:als_frontend/provider/localization_provider.dart';
import 'package:als_frontend/screens/splash/splash_screen.dart';
import 'package:als_frontend/util/dimensions.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xffFFFFFF),
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(FontAwesomeIcons.angleLeft, size: 20, color: Colors.black)),
        title: Text(getTranslated('Change Language', context),
            style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.black)),
      ),
      body: Consumer2<LanguageProvider, LocalizationProvider>(
        builder: (context, languageProvider, localizationProvider, child) => Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: languageProvider.languages.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        localizationProvider.setLanguage(
                            Locale(languageProvider.languages[index].languageCode, languageProvider.languages[index].countryCode), index);
                        Provider.of<DashboardProvider>(context, listen: false).changeSelectIndex(0);
                        Helper.toRemoveUntilScreen(context, const SplashScreen());
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        margin: const EdgeInsets.all(paddingSize5),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(paddingSize5),
                          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(.2), blurRadius: 5, spreadRadius: 1)],
                        ),
                        child: Stack(clipBehavior: Clip.none, children: [
                          Center(
                            child: Column(mainAxisSize: MainAxisSize.min, children: [
                              CustomText(title: languageProvider.languages[index].languageName),
                            ]),
                          ),
                          localizationProvider.locale.countryCode == languageProvider.languages[index].countryCode
                              ? Positioned(
                                  top: -5,
                                  right: 10,
                                  child: Icon(Icons.check_circle, color: Theme.of(context).primaryColor, size: 25),
                                )
                              : const SizedBox(),
                        ]),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
