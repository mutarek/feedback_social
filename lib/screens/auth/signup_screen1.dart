import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/screens/auth/otp_screen.dart';
import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/palette.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_button.dart';
import 'package:als_frontend/widgets/custom_container_button.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:als_frontend/widgets/custom_text_field.dart';
import 'package:als_frontend/widgets/snackbar_message.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SignUpScreen1 extends StatelessWidget {
  SignUpScreen1({Key? key, required this.isFromForgetPassword}) : super(key: key);
  final TextEditingController emailPhoneController = TextEditingController();
  final bool isFromForgetPassword;
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Builder(builder: (context) {
      return Consumer<AuthProvider>(
          builder: (context, auth, child) => Scaffold(
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
                          decoration:
                              BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(width * 4))),
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
                                  title: isFromForgetPassword ? "Forget Password" : "Registration",
                                  textStyle: latoStyle400Regular.copyWith(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
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
                                                  controller: emailPhoneController,
                                                  verticalSize: 15,
                                                  autoFillHints: AutofillHints.email,
                                                  inputType: TextInputType.emailAddress,
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
                                    : const Center(child: CupertinoActivityIndicator()),
                                ontap: () {
                                  if (!auth.isSelectEmail && emailPhoneController.text.isEmpty) {
                                    showMessage(
                                      message: LocaleKeys.please_fill_all_the_form.tr(),
                                      context: context,
                                    );
                                  } else if (auth.isSelectEmail && phoneController.text.isEmpty) {
                                    showMessage(
                                      message: LocaleKeys.please_fill_all_the_form.tr(),
                                      context: context,
                                    );
                                  } else {
                                    if (isFromForgetPassword) {
                                      auth.resetOtpSend(!auth.isSelectEmail ? emailPhoneController.text : auth.code + phoneController.text,
                                          !auth.isSelectEmail, (bool status, String message) {
                                        if (status) {
                                          Fluttertoast.showToast(msg: message);
                                          Helper.toScreen(OTPScreen(
                                            isFromForgetPassword: isFromForgetPassword,
                                            emailOrNumber: emailPhoneController.text.toString(),
                                          ));


                                        } else {
                                          Fluttertoast.showToast(msg: message, backgroundColor: Colors.red);
                                        }
                                      });
                                    } else {
                                      auth.otpSend(emailPhoneController.text, false, (bool status, String message) {
                                        if (status) {
                                          Fluttertoast.showToast(msg: message);
                                          Helper.toScreen(OTPScreen(
                                            isFromForgetPassword: isFromForgetPassword,
                                            emailOrNumber: emailPhoneController.text.toString(),
                                          ));

                                        } else {
                                          Fluttertoast.showToast(msg: message, backgroundColor: Colors.red);
                                        }
                                      });
                                    }
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
                          child:
                              CustomText(title: LocaleKeys.send_OTP.tr(), textStyle: latoStyle600SemiBold.copyWith(color: Colors.white, fontSize: 16)),
                        ),
                      ),
                    ],
                  ),
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
