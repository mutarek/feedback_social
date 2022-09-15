import 'package:als_frontend/provider/provider.dart';
import 'package:als_frontend/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../const/palette.dart';
import '../../widgets/widgets.dart';

class EmailEnterPage extends StatefulWidget {
  const EmailEnterPage({Key? key}) : super(key: key);

  @override
  State<EmailEnterPage> createState() => _EmailEnterPageState();
}

class _EmailEnterPageState extends State<EmailEnterPage> {
  bool isVisible = false;
  bool emailVafification = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController codeController = TextEditingController();
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
  void initState() {
    final value = Provider.of<EmailVerifyProvider>(context, listen: false);
    value.startTimer();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    numberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Palette.primary,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              toolbarHeight: height * 0.05,
              backgroundColor: Colors.white,
              actions: [
                Consumer<EmailVerifyProvider>(
                    builder: (context, provider, child) {
                  return Visibility(
                    visible:
                        provider.success == true ? false : emailVafification,
                    child: Positioned(
                      child: SizedBox(
                          height: height * 0.04,
                          width: width,
                          child: TabBar(tabs: [
                            Text("Gmail verification",
                                style: GoogleFonts.lato(
                                    color: Palette.primary,
                                    fontWeight: FontWeight.bold)),
                            Text("Phone number verification",
                                style: GoogleFonts.lato(
                                    color: Palette.primary,
                                    fontWeight: FontWeight.bold))
                          ])),
                    ),
                  );
                }),
              ],
              elevation: 0,
            ),
            body: SafeArea(
                child: GestureDetector(onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            }, child: Consumer<EmailVerifyProvider>(
                    builder: (context, provider, child) {
              return Stack(children: [
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
                            "Registration",
                            style: TextStyle(
                                fontSize: height * 0.035,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.2,
                    ),
                  ],
                ),
                Visibility(
                  visible: provider.success2 == true ? true : isVisible,
                  child: Positioned(
                    top: height * 0.71,
                    right: width * 0.62,
                    child: const Text("Sign Up",
                        style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
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
                Visibility(
                  visible: provider.success2 == true ? true : isVisible,
                  child: Positioned(
                    top: height * 0.69,
                    left: width * 0.685,
                    child: Consumer2<RegistrationProvider, EmailVerifyProvider>(
                        builder: (context, provider, emailVerify, child) {
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
                ),

                /*.................body...............*/

                Visibility(
                  visible: provider.success == true ? false : emailVafification,
                  child: Positioned(
                    top: height * 0.2,
                    left: width * 0.04,
                    child: SizedBox(
                      height: height * 0.05,
                      width: width * 0.9,
                      child: TabBarView(children: [
                        LoginTextFiled(
                          h: height * 0.05,
                          w: width * 0.9,
                          child: CustomTextField(
                            hintText: "Enter your  your email",
                            controller: emailController,
                          ),
                        ),
                        Positioned(
                          top: height * 0.2,
                          left: width * 0.04,
                          child: LoginTextFiled(
                            h: height * 0.05,
                            w: width * 0.9,
                            child: CustomTextField(
                              hintText: "Enter your phone number",
                              controller: numberController,
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
                Visibility(
                  visible: provider.success == true ? false : emailVafification,
                  child: Positioned(
                    top: height * 0.26,
                    left: width * 0.04,
                    child: Row(
                      children: [
                        SizedBox(
                          height: height * 0.05,
                          width: width * 0.27,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Palette.scaffold,
                              ),
                              onPressed: () {
                                if (emailController.text != "") {
                                  provider.email = emailController.text;
                                  provider.getCode(emailController.text);
                                } else {
                                  provider.phone = numberController.text;
                                  provider.getCode2(numberController.text);
                                }

                                if (provider.success2 == false) {
                                  Fluttertoast.showToast(
                                      msg:
                                          "succesfully send code please chick your email");
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Email is already registered");
                                }
                              },
                              child: Text(
                                "Get varified",
                                style: GoogleFonts.lato(
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              )),
                        ),
                        SizedBox(
                          width: width * 0.03,
                        ),
                        LoginTextFiled(
                          h: height * 0.05,
                          w: width * 0.36,
                          child: CustomTextField(
                            hintText: "Enter code",
                            controller: codeController,
                          ),
                        ),
                        SizedBox(
                          width: width * 0.03,
                        ),
                        CircleAvatar(
                          radius: 17,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Palette.primary,
                            child: IconButton(
                              icon: const Icon(
                                FontAwesomeIcons.arrowRight,
                                color: Colors.white,
                                size: 15,
                              ),
                              onPressed: () {
                                provider.verifyEmail(
                                    provider.email, codeController.text);
                                if (provider.success == true) {}
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: provider.success == true ? false : emailVafification,
                  child: Positioned(
                    top: height * 0.155,
                    left: width * 0.04,
                    child: Visibility(
                      visible: provider.success2 == true ? true : isVisible,
                      child: LoginTextFiled(
                        h: height * 0.04,
                        w: width * 0.9,
                        child: Center(
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
                    ),
                  ),
                ),
                Visibility(
                  visible: provider.success == true ? false : emailVafification,
                  child: Positioned(
                      top: height * 0.32,
                      left: width * 0.04,
                      child: InkWell(
                          onTap: () {
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
                          child: Text(
                            "Didn't get code resend here",
                            style: GoogleFonts.lato(
                                color: Palette.notificationColor),
                          ))),
                ),
                Visibility(
                  visible: provider.success == true ? true : false,
                  child: Padding(
                    padding: EdgeInsets.only(top: height * 0.25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25.0, 0, 25, 10),
                          child: LoginTextFiled(
                            h: height * 0.05,
                            w: width * 0.9,
                            child: CustomTextField(
                              hintText: "First Name",
                              controller: firstNameController,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25.0, 0, 25, 10),
                          child: LoginTextFiled(
                            h: height * 0.05,
                            w: width * 0.9,
                            child: CustomTextField(
                              hintText: "Last Name",
                              controller: lastNameController,
                            ),
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
                                    style: const TextStyle(color: Colors.white),
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
                            padding: const EdgeInsets.fromLTRB(28.0, 5, 25, 5),
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
                            padding: const EdgeInsets.fromLTRB(25.0, 8, 25, 10),
                            child: Consumer<ShowPasswordProvider>(
                                builder: (context, value, child) {
                              return LoginTextFiled(
                                h: height * 0.05,
                                w: width * 0.9,
                                child: CustomTextField(
                                  hintText: "Password",
                                  controller: passwordController,
                                  obsecureText: value.obsecureText,
                                  suffixIconButton: IconButton(
                                    icon: (value.obsecureText == true)
                                        ? const Icon(Icons.visibility_off)
                                        : const Icon(Icons.visibility),
                                    onPressed: () => value.showPassword(),
                                  ),
                                ),
                              );
                            })),
                      ],
                    ),
                  ),
                ),
              ]);
            })))),
      ),
    );
  }
}
