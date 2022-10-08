import 'package:als_frontend/localization/language_constrants.dart';
import 'package:als_frontend/old_code/const/palette.dart';
import 'package:als_frontend/old_code/screens/screens.dart';
import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/screens/auth/signup_screen1.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_container_button.dart';
import 'package:als_frontend/widgets/custom_text_field.dart';
import 'package:als_frontend/widgets/snackbar_message.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  FocusNode emailFocus=FocusNode();
  FocusNode passwordFocus=FocusNode();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Builder(builder: (context) {
      return Scaffold(
          backgroundColor: Palette.primary,
          // backgroundColor: Palette.primary,
          // appBar: AppBar(
          //   backgroundColor: Colors.white,
          //   title: const Text(" "),
          //   elevation: 0,
          // ),
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
                          child: Text(
                            getTranslated('Welcome', context)!,
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
                              physics: BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  SizedBox(height: height * 0.02),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15),
                                    child: CustomTextField(
                                      fillColor: Colors.white,
                                      hintText: getTranslated('E-mail', context),
                                      borderRadius: 4,
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
                                      hintText: getTranslated('Password', context),
                                      borderRadius: 4,
                                      isPassword: true,
                                      controller: passwordController,
                                      isShowSuffixIcon: true,
                                      focusNode: passwordFocus,
                                      inputAction: TextInputAction.done,
                                    ),
                                  ),

                                  // Padding(
                                  //   padding: EdgeInsets.fromLTRB(width * 0.07, 00, width * 0.07, height * 0.004),
                                  //   child: LoginTextFiled(
                                  //     h: height * 0.05,
                                  //     w: width * 0.9,
                                  //     child: CustomTextField(
                                  //       hintText: getTranslated('E-mail', context),
                                  //       controller: emailController,
                                  //       height: height * 0.06,
                                  //     ),
                                  //   ),
                                  // ),
                                  // Padding(
                                  //   padding: EdgeInsets.fromLTRB(width * 0.07, height * 0.007, width * 0.07, height * 0.0),
                                  //   child: Consumer<ShowPasswordProvider>(builder: (context, value, child) {
                                  //     return LoginTextFiled(
                                  //       h: height * 0.05,
                                  //       w: width * 0.9,
                                  //       child: CustomTextField(
                                  //         hintText: getTranslated('Password', context),
                                  //         controller: passwordController,
                                  //         height: height * 0.06,
                                  //         obsecureText: value.obsecureText,
                                  //         suffixIconButton: IconButton(
                                  //             icon: (value.obsecureText == true) ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                                  //             onPressed: () => value.showPassword()),
                                  //       ),
                                  //     );
                                  //   }),
                                  // ),
                                  Padding(
                                    padding: EdgeInsets.only(left: width * 0.5),
                                    child: TextButton(
                                        onPressed: () {
                                          Get.to(const ForgotPassword());
                                        },
                                        child: Text(
                                          getTranslated('Forgot password?', context)!,
                                          style: latoStyle400Regular.copyWith(color: Colors.white, fontSize: 16),
                                        )),
                                  ),
                                  SizedBox(height: 20),


                                  SizedBox(height: height * 0.02),
                                ],
                              ),
                            ),
                          ),

                          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            Text(
                              getTranslated('Don\'t have an account?', context)!,
                              style: latoStyle400Regular.copyWith(color: Colors.white, fontSize: 15),
                            ),
                            SizedBox(width: width * 0.01),
                            TextButton(
                              onPressed: () {
                                Get.to( SignUpScreen1());
                                // Get.to(const EnterEmailOrPhone());
                              },
                              child: Text(
                                getTranslated('Create account', context)!,
                                style: latoStyle400Regular.copyWith(fontSize: 15,color: Colors.blue),
                              ),
                            )
                          ]),
                        ],
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
                              : const CircularProgressIndicator(),
                          ontap: () {
                            if (emailController.text.isEmpty || passwordController.text.isEmpty) {
                              showMessage(
                                message: "Please fill all ther form",
                                context: context,
                              );
                            } else {
                              auth.signIn(emailController.text, passwordController.text, false, (bool status, String message) {
                                if (status) {
                                  Fluttertoast.showToast(msg: message);
                                  Get.off(const NavScreen());
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
          ));
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
