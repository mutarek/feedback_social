import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/provider/notication_provider.dart';
import 'package:als_frontend/screens/auth/email_phone_auth.dart';
import 'package:als_frontend/screens/auth/signup_screen1.dart';
import 'package:als_frontend/screens/dashboard/dashboard_screen.dart';
import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/palette.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_button.dart';
import 'package:als_frontend/widgets/custom_container_button.dart';
import 'package:als_frontend/widgets/custom_text_field.dart';
import 'package:als_frontend/widgets/snackbar_message.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    // Provider.of<AuthProvider1>(context, listen: false).signIn('admin@gmail.com', 'r@123456781');
    return Builder(builder: (context) {
      return Consumer<AuthProvider>(
          builder: (context, auth, child) => Scaffold(
              backgroundColor: Palette.primary,
              body: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Stack(
                  children: [
                    Positioned(
                      top: height * 0.75,
                      left: width * 0.6,
                      child: Container(
                        height: height * 0.3,
                        width: width * 0.9,
                        decoration:
                            BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(width * 4))),
                      ),
                    ),
                    Column(
                      children: [
                        ClipPath(
                          clipper: TsClip2(),
                          child: Container(
                            height: height * 0.27,
                            width: width,
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.only(top: height * 0.06, left: width * 0.1),
                              child: Text(
                                LocaleKeys.welcome.tr(),
                                style: latoStyle400Regular.copyWith(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  child: Column(
                                    children: [
                                      SizedBox(height: height * 0.005),

                                      Container(
                                        height: 50,
                                        margin: const EdgeInsets.only(bottom: 15),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                                width: 80,
                                                child: CustomButton(
                                                  btnTxt: LocaleKeys.email.tr(),
                                                  onTap: () {
                                                    auth.changeSelectStatus(false);
                                                  },
                                                  textWhiteColor: !auth.isSelectEmail,
                                                  backgroundColor: !auth.isSelectEmail ? Palette.primary : Colors.white,
                                                )),
                                            const SizedBox(width: 15),
                                            SizedBox(
                                                width: 80,
                                                child: CustomButton(
                                                  btnTxt: LocaleKeys.phone.tr(),
                                                  onTap: () {
                                                    auth.changeSelectStatus(true);
                                                  },
                                                  textWhiteColor: auth.isSelectEmail,
                                                  backgroundColor: auth.isSelectEmail ? Palette.primary : Colors.white,
                                                )),
                                          ],
                                        ),
                                      ),

                                      auth.isSelectEmail
                                          ? Container(
                                              margin: const EdgeInsets.symmetric(horizontal: 15),
                                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(9)),
                                              child: Row(
                                                children: [
                                                  InkWell(
                                                      onTap: () {
                                                        auth.pickupCountry(context);
                                                      },
                                                      child: Padding(
                                                          padding: const EdgeInsets.only(left: 20),
                                                          child: Text(auth.code, style: latoStyle800ExtraBold))),
                                                  const Divider(color: Colors.black),
                                                  Expanded(
                                                      child: TextField(
                                                    controller: phoneController,
                                                    keyboardType: TextInputType.number,
                                                    decoration: const InputDecoration(hintText: "Phone Number"),
                                                  )),
                                                ],
                                              ))
                                          : Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 15),
                                              child: CustomTextField(
                                                fillColor: Colors.white,
                                                hintText: LocaleKeys.enter_Your_Email.tr(),
                                                borderRadius: 9,
                                                controller: emailController,
                                                verticalSize: 15,
                                                autoFillHints: AutofillHints.email,
                                                inputType: TextInputType.emailAddress,
                                                focusNode: emailFocus,
                                                nextFocus: passwordFocus,
                                              ),
                                            ),
                                      SizedBox(height: height * 0.02),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 15),
                                        child: CustomTextField(
                                          fillColor: Colors.white,
                                          hintText: LocaleKeys.password.tr(),
                                          borderRadius: 9,
                                          isPassword: true,
                                          controller: passwordController,
                                          isShowSuffixIcon: true,
                                          focusNode: passwordFocus,
                                          inputAction: TextInputAction.done,
                                        ),
                                      ),
                                      // Padding(
                                      //   padding: EdgeInsets.only(left: width * 0.5),
                                      //   child: TextButton(
                                      //       onPressed: () {
                                      //         Get.to(()=> EnterEmailOrPhone());
                                      //       },
                                      //       child: Text(
                                      //         getTranslated('Forgot password?', context)!,
                                      //         style: latoStyle400Regular.copyWith(color: Colors.white, fontSize: 16),
                                      //       )),
                                      // ),
                                      Padding(
                                        padding: EdgeInsets.only(left: width * 0.5),
                                        child: TextButton(
                                            onPressed: () {
                                              Helper.toScreen(SignUpScreen1(isFromForgetPassword: true));
                                            },
                                            child: Text(
                                              LocaleKeys.forget_Password.tr(),
                                              style: latoStyle400Regular.copyWith(color: Colors.white, fontSize: 16),
                                            )),
                                      ),
                                      SizedBox(height: height * 0.06),
                                      SizedBox(
                                        height: height * 0.05,
                                        width: width * 0.4,
                                        child: CustomConatinerButton(
                                            child: (auth.isLoading == false)
                                                ? Center(
                                                    child: Text(LocaleKeys.login.tr(),
                                                        style: latoStyle800ExtraBold.copyWith(color: Colors.white)))
                                                : const CupertinoActivityIndicator(),
                                            ontap: () {
                                              if (passwordController.text.isEmpty) {
                                                showMessage(message: LocaleKeys.please_fill_all_the_form.tr(), context: context);
                                              } else {
                                                auth
                                                    .signIn(!auth.isSelectEmail ? emailController.text : auth.code + phoneController.text,
                                                        passwordController.text)
                                                    .then((value) {
                                                  if (value.status) {
                                                    Fluttertoast.showToast(msg: value.message);
                                                    Provider.of<NotificationProvider>(context, listen: false).check();
                                                    Navigator.of(context).pushAndRemoveUntil(
                                                        MaterialPageRoute(builder: (_) => const DashboardScreen()), (route) => false);
                                                  } else {
                                                    Fluttertoast.showToast(msg: value.message, backgroundColor: Colors.red);
                                                  }
                                                });
                                              }
                                            }),
                                      ),
                                      const SizedBox(height: 10),
                                      SizedBox(
                                        width: width * 0.6,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                            onPressed: () {
                                              Helper.toScreen(EmailOrPhoneNumber());
                                            },
                                            child: Text(
                                              LocaleKeys.create_account.tr(),
                                              style: latoStyle400Regular.copyWith(fontSize: 15, color: Colors.black),
                                            )),
                                      ),
                                      const SizedBox(height: 20),
                                      SizedBox(height: height * 0.02),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )));
    });
  }
}

class TsClip2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height - 120);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
