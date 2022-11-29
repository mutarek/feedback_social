import 'package:als_frontend/localization/language_constrants.dart';
import 'package:als_frontend/provider/settings_provider.dart';
import 'package:als_frontend/screens/settings/widget/faq_all_question.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<SettingsProvider>(builder: (context, settingProvider, child) {
          return Column(
            children: [
              Container(
                height: 250,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/background/books.png"),
                      alignment: Alignment.bottomLeft,
                      fit: BoxFit.cover),
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
                                BoxShadow(
                                    color: Colors.black.withOpacity(.09),
                                    offset: const Offset(0, 0),
                                    blurRadius: 20,
                                    spreadRadius: 3)
                              ], borderRadius: BorderRadius.circular(8), color: Colors.white),
                              child: Center(
                                  child: IconButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      icon: const Icon(
                                        FontAwesomeIcons.arrowLeft,
                                        size: 15,
                                      )))),
                          Text(
                            getTranslated("FAQ?", context),
                            style: latoStyle700Bold.copyWith(color: const Color(0xff2E4266)),
                          ),
                          Container(
                              height: height * 0.05,
                              width: width * 0.1,
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(.09),
                                    offset: const Offset(0, 0),
                                    blurRadius: 20,
                                    spreadRadius: 3)
                              ], borderRadius: BorderRadius.circular(8), color: Colors.white),
                              child: Center(
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        FontAwesomeIcons.barsStaggered,
                                        size: 15,
                                      )))),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50, top: 30),
                      child: Row(
                        children: [
                          Text(
                            "Questions?\n We've got instant answers",
                            style: latoStyle800ExtraBold,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Icon(
                              Icons.electric_bolt,
                              color: Colors.yellow,
                            ),
                          )
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
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black26)),
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          FontAwesomeIcons.magnifyingGlass,
                          color: Colors.blue,
                        ),
                        focusedBorder: InputBorder.none,
                        border: InputBorder.none,
                        hintText: "Search for keywords...",
                        hintStyle: latoStyle500Medium.copyWith(color: Colors.black45),
                        contentPadding: const EdgeInsets.only(bottom: 1, top: 5),
                      ),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    //TODO: all question list
                    InkWell(
                      onTap: () {
                        _pageController.animateToPage(0,
                            duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
                        settingProvider.changeMenuValue(0);
                      },
                      child: Container(
                        height: 30,
                        width: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: settingProvider.menuValue == 0 ? Colors.blue : Colors.grey,
                                width: 1)),
                        child: Center(
                            child: Text(
                          "All",
                          style: latoStyle400Regular.copyWith(
                              color: settingProvider.menuValue == 0 ? Colors.blue : Colors.black45),
                        )),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    //TODO: SING UP QUESTION
                    InkWell(
                      onTap: () {
                        _pageController.animateToPage(0,
                            duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
                        settingProvider.changeMenuValue(1);
                      },
                      child: Container(
                        height: 30,
                        width: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: settingProvider.menuValue == 1 ? Colors.blue : Colors.grey,
                                width: 1)),
                        child: Center(
                            child: Text(
                          "Sign up",
                          style: latoStyle400Regular.copyWith(
                              color: settingProvider.menuValue == 1 ? Colors.blue : Colors.black45),
                        )),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    //TODO: log in QUESTION
                    InkWell(
                      onTap: () {
                        _pageController.animateToPage(0,
                            duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
                        settingProvider.changeMenuValue(2);
                      },
                      child: Container(
                        height: 30,
                        width: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: settingProvider.menuValue == 2 ? Colors.blue : Colors.grey,
                                width: 1)),
                        child: Center(
                            child: Text(
                          "Sign in",
                          style: latoStyle400Regular.copyWith(
                              color: settingProvider.menuValue == 2 ? Colors.blue : Colors.black45),
                        )),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    //TODO: page  QUESTION
                    InkWell(
                      onTap: () {
                        _pageController.animateToPage(0,
                            duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
                        settingProvider.changeMenuValue(3);
                      },
                      child: Container(
                        height: 30,
                        width: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: settingProvider.menuValue == 3 ? Colors.blue : Colors.grey,
                                width: 1)),
                        child: Center(
                            child: Text(
                          "Page",
                          style: latoStyle400Regular.copyWith(
                              color: settingProvider.menuValue == 3 ? Colors.blue : Colors.black45),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: PageView(
                  controller: _pageController,
                  physics: const ClampingScrollPhysics(),
                  onPageChanged: (int i) {
                    FocusScope.of(context).requestFocus(FocusNode());

                    settingProvider.changeMenuValue(i);
                  },
                  children: <Widget>[
                    FaqAllQuestion()
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
