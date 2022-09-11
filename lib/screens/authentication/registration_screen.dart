import 'package:als_frontend/provider/provider.dart';
import 'package:als_frontend/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../const/palette.dart';
import '../../widgets/widgets.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  DateTime _dateTime = DateTime.now();
  String dateTime = "";
  var buttonText = "Choose time";
  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(60),
            lastDate: DateTime.now())
        .then((value) {
      setState(() {
        _dateTime = value!;
        buttonText =
            "${_dateTime.year.toString()}-${_dateTime.month.toString()}-${_dateTime.day.toString()}";
        dateTime = buttonText;
      });
    });
  }

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
                              "Resistration",
                              style: TextStyle(
                                  fontSize: height * 0.035,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(25.0, 0, 25, 10),
                            child: CustomTextField(
                              label: const Text("First Name"),
                              controller: firstNameController,
                              height: height * 0.056,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(25.0, 0, 25, 10),
                            child: CustomTextField(
                              label: const Text("Last Name"),
                              controller: lastNameController,
                              height: height * 0.056,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(28.0, 5, 25, 5),
                            child: Row(
                              children: [
                                const Text(
                                  "Date of birth",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                const SizedBox(
                                  width: 50,
                                ),
                                Container(
                                  height: height * 0.045,
                                  width: width * 0.4,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF656B87),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: MaterialButton(
                                    child: Text(
                                      buttonText,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    onPressed: _showDatePicker,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Consumer3<RegistrationProvider, EmailVerifyProvider,
                                  LoginProvider>(
                              builder: (context, provider, emailVerify,
                                  loginProvider, child) {
                            return Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(28.0, 5, 25, 5),
                              child: Row(
                                children: [
                                  const Text(
                                    "Gender",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  const SizedBox(
                                    width: 95,
                                  ),
                                  Container(
                                    height: height * 0.045,
                                    width: width * 0.4,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF656B87),
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Center(
                                      child: DropdownButton<String>(
                                        dropdownColor: const Color(0xFF656B87),
                                        value: provider.drondownValue,
                                        items: provider.items
                                            .map((item) =>
                                                DropdownMenuItem<String>(
                                                    value: item,
                                                    child: Text(
                                                      item,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16),
                                                    )))
                                            .toList(),
                                        onChanged: (item) {
                                          setState(() {
                                            provider.drondownValue = item!;
                                          });
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                          Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(25.0, 8, 25, 10),
                              child: Consumer<ShowPasswordProvider>(
                                  builder: (context, value, child) {
                                return CustomTextField(
                                  label: const Text("Password"),
                                  controller: passwordController,
                                  height: height * 0.056,
                                  obsecureText: value.obsecureText,
                                  suffixIconButton: IconButton(
                                    icon: (value.obsecureText == true)
                                        ? const Icon(Icons.visibility_off)
                                        : const Icon(Icons.visibility),
                                    onPressed: () => value.showPassword(),
                                  ),
                                );
                              })),
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
                    child: Consumer2<RegistrationProvider, EmailVerifyProvider >(
                        builder: (context, provider, emailVerify,
                            child) {
                      return Padding(
                        padding: EdgeInsets.only(right: width * 0.07),
                        child: CustomConatinerButton(
                            child: (provider.loading == false)
                                ? const Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  )
                                : const CircularProgressIndicator(),
                            ontap: () {
                              if (passwordController.text.isEmpty) {
                                showMessage(
                                  message: "Please fill all ther form",
                                  context: context,
                                );
                              } else {
                                provider.password = passwordController.text;
                                provider.loading = true;
                                provider.registration(
                                  firstNameController.text,
                                  lastNameController.text,
                                  emailVerify.email,
                                  dateTime,
                                  provider.drondownValue,
                                  passwordController.text,
                                );

                                if (provider.success == true) {
                                  provider.loading = false;
                                }
                              }
                            }),
                      );
                    }),
                  ),
                  Positioned(
                    top: height * 0.8,
                    left: width * 0.23,
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
                            width: width * 0.09,
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
