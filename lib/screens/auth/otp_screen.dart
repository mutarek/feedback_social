import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/screens/auth/set_new_password.dart';
import 'package:als_frontend/screens/auth/signup_screen2.dart';
import 'package:als_frontend/screens/auth/widget/rounded_with_cursor.dart';
import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/palette.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_button.dart';
import 'package:als_frontend/widgets/custom_container_button.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class OTPScreen extends StatelessWidget {
  OTPScreen({Key? key, required this.isFromForgetPassword, required this.emailOrNumber}) : super(key: key);
  final bool isFromForgetPassword;
  final String emailOrNumber;

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
                          child: CustomText(
                            title: LocaleKeys.oTP_Verified.tr(),
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
                          child: CustomText(
                            title: LocaleKeys.please_Enter_your_4_digit_Valid_OTP_Number.tr(),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            textStyle: latoStyle600SemiBold.copyWith(color: colorPrimaryDark, fontSize: 16),
                          ),
                        ),
                        const SizedBox(height: 50),
                        SizedBox(height: 100, child: RoundedWithCustomCursor(pinController, authProvider)),
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
                                    : const Center(child: CircularProgressIndicator()),
                                ontap: () {
                                  if (isFromForgetPassword) {
                                    auth.otpVerify(pinController.text, (bool status, String message) {
                                      if (status) {
                                        Fluttertoast.showToast(msg: message);
                                        Helper.toScreen(SetNewPassword(emailOrNumber: emailOrNumber, otpCode: pinController.text));
                                      } else {
                                        Fluttertoast.showToast(msg: message, backgroundColor: Colors.red);
                                      }
                                    });
                                  } else {
                                    auth.otpVerify(pinController.text, (bool status, String message) {
                                      if (status) {
                                        Fluttertoast.showToast(msg: message);
                                        Helper.toScreen(SignupScreen2());
                                      } else {
                                        Fluttertoast.showToast(msg: message, backgroundColor: Colors.red);
                                      }
                                    });
                                  }
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
                                  btnTxt: LocaleKeys.resend.tr(),
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
