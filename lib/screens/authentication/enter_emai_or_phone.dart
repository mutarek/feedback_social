import 'package:als_frontend/provider/provider.dart';
import 'package:als_frontend/screens/screens.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../const/palette.dart';
import '../../widgets/widgets.dart';

class EnterEmailOrPhone extends StatefulWidget {
  const EnterEmailOrPhone({Key? key}) : super(key: key);

  @override
  State<EnterEmailOrPhone> createState() => _EnterEmailOrPhoneState();
}

class _EnterEmailOrPhoneState extends State<EnterEmailOrPhone> {
  final countryPicker = const FlCountryCodePicker();
  bool isVisible = false;
  bool emailVafification = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String countryCode = "+1";

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
    value.success2 = false;
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
            body: SafeArea(
              child: GestureDetector(
              onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
              
              },
              child: Consumer<EmailVerifyProvider>(
                    builder: (context, provider, child) {
                  return (provider.success2 == false)?
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          height: height * 0.2,
                          width: width,
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: height * 0.05, left: width * 0.1),
                            child: Text(
                              "Registration",
                              style: TextStyle(
                                  fontSize: height * 0.035,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.2,
                        ),
                        (provider.success == true)?LoginTextFiled(
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
                        ): Container(),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left:width*0.07),
                              child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  "Register with",
                                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500, fontSize: 16),
                                ),
                                TextButton(
                                    onPressed: () {
                                      provider.emailLogin();
                                      setState(() {});
                                    },
                                    child: Text(
                                        (provider.isEmail == true)
                                            ? "Phone"
                                            : "Email",
                                        style: const TextStyle(
                                            color: Colors.orange, fontWeight: FontWeight.w500, fontSize: 18)))
                              ],
                          ),
                            ),
                            SizedBox(
                            height: height * 0.05,
                            width: width * 0.9,
                            child: (provider.isEmail == true)
                                ? LoginTextFiled(
                                    h: height * 0.05,
                                    w: width * 0.9,
                                    child: CustomTextField(
                                      hintText: "Enter your  your email",
                                      controller: emailController,
                                    ),
                                  )
                                : Expanded(
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                            onTap: () async {
                                              final code = await countryPicker
                                                  .showPicker(context: context);
                                              setState(() {
                                                countryCode = (code != null)
                                                    ? code.dialCode.toString()
                                                    : "+1";
                                              });
                                            },
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius:
                                                        BorderRadius.circular(5)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    countryCode,
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ))),
                                        LoginTextFiled(
                                            h: height * 0.05,
                                            w: width * 0.75,
                                            child: CustomTextField(
                                              hintText: "Enter your phone number",
                                              controller: numberController,
                                              keybordType: TextInputType.number,
                                            ),
                                          ),
                                        
                                      ],
                                    ),
                                  ),
                      ),
                          ],
                        ),
                        InkWell(
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
                          )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Palette.scaffold,
                              ),
                              child: Text(
                                "Get varified",
                                style: GoogleFonts.lato(
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              ),
                              onPressed: () {
                                if (provider.isEmail == true) {
                                  if (emailController.text.isNotEmpty) {
                                    provider.email = emailController.text;
                                    provider.getCode(emailController.text);

                                    if (provider.success2 == true) {
                                      provider.startTimer();
                                    }
                                  }
                                } else {
                                  provider.phone =
                                      "$countryCode${numberController.text}";
                                  provider.getCode2(
                                      "$countryCode${numberController.text}");

                                  if (provider.success2 == true) {
                                    provider.startTimer();
                                  }
                                }
                              }),
                            
                          Row(
                            children: [
                              LoginTextFiled(
                                h: height * 0.05,
                                w: width * 0.36,
                                child: CustomTextField(
                                  hintText: "Enter code",
                                  controller: codeController,
                                ),
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
                                      (provider.isEmail == true)
                                          ? provider.verifyEmail(provider.email,
                                              codeController.text)
                                          : provider.verifyPhone(provider.phone,
                                              codeController.text);
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                          
                          ],
                        ),
                    ],
                  ):
                  
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                              height: height * 0.2,
                              width: width,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.05, left: width * 0.1),
                                child: Text(
                                  "Registration",
                                  style: TextStyle(
                                      fontSize: height * 0.035,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                      Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(25.0, 0, 25, 10),
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
                              padding:
                                  const EdgeInsets.fromLTRB(25.0, 0, 25, 10),
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
                              padding:
                                  const EdgeInsets.fromLTRB(28.0, 5, 25, 5),
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
                                        style: const TextStyle(
                                            color: Colors.white),
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
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      child: Center(
                                        child: DropdownButton<String>(
                                          dropdownColor:
                                              const Color(0xFF656B87),
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
                          Consumer2<RegistrationProvider,
                                    EmailVerifyProvider>(
                                builder:
                                    (context, provider, emailVerify, child) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                   const Text("Register",
                                      style: TextStyle(
                                          fontSize: 32,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                  Padding(
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
                                            if (emailVerify.isEmail == true) {
                                              provider.password =
                                                  passwordController.text;
                                              provider.loading = true;
                                              provider.registration(
                                                firstNameController.text,
                                                lastNameController.text,
                                                emailVerify.email,
                                                dateTime,
                                                provider.drondownValue,
                                                passwordController.text,
                                              );
                                            } else {
                                              provider.password =
                                                  passwordController.text;
                                              provider.loading = true;
                                              provider.registrationWithPhone(
                                                firstNameController.text,
                                                lastNameController.text,
                                                emailVerify.phone,
                                                dateTime,
                                                provider.drondownValue,
                                                passwordController.text,
                                              );
                                            }

                                            if (provider.success == true) {
                                              provider.loading = false;
                                            }
                                          }
                                        }),
                                  ),
                                 
                              
                                ],
                              );
                            }),
                    ],
                  );
                }
              ),
            )
            )
          )
        ),
      );
  }
}
