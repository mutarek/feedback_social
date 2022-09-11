import 'package:als_frontend/provider/provider.dart';
import 'package:als_frontend/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../const/palette.dart';
import '../../widgets/widgets.dart';

class EmailEnterPage extends StatefulWidget {
  const EmailEnterPage({Key? key}) : super(key: key);

  @override
  State<EmailEnterPage> createState() => _EmailEnterPageState();
}

class _EmailEnterPageState extends State<EmailEnterPage> {
  TextEditingController emailController = TextEditingController();

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
                child: Stack(children: [
                  Column(
                    children: [
                      ClipPath(
                        clipper: TsClip2(),
                        child: Container(
                          height: height * 0.2,
                          width: width,
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: height * 0.05, left: width * 0.1),
                            child: Text(
                              "Registration",
                              style: TextStyle(
                                  fontSize: height * 0.035,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.2,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(25.0, 0, 25, 10),
                            child: CustomTextField(
                              label: const Text("E-mail"),
                              controller: emailController,
                              height: height * 0.056,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                    top: height * 0.71,
                    right: width * 0.62,
                    child: const Text("Sign Up",
                        style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                  Positioned(
                    top: height * 0.7,
                    left: width * 0.6,
                    child: Container(
                      height: height * 0.4,
                      width: width * 0.4,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(width * 4))),
                    ),
                  ),
                  Positioned(
                    top: height * 0.69,
                    left: width * 0.685,
                    child: Consumer2<EmailVerifyProvider, RegistrationProvider>(
                        builder:
                            (context, provider, registrationProvider, child) {
                      return Padding(
                        padding: EdgeInsets.only(right: width * 0.07),
                        child: CustomConatinerButton(
                            child: const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                            ontap: () {
                              provider.email = emailController.text;
                              provider.getCode(emailController.text);
                              if (provider.success2 == true) {
                                registrationProvider.email =
                                    emailController.text;
                                Get.to(() => const EmailVerify());
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Email is already registered");
                              }
                            }),
                      );
                    }),
                  ),
                  Positioned(
                    top: height * 0.8,
                    left: width * 0.37,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an acount?",
                            style: TextStyle(
                                color: Palette.timeColor,
                                fontSize: height * 0.016),
                          ),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          TextButton(
                            onPressed: () {
                              Get.to(const LoginScreen());
                            },
                            child: Text(
                              "SIGN IN",
                              style: TextStyle(fontSize: height * 0.020),
                            ),
                          )
                        ]),
                  ),
                ]))));
  }
}
