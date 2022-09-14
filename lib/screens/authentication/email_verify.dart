import 'package:als_frontend/provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:provider/provider.dart';

class EmailVerify extends StatefulWidget {
  const EmailVerify({Key? key}) : super(key: key);

  @override
  State<EmailVerify> createState() => _EmailVerifyState();
}

class _EmailVerifyState extends State<EmailVerify> {
  TextEditingController codeController = TextEditingController();

  @override
  void initState() {
    final value = Provider.of<EmailVerifyProvider>(context, listen: false);
    value.startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            Consumer<EmailVerifyProvider>(builder: (context, provider, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "A code has been sent to your email.",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Text(
                "Please enter the code to verify your email",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                provider.email,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.amber),
              ),
              const Text(
                "",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.amber),
              ),
              const Text(
                "OTP will exprired after 5 minutes",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    (provider.minutes == 0 && provider.seconds == 0)
                        ? "OTP is expired, resend to get OTP again"
                        : "00 : 0${provider.minutes} : ${(provider.seconds > 9) ? provider.seconds : "0${provider.seconds}"}",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              SizedBox(
                height: 50,
                width: 250,
                child: TextField(
                  controller: codeController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal)),
                      hintText: "Enter your Code here"),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                      height: 50,
                      width: 100,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.amber)),
                        child: const Text("Resend"),
                        onPressed: () {
                          provider.getCode(provider.email);
                          if (provider.success == true) {
                            provider.resetTime();
                            Fluttertoast.showToast(
                                msg: "An OPT has been send to your email");
                          } else {
                            Fluttertoast.showToast(
                                msg: "Something went wrong!");
                          }
                        },
                      )),
                  SizedBox(
                      height: 50,
                      width: 100,
                      child: ElevatedButton(
                        child: const Text("Submit"),
                        onPressed: () {
                          provider.verifyEmail(
                              provider.email, codeController.text);
                          if (provider.success == true) {}
                        },
                      )),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
