import 'package:als_frontend/old_code/const/palette.dart';
import 'package:als_frontend/old_code/widgets/profile/edit_profile_widget.dart';
import 'package:als_frontend/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


class EditProfile extends StatefulWidget {
  const EditProfile({
    Key? key,
    this.firstName,
    this.lastName,
    this.presentCompany,
    this.presentEducation,
    this.gender,
    this.religion,
    this.livesInAddress,
    this.fromAddress,
  }) : super(key: key);
  final String? firstName;
  final String? lastName;
  final String? presentCompany;
  final String? presentEducation;
  final String? gender;
  final String? religion;
  final String? livesInAddress;
  final String? fromAddress;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController presentCompanyController = TextEditingController();
  TextEditingController presentEducationController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController religionController = TextEditingController();
  TextEditingController liveInAddressController = TextEditingController();
  TextEditingController fromaddressController = TextEditingController();

  // @override
  // void initState() {
  //   final value = Provider.of<UserProfileProvider>(context, listen: false);
  //   value.getUserData();
  //   firstNameController.text = value.userprofileData.firstName!;
  //   lastNameController.text = value.userprofileData.lastName!;
  //   presentCompanyController.text = value.userprofileData.presentCompany!;
  //   presentEducationController.text = value.userprofileData.presentEducation!;
  //   genderController.text = value.userprofileData.gender!;
  //   religionController.text = value.userprofileData.religion!;
  //   liveInAddressController.text = value.userprofileData.livesInAddress!;
  //   fromaddressController.text = value.userprofileData.fromAddress!;
  //   super.initState();
  // }


  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Palette.primary,
      body: Consumer<ProfileProvider>(
          builder: (context, provider, child) {
            return SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height * 0.04,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.06,
                        ),
                        IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(
                              FontAwesomeIcons.arrowLeft,
                              color: Colors.white,
                            )),
                        SizedBox(
                          width: width * 0.04,
                        ),
                        Text(
                          "Update Profile",
                          style: GoogleFonts.lato(
                              fontSize: height * 0.04, color: Palette.scaffold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: width*0.06),
                      child: Text("Enter First Name",
                        style: GoogleFonts.lato(color: Palette.scaffold,
                            fontSize: 18,fontWeight: FontWeight.w400),),
                    ),
                    EditProfileWidget(
                        controller: firstNameController,
                        hintText: provider.userprofileData.firstName!),
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.06),
                      child: Text(
                        "Enter Last Name",
                        style: GoogleFonts.lato(
                            color: Palette.scaffold,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    EditProfileWidget(
                        controller: lastNameController,
                        hintText: provider.userprofileData.lastName!),
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.06),
                      child: Text(
                        "Enter your  Job about",
                        style: GoogleFonts.lato(
                            color: Palette.scaffold,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    EditProfileWidget(
                      controller: presentCompanyController,
                      hintText: provider.userprofileData.presentCompany!,
                      iconName: Icon(
                        FontAwesomeIcons.briefcase,
                        size: height * 0.019,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.06),
                      child: Text(
                        "Enter your  Education",
                        style: GoogleFonts.lato(
                            color: Palette.scaffold,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    EditProfileWidget(
                      controller: presentEducationController,
                      hintText: provider.userprofileData.presentEducation!,
                      iconName: Icon(
                        FontAwesomeIcons.graduationCap,
                        size: height * 0.019,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.06),
                      child: Text(
                        "Enter your  Gender",
                        style: GoogleFonts.lato(
                            color: Palette.scaffold,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    EditProfileWidget(
                      controller: genderController,
                      hintText: provider.userprofileData.gender!,
                      iconName: Icon(
                        FontAwesomeIcons.user,
                        size: height * 0.019,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.06),
                      child: Text(
                        "Enter your  Religion",
                        style: GoogleFonts.lato(
                            color: Palette.scaffold,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    EditProfileWidget(
                      controller: religionController,
                      hintText: provider.userprofileData.religion!,
                      iconName: Icon(
                        FontAwesomeIcons.personPraying,
                        size: height * 0.019,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.06),
                      child: Text(
                        "Enter your  Current Location",
                        style: GoogleFonts.lato(
                            color: Palette.scaffold,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    EditProfileWidget(
                      controller: liveInAddressController,
                      hintText: provider.userprofileData.livesInAddress!,
                      iconName: Icon(
                        FontAwesomeIcons.locationDot,
                        size: height * 0.019,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.06),
                      child: Text(
                        "Enter your permanent location",
                        style: GoogleFonts.lato(
                            color: Palette.scaffold,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    EditProfileWidget(
                      controller: fromaddressController,
                      hintText: provider.userprofileData.fromAddress!,
                      iconName: Icon(
                        FontAwesomeIcons.house,
                        size: height * 0.019,
                      ),
                    ),
                    Center(
                      child: ElevatedButton(
                          onPressed: () {
                            provider.updateData(
                                firstNameController.text,
                                lastNameController.text,
                                presentCompanyController.text,
                                presentEducationController.text,
                                genderController.text,
                                religionController.text,
                                liveInAddressController.text,
                                fromaddressController.text);
                            if (provider.success == true) {
                              Fluttertoast.showToast(msg: "Updated");
                            }else{
                              Fluttertoast.showToast(msg: "Something went wrong!");
                            }
                          },
                          child: const Text("Save and change"),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Palette.timeColor,
                              textStyle:
                              GoogleFonts.lato(fontWeight: FontWeight.bold))),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
