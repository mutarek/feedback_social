import 'package:als_frontend/provider/settings_provider.dart';
import 'package:als_frontend/screens/settings/widget/faq_all_question.dart';
import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

class FaqSceeen extends StatefulWidget {
  const FaqSceeen({Key? key}) : super(key: key);

  @override
  State<FaqSceeen> createState() => _FaqSceeenState();
}

class _FaqSceeenState extends State<FaqSceeen> {
  @override
  void initState() {
    _pageController = PageController();
    Provider.of<SettingsProvider>(context, listen: false).initializeOtherSettingsValue();
    super.initState();
  }

  PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Consumer<SettingsProvider>(builder: (context, settingProvider, child) {
          return Column(
            children: [
              Container(
                height: 250,
                decoration: const BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage("assets/background/books.png"), alignment: Alignment.bottomLeft, fit: BoxFit.cover),
                  color: Color(0xffF5EACA),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              height: height * 0.05,
                              width: width * 0.1,
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(color: Colors.black.withOpacity(.09), offset: const Offset(0, 0), blurRadius: 20, spreadRadius: 3)
                              ], borderRadius: BorderRadius.circular(8), color: Colors.white),
                              child: Center(
                                  child: IconButton(
                                      onPressed: () {
                                        Helper.back();
                                      },
                                      icon: const Icon(FontAwesomeIcons.arrowLeft, size: 15)))),
                          Text(
                            LocaleKeys.fAQs.tr(),
                            style: latoStyle700Bold.copyWith(color: const Color(0xff2E4266)),
                          ),
                          const SizedBox(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50, top: 30),
                      child: Row(
                        children: [
                          Text("Questions?\n We've got instant answers", style: latoStyle800ExtraBold),
                          const Padding(padding: EdgeInsets.only(top: 10), child: Icon(Icons.electric_bolt, color: Colors.yellow))
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Container(
                    height: 40,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.black26)),
                    child: TextFormField(
                      onChanged: (value) {
                        settingProvider.initializeSearch(value);
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(FontAwesomeIcons.magnifyingGlass, color: Colors.blue),
                        focusedBorder: InputBorder.none,
                        border: InputBorder.none,
                        hintText: "Search for keywords...",
                        hintStyle: latoStyle500Medium.copyWith(color: Colors.black45),
                        contentPadding: const EdgeInsets.only(bottom: 1, top: 5),
                      ),
                    )),
              ),
              const SizedBox(height: 10),
              const Expanded(flex: 2, child: FaqAllQuestion()),
            ],
          );
        }),
      ),
    );
  }
}
