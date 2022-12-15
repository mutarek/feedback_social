import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:als_frontend/util/palette.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ForgotPasswordScreen extends StatelessWidget {
   ForgotPasswordScreen({Key? key,
    required this.isFromForgetPassword,
    required this.emailorPhonenumber,
    required this.otpcode,
  }) : super(key: key);
 final bool isFromForgetPassword;
 final String emailorPhonenumber;
 final String otpcode;

   final FocusNode passwordFocus = FocusNode();
   final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Palette.primary,
      body:  GestureDetector(
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
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(width * 4))),
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
                        LocaleKeys.confirm_Password.tr(),
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
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: CustomTextField(
                                  fillColor: Colors.white,
                                  hintText: LocaleKeys.enter_new_password.tr(),
                                  borderRadius: 4,
                                  controller: passwordController,
                                  verticalSize: 15,
                                  autoFillHints: AutofillHints.email,
                                  inputType: TextInputType.emailAddress,
                                  focusNode: passwordFocus,
                                ),
                              ),

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