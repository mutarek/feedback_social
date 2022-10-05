import 'package:als_frontend/old_code/provider/provider.dart';
import 'package:als_frontend/old_code/screens/authentication/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController otpController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset:false,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical:height*0.2),
          child: Consumer2<EmailVerifyProvider, ForgotPasswordProvider>(
              builder: (context, provider, provider2, child) {
            return Column(
              
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal:width*0.02),
                  child: Row(
                    children: [
                      const Text(
                        "Email",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: width*0.01,
                      ),
                      SizedBox(
                        height: height*0.1,
                        width: width*0.6,
                        child: TextField(
                          controller: emailController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.teal)),
                              hintText: "Enter your email"),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.01,
                      ),
                      SizedBox(
                          height: height*0.09,
                          width: width*0.2,
                          child: ElevatedButton(
                            child: (provider2.emailSent == false)
                                ? const Text("Send")
                                : const Text("Resend"),
                            onPressed: () {
                              provider2.email = emailController.text;
                              provider2.getOtp(emailController.text);
                              if (provider2.success == false) {
                                provider.startTimer();
                              } else {
                                provider.resetTime();
                              }
                            },
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                (provider2.emailSent == true)
                    ? Column(
                        children: [
                          const Text(
                            "Please enter the code to verify your email",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Text(
                            "OTP will exprired after 5 minutes",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                           SizedBox(
                            height: height * 0.1,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: width*0.55),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text("00 : 0${provider.minutes} : ${(provider.seconds > 9) ? provider.seconds : "0${provider.seconds}"}",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("OTP"),
                                  SizedBox(
                                    width: width*0.17,
                                  ),
                                  SizedBox(
                                    height: height * 0.1,
                                    width: width * 0.6,
                                    child: TextField(
                                      controller: otpController,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: Colors.teal)),
                                          hintText: "Enter your Code here"),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("New password"),
                              SizedBox(
                                width: width * 0.02,
                              ),
                              SizedBox(
                                height: height * 0.1,
                                width: width * 0.6,
                                child: TextField(
                                  controller: newPasswordController,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.teal)),
                                      hintText: "Enter your new password"),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                              height: height * 0.07,
                              width: width * 0.2,
                              child: ElevatedButton(
                                child: const Text("Submit"),
                                onPressed: () {
                                  provider2.changePassword(otpController.text,
                                      newPasswordController.text);
                                  if (provider.getCodeSuccess == true) {
                                    Get.to(const LoginScreen());
                                  }
                                },
                              )),
                        ],
                      )
                    : Container(),
              ],
            );
          }),
        ),
      ),
    );
  }
}
