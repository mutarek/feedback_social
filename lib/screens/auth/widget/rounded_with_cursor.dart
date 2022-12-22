import 'package:als_frontend/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class RoundedWithCustomCursor extends StatefulWidget {
  final TextEditingController pinController;
  final AuthProvider authProvider;

  const RoundedWithCustomCursor(this.pinController, this.authProvider, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RoundedWithCustomCursorState createState() => _RoundedWithCustomCursorState();

  @override
  String toStringShort() => 'Rounded With Cursor';
}

class _RoundedWithCustomCursorState extends State<RoundedWithCustomCursor> {
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    widget.pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Colors.white;
    const fillColor = Colors.white;

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: GoogleFonts.poppins(fontSize: 22, color: Colors.black),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(19), border: Border.all(color: Colors.white)),
    );

    return Form(
      key: formKey,
      child: Pinput(
        controller: widget.pinController,
        focusNode: focusNode,
        androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
        listenForMultipleSmsOnAndroid: true,
        defaultPinTheme: defaultPinTheme,
        // validator: (value) {
        //   print('shuvo $value');
        //   return value == '2222' ? null : 'Pin is incorrect';
        // },
        hapticFeedbackType: HapticFeedbackType.lightImpact,
        onCompleted: (pin) {
          debugPrint('onCompleted: $pin');
        },
        onChanged: (value) {
          debugPrint('onChanged: $value');
        },
        cursor: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 9),
              width: 22,
              height: 1,
              color: focusedBorderColor,
            ),
          ],
        ),
        focusedPinTheme: defaultPinTheme.copyWith(
          decoration: defaultPinTheme.decoration!.copyWith(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: focusedBorderColor),
          ),
        ),
        submittedPinTheme: defaultPinTheme.copyWith(
          decoration: defaultPinTheme.decoration!.copyWith(
            color: fillColor,
            borderRadius: BorderRadius.circular(19),
            border: Border.all(color: focusedBorderColor),
          ),
        ),
        // errorPinTheme: defaultPinTheme.copyBorderWith(
        //   border: Border.all(color: Colors.redAccent),
        // ),
      ),
    );
  }
}
