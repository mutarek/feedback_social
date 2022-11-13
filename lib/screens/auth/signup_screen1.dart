import 'package:als_frontend/helper/number_helper.dart';
import 'package:als_frontend/localization/language_constrants.dart';
import 'package:als_frontend/old_code/const/palette.dart';
import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/screens/auth/otp_screen.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_container_button.dart';
import 'package:als_frontend/widgets/custom_text2.dart';
import 'package:als_frontend/widgets/custom_text_field.dart';
import 'package:als_frontend/widgets/snackbar_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class SignUpScreen1 extends StatelessWidget {
  SignUpScreen1({Key? key, required this.isFromForgetPassword}) : super(key: key);
  final TextEditingController emailPhoneController = TextEditingController();
  final bool isFromForgetPassword;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Builder(builder: (context) {
      return Scaffold(
        backgroundColor: Palette.primary,
        // appBar: AppBar(
        //   elevation: 0,
        //   backgroundColor: Palette.primary,
        //   leading: SizedBox.shrink(),
        //   centerTitle: true,
        //   title:
        //       Text(getTranslated('Registration', context)!, style: latoStyle500Medium.copyWith(color: Colors.white, fontSize: fontSize18)),
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
                          isFromForgetPassword ? "Forget Password" : "Registration",
                          // getTranslated('Registration', context)!,
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
                                SizedBox(height: height * 0.02),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 35),
                                  child: CustomText2(
                                    title: 'Please Enter your email address or phone number',
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    textStyle: latoStyle600SemiBold.copyWith(color: colorPrimaryDark, fontSize: 16),
                                  ),
                                ),
                                const SizedBox(height: 50),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  child: CustomTextField(
                                    fillColor: Colors.white,
                                    hintText: getTranslated('Email/Phone No', context),
                                    borderRadius: 4,
                                    controller: emailPhoneController,
                                    verticalSize: 15,
                                    autoFillHints: AutofillHints.email,
                                    autoFillHints2: AutofillHints.telephoneNumber,
                                    inputType: TextInputType.emailAddress,
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
                  ),
                ],
              ),
              Positioned(
                top: height * 0.65,
                left: width * 0.48,
                child: Container(
                  alignment: Alignment.center,
                  height: height * 0.4,
                  width: width * 0.4,
                  child: Consumer<AuthProvider>(builder: (context, auth, child) {
                    return CustomConatinerButton(
                        child: (auth.isLoading == false)
                            ? const Icon(Icons.arrow_forward, color: Colors.white)
                            : Center(child: const CupertinoActivityIndicator()),
                        ontap: () {
                          if (emailPhoneController.text.isEmpty) {
                            showMessage(
                              message: getTranslated('Please fill all the form', context),
                              context: context,
                            );
                          } else {
                            bool isNumber = isNumeric(emailPhoneController.text);
                            auth.otpSend(emailPhoneController.text, !isNumber, (bool status, String message) {
                              if (status) {
                                Fluttertoast.showToast(msg: message);
                                Get.off(OTPScreen(
                                  isFromForgetPassword: isFromForgetPassword,
                                  emailorNumber: emailPhoneController.text.toString(),
                                ));
                              } else {
                                Fluttertoast.showToast(msg: message, backgroundColor: Colors.red);
                              }
                            });
                          }
                        });
                  }),
                ),
              ),
              Positioned(
                top: height * 0.65,
                left: width * 0.1,
                child: Container(
                  alignment: Alignment.center,
                  height: height * 0.4,
                  width: width * 0.4,
                  child: CustomText2(title: 'Send OTP', textStyle: latoStyle600SemiBold.copyWith(color: Colors.white, fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      );
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
