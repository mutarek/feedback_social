import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/provider/notication_provider.dart';
import 'package:als_frontend/screens/auth/login_screen.dart';
import 'package:als_frontend/screens/dashboard/dashboard_screen.dart';
import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/palette.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_container_button.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:als_frontend/widgets/custom_text_field.dart';
import 'package:als_frontend/widgets/snackbar_message.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SignupScreen2 extends StatelessWidget {
  SignupScreen2({Key? key}) : super(key: key);

  final TextEditingController numberController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var selectedDate;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Builder(builder: (context) {
      return Scaffold(
        backgroundColor: Palette.primary,
        body: Consumer<AuthProvider>(
          builder: (context, authProvider, child) => GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Stack(
              children: [
                Positioned(
                  top: height * 0.75,
                  left: width * 0.6,
                  child: Container(
                    height: height * 0.4,
                    width: width * 0.4,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(width * 4))),
                  ),
                ),
                Column(
                  children: [
                    ClipPath(
                      clipper: TsClip2(),
                      child: Container(
                        height: height * 0.25,
                        width: width,
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.only(top: height * 0.06, left: width * 0.1),
                          child: CustomText(
                            title: LocaleKeys.user_Information.tr(),
                            textStyle: latoStyle400Regular.copyWith(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: height * 0.02),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: CustomTextField(
                                      fillColor: Colors.white,
                                      hintText: LocaleKeys.first_Name.tr(),
                                      borderRadius: 4,
                                      controller: firstNameController,
                                      verticalSize: 15,
                                      autoFillHints: AutofillHints.name,
                                      inputType: TextInputType.name,
                                      // focusNode: emailFocus,
                                      // nextFocus: passwordFocus,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: CustomTextField(
                                      fillColor: Colors.white,
                                      hintText: LocaleKeys.last_Name.tr(),
                                      borderRadius: 4,
                                      controller: lastNameController,
                                      verticalSize: 15,
                                      autoFillHints: AutofillHints.name,
                                      inputType: TextInputType.name,
                                      // focusNode: emailFocus,
                                      // nextFocus: passwordFocus,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(28.0, 5, 25, 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const CustomText(title: "Date of birth", color: Colors.white, fontSize: 20),
                                  Container(
                                      height: height * 0.045,
                                      width: width * 0.4,
                                      decoration: BoxDecoration(color: const Color(0xFF656B87), borderRadius: BorderRadius.circular(15.0)),
                                      child: ElevatedButton(
                                          onPressed: () {
                                            authProvider.showDateDialog(context);
                                          },
                                          child: Text(authProvider.dateTimeForUser))

                                      // MaterialButton(
                                      //   child:
                                      //
                                      //
                                      //   CustomText(
                                      //       title: authProvider.buttonText, textStyle: latoStyle500Medium.copyWith(color: Colors.white)),
                                      //   onPressed: () {
                                      //     authProvider.showDateDialog(context);
                                      //   },
                                      // ),
                                      )
                                ],
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(28.0, 5, 25, 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const CustomText(title: "Gender", color: Colors.white, fontSize: 20),
                                  Container(
                                    height: height * 0.045,
                                    width: width * 0.4,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF656B87),
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Center(
                                      child: DropdownButton<String>(
                                        dropdownColor: const Color(0xFF656B87),
                                        value: authProvider.selectGender,
                                        items: authProvider.genderLists
                                            .map((item) => DropdownMenuItem<String>(
                                                value: item, child: Text(item, style: const TextStyle(color: Colors.white, fontSize: 16))))
                                            .toList(),
                                        onChanged: (item) {
                                          authProvider.changeGenderStatus(item!);
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: CustomTextField(
                                fillColor: Colors.white,
                                hintText: LocaleKeys.password.tr(),
                                borderRadius: 4,
                                isPassword: true,
                                controller: passwordController,
                                isShowSuffixIcon: true,
                                inputAction: TextInputAction.done,
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: height * 0.65,
                  left: width * 0.47,
                  child: Container(
                    alignment: Alignment.center,
                    height: height * 0.4,
                    width: width * 0.4,
                    child: Consumer<AuthProvider>(builder: (context, auth, child) {
                      return CustomConatinerButton(
                          child: (auth.isLoading == false)
                              ? const Icon(Icons.arrow_forward, color: Colors.white)
                              : const Center(child: CircularProgressIndicator()),
                          ontap: () {
                            if (firstNameController.text.isEmpty || passwordController.text.isEmpty) {
                              showMessage(message: LocaleKeys.please_fill_all_the_form.tr(), context: context);
                            } else {
                              auth.signup(firstNameController.text, lastNameController.text, passwordController.text,
                                  (bool status, String message) {
                                if (status) {
                                  Fluttertoast.showToast(msg: message);
                                  Provider.of<NotificationProvider>(context, listen: false).check();
                                  Helper.toScreen(const DashboardScreen());
                                } else {
                                  Fluttertoast.showToast(msg: message, backgroundColor: Colors.red);
                                }
                              });
                            }
                          });
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
