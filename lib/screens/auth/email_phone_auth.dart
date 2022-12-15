import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/screens/auth/otp_screen.dart';
import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/palette.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_container_button.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:als_frontend/widgets/custom_text_field.dart';
import 'package:als_frontend/widgets/snackbar_message.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class EmailOrPhoneNumber extends StatelessWidget {
  EmailOrPhoneNumber({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
                          title: LocaleKeys.register.tr(),
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
                                TabBar(
                                    indicator: const UnderlineTabIndicator(
                                        borderSide: BorderSide(width: 1.0, color: Colors.white),
                                        insets: EdgeInsets.symmetric(horizontal: 16.0)),
                                    tabs: [
                                      Text(
                                        LocaleKeys.phone.tr(),
                                        style: latoStyle500Medium.copyWith(color: Colors.white),
                                      ),
                                      Text(
                                        LocaleKeys.email.tr(),
                                        style: latoStyle500Medium.copyWith(color: Colors.white),
                                      ),
                                    ]),
                                const SizedBox(height: 50),
                                SizedBox(
                                    height: height * 0.4,
                                    child: Consumer<AuthProvider>(builder: (context, authProvider, child) {
                                      return TabBarView(children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10, right: 10),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 35),
                                                child: CustomText(
                                                  title: LocaleKeys.please_Enter_your_phone_number.tr(),
                                                  textAlign: TextAlign.center,
                                                  maxLines: 2,
                                                  textStyle: latoStyle600SemiBold.copyWith(color: Colors.white, fontSize: 16),
                                                ),
                                              ),
                                              SizedBox(
                                                height: height * 0.02,
                                              ),
                                              Container(
                                                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(9)),
                                                  child: Row(
                                                    children: [
                                                      InkWell(
                                                          onTap: () {
                                                            authProvider.pickupCountry(context);
                                                          },
                                                          child: Padding(
                                                              padding: const EdgeInsets.only(left: 20),
                                                              child: Text(authProvider.code, style: latoStyle800ExtraBold))),
                                                      const Divider(color: Colors.black),
                                                      Expanded(
                                                          child: TextField(
                                                        controller: phoneController,
                                                        keyboardType: TextInputType.number,
                                                        decoration: const InputDecoration(hintText: "Phone Number"),
                                                      )),
                                                    ],
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                                          child: SizedBox(
                                            height: height * 0.05,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 35),
                                                  child: CustomText(
                                                    title: LocaleKeys.please_Enter_Your_Email.tr(),
                                                    textAlign: TextAlign.center,
                                                    maxLines: 2,
                                                    textStyle: latoStyle600SemiBold.copyWith(color: Colors.white, fontSize: 16),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: height * 0.02,
                                                ),
                                                CustomTextField(
                                                  fillColor: Colors.white,
                                                  hintText: LocaleKeys.enter_your_email.tr(),
                                                  borderRadius: 4,
                                                  controller: emailController,
                                                  verticalSize: 15,
                                                  autoFillHints: AutofillHints.email,
                                                  inputType: TextInputType.emailAddress,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ]);
                                    })),
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
                          if (emailController.text.isEmpty && phoneController.text.isEmpty) {
                            showMessage(
                              message: LocaleKeys.please_fill_all_the_form.tr(),
                              context: context,
                            );
                          }
                          if (emailController.text.isNotEmpty) {
                            auth.otpSend(emailController.text, true, (bool status, String message) {
                              if (status) {
                                Fluttertoast.showToast(msg: message);
                                Helper.toScreen(
                                    OTPScreen(isFromForgetPassword: false, emailOrNumber: emailController.text.toString()));
                              } else {
                                Fluttertoast.showToast(msg: message, backgroundColor: Colors.red);
                              }
                            });
                          }
                          if (phoneController.text.isNotEmpty) {
                            auth.otpSend(auth.code + phoneController.text, false, (bool status, String message) {
                              if (status) {
                                Fluttertoast.showToast(msg: message);
                                Helper.toScreen(
                                    OTPScreen(isFromForgetPassword: false, emailOrNumber: auth.code + phoneController.text.toString()));
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
                  child: CustomText(
                      title: LocaleKeys.send_OTP.tr(), textStyle: latoStyle600SemiBold.copyWith(color: Colors.white, fontSize: 16)),
                ),
              ),
            ],
          ),
        ),

        // body: Column(
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     TabBar(
        //         indicator: UnderlineTabIndicator(
        //             borderSide: BorderSide(width: 1.0, color: Colors.black),
        //             insets: EdgeInsets.symmetric(horizontal: 16.0)),
        //         tabs: [
        //           Text(
        //             "Phone",
        //             style: latoStyle500Medium,
        //           ),
        //           Text(
        //             "Email",
        //             style: latoStyle500Medium,
        //           ),
        //         ]),
        //     SizedBox(
        //       height: height * 0.02,
        //     ),
        //
        //
        //
        //   ],
        // ),
      ),
    );
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
