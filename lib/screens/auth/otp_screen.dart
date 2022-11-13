import 'package:als_frontend/localization/language_constrants.dart';
import 'package:als_frontend/old_code/const/palette.dart';
import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/screens/auth/forgot_password_screen.dart';
import 'package:als_frontend/screens/auth/login_screen.dart';
import 'package:als_frontend/screens/auth/signup_screen2.dart';
import 'package:als_frontend/screens/auth/widget/rounded_with_cursor.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_button.dart';
import 'package:als_frontend/widgets/custom_container_button.dart';
import 'package:als_frontend/widgets/custom_text2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class OTPScreen extends StatelessWidget {
  OTPScreen({Key? key,
required this.isFromForgetPassword,
required this.emailorNumber,
  }) : super(key: key);
bool isFromForgetPassword;
String emailorNumber;

  final TextEditingController pinController = TextEditingController();


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
                          child: CustomText2(
                            title: 'OTP Verified',
                            textStyle: latoStyle400Regular.copyWith(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(height: height * 0.02),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 35),
                          child: CustomText2(
                            title: 'Please Enter your 4 digit Valid OTP Number',
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            textStyle: latoStyle600SemiBold.copyWith(color: colorPrimaryDark, fontSize: 16),
                          ),
                        ),
                        const SizedBox(height: 50),
                        Container(height: 100, child: RoundedWithCustomCursor(pinController, authProvider)),
                        SizedBox(height: height * 0.02),
                      ],
                    ),
                  ],
                ),
                Positioned(
                  top: height * 0.65,
                  left: width * 0.48,
                  child: pinController.text.length >= 4
                      ? Container(
                          alignment: Alignment.center,
                          height: height * 0.4,
                          width: width * 0.4,
                          child: Consumer<AuthProvider>(builder: (context, auth, child) {
                            return CustomConatinerButton(
                                child: (auth.isLoading == false)
                                    ? const Icon(Icons.arrow_forward, color: Colors.white)
                                    : const CircularProgressIndicator(),
                                ontap: () {
                                  auth.otpVerify(pinController.text, (bool status, String message) {
                                    if (status) {
                                      Fluttertoast.showToast(msg: message);
                                      if(isFromForgetPassword)
                                        {
                                          Get.off(ForgotPasswordScreen(isFromForgetPassword: true, emailorPhonenumber: emailorNumber, otpcode:pinController.text ,));
                                        }else
                                      Get.off(SignupScreen2());
                                    } else {
                                      Fluttertoast.showToast(msg: message, backgroundColor: Colors.red);
                                    }
                                  });
                                });
                          }),
                        )
                      : const SizedBox(),
                ),
                Positioned(
                  top: height * 0.65,
                  left: width * 0.1,
                  child: Container(
                    alignment: Alignment.center,
                    height: height * 0.4,
                    width: width * 0.4,
                    child: Center(
                      child: authProvider.isLoading == true
                          ? const SizedBox()
                          : (authProvider.minutes == 0 && authProvider.seconds == 0)
                              ? CustomButton(
                                  onTap: () {
                                    authProvider.resetTime();
                                  },
                                  btnTxt: getTranslated('Resend', context),
                                  backgroundColor: Colors.transparent,
                                  textWhiteColor: true,
                                  radius: 10)
                              : Text(
                                  "00 : 0${authProvider.minutes} : ${(authProvider.seconds > 9) ? authProvider.seconds : "0${authProvider.seconds}"}",
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
                                ),
                    ),
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
