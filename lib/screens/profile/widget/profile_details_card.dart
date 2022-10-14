import 'package:als_frontend/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../old_code/const/palette.dart';

class ProfileDetailsCard extends StatelessWidget {
  const ProfileDetailsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Consumer<ProfileProvider>(builder: (context, provider, child) {
      return Container(
        color: Colors.white,
        width: width * .92,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: height * 0.01, horizontal: width * 0.02),
          child: Column(
            children: [
              Visibility(
                visible: provider.userprofileData.presentCompany == "" ? false : true,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(FontAwesomeIcons.briefcase, size: height * 0.019),
                        SizedBox(width: width * 0.03),
                        Text(
                          "Company Name: ",
                          style: GoogleFonts.lato(fontSize: 12),
                        ),
                        Text(
                          provider.userprofileData.presentCompany.toString(),
                          style: GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.009),
                  ],
                ),
              ),
              Visibility(
                visible: provider.userprofileData.presentEducation == "" ? false : true,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.graduationCap,
                          size: height * 0.019,
                        ),
                        SizedBox(
                          width: width * 0.03,
                        ),
                        Text(
                          "Education: ",
                          style: GoogleFonts.lato(
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          provider.userprofileData.presentEducation.toString(),
                          style: GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * 0.009,
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: provider.userprofileData.gender == "" ? false : true,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.user,
                          size: height * 0.019,
                        ),
                        SizedBox(
                          width: width * 0.03,
                        ),
                        Text(
                          "Gender: ",
                          style: GoogleFonts.lato(
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          provider.userprofileData.gender.toString(),
                          style: GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * 0.009,
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: provider.userprofileData.religion == "" ? false : true,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.personPraying,
                          size: height * 0.019,
                        ),
                        SizedBox(
                          width: width * 0.03,
                        ),
                        Text(
                          "Religion: ",
                          style: GoogleFonts.lato(
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          provider.userprofileData.religion.toString(),
                          style: GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * 0.009,
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: provider.userprofileData.livesInAddress == "" ? false : true,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.locationDot,
                          size: height * 0.019,
                        ),
                        SizedBox(
                          width: width * 0.03,
                        ),
                        Text(
                          "Lives in: ",
                          style: GoogleFonts.lato(
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          provider.userprofileData.livesInAddress.toString(),
                          style: GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.009,
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: provider.userprofileData.fromAddress == "" ? false : true,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.house,
                          size: height * 0.019,
                        ),
                        SizedBox(
                          width: width * 0.03,
                        ),
                        Text(
                          "Home town: ",
                          style: GoogleFonts.lato(
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          provider.userprofileData.fromAddress.toString(),
                          style: GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * 0.009,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.009,
              ),
              InkWell(
                onTap: () {
                  // Get.to(() => const EditProfile());
                },
                child: Container(
                  height: height * 0.035,
                  width: width * 1,
                  decoration: BoxDecoration(
                    color: Palette.scaffold,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      "Edit Profile",
                      style: GoogleFonts.lato(color: Colors.black, fontSize: 10, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
