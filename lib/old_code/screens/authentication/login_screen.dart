import 'package:als_frontend/old_code/const/palette.dart';
import 'package:als_frontend/old_code/provider/authentication/show_password_provider.dart';
import 'package:als_frontend/old_code/screens/screens.dart';
import 'package:als_frontend/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../widgets/widgets.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Palette.primary,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(" "),
          elevation: 0,
        ),
        body: SafeArea(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Stack(
              children: [
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
                            "Welcome",
                            style: TextStyle(fontSize: height * 0.035, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(width * 0.07, 00, width * 0.07, height * 0.004),
                          child: LoginTextFiled(
                            h: height * 0.05,
                            w: width * 0.9,
                            child: CustomTextField(
                              hintText: "E-mail",
                              controller: emailController,
                              height: height * 0.06,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(width * 0.07, height * 0.007, width * 0.07, height * 0.0),
                          child: Consumer<ShowPasswordProvider>(builder: (context, value, child) {
                            return LoginTextFiled(
                              h: height * 0.05,
                              w: width * 0.9,
                              child: CustomTextField(
                                hintText: "Password",
                                controller: passwordController,
                                height: height * 0.06,
                                obsecureText: value.obsecureText,
                                suffixIconButton: IconButton(
                                    icon: (value.obsecureText == true) ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                                    onPressed: () => value.showPassword()),
                              ),
                            );
                          }),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: width * 0.5),
                          child: TextButton(
                              onPressed: () {
                                Get.to(const ForgotPassword());
                              },
                              child: const Text(
                                "Forgot password?",
                                style: TextStyle(color: Colors.white, fontSize: 16),
                              )),
                        ),
                        SizedBox(
                          height: height * 0.136,
                        ),
                      ],
                    ),
                  ],
                ),
                Positioned(
                  top: height * 0.71,
                  right: width * 0.62,
                  child: const Text("Login", style: TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold)),
                ),
                Positioned(
                  top: height * 0.7,
                  left: width * 0.6,
                  child: Container(
                    height: height * 0.4,
                    width: width * 0.4,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(width * 4))),
                  ),
                ),
                Positioned(
                  top: height * 0.69,
                  left: width * 0.685,
                  child: Consumer<AuthProvider>(builder: (context, auth, child) {
                    return Padding(
                      padding: EdgeInsets.only(top: height * 0.009, right: width * 0.07),
                      child: CustomConatinerButton(
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
                                print(message);
                              });
                            }
                          }),
                    );
                  }),
                ),
                Positioned(
                  top: height * 0.8,
                  left: width * 0.23,
                  child: Padding(
                    padding: EdgeInsets.only(left: width * 0.073),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(
                        "Don't have an acount?",
                        style: TextStyle(color: Palette.timeColor, fontSize: height * 0.016),
                      ),
                      SizedBox(
                        width: width * 0.01,
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(const EnterEmailOrPhone());
                        },
                        child: Text(
                          "Create account",
                          style: TextStyle(fontSize: height * 0.020),
                        ),
                      )
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ));
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
