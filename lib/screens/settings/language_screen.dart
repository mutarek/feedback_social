import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:als_frontend/util/dimensions.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xffFFFFFF),
        leading: InkWell(
            onTap: () {
              Helper.back();
            },
            child: const Icon(FontAwesomeIcons.angleLeft, size: 20, color: Colors.black)),
        title:
            Text(LocaleKeys.change_Language.tr(), style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.black)),
      ),
      body: ListView.builder(
          itemCount: AppConstant.languagesList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () async {
                await context.setLocale(Locale(AppConstant.languagesList[index].languageCode));
                // Get.updateLocale(Locale(AppConstant.languagesList[index].languageCode));
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
                      CustomText(title: AppConstant.languagesList[index].languageName),
                    ]),
                  ),
                  context.locale.languageCode == AppConstant.languagesList[index].languageCode
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
    );
  }
}
