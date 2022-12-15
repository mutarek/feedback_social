import 'package:als_frontend/data/model/response/user_profile_model.dart';
import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/provider/profile_provider.dart';
import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/palette.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:als_frontend/widgets/custom_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key, this.userprofileData}) : super(key: key);
  final UserProfileModel? userprofileData;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController presentCompanyController = TextEditingController();
  TextEditingController presentEducationController = TextEditingController();
  TextEditingController religionController = TextEditingController();
  TextEditingController liveInAddressController = TextEditingController();
  TextEditingController fromAddressController = TextEditingController();

  @override
  void initState() {
   if(widget.userprofileData != null){
     firstNameController.text = widget.userprofileData!.firstName!;
     lastNameController.text = widget.userprofileData!.lastName!;
     presentCompanyController.text = widget.userprofileData!.presentCompany!;
     presentEducationController.text = widget.userprofileData!.presentEducation!;
     religionController.text = widget.userprofileData!.religion!;
     liveInAddressController.text = widget.userprofileData!.livesInAddress!;
     fromAddressController.text = widget.userprofileData!.fromAddress!;
   }


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Helper.back();
            },
            icon: const Icon(FontAwesomeIcons.arrowLeft, color: Colors.black)),
        title: CustomText(title: LocaleKeys.update_Profile_Info.tr(), color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
      ),
      body: Consumer<ProfileProvider>(builder: (context, provider, child) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.02),
              CustomText(title: LocaleKeys.enter_First_Name.tr(), fontSize: 15, fontWeight: FontWeight.normal, color: Colors.black),
              const SizedBox(height: 7),
              CustomTextField(
                hintText: LocaleKeys.write_here.tr(),
                controller: firstNameController,
                fillColor: Colors.white,
                borderRadius: 5,
                verticalSize: 13,
              ),
              SizedBox(height: height * 0.01),
              CustomText(title:  LocaleKeys.enter_Last_Name.tr(), fontSize: 15, fontWeight: FontWeight.normal, color: Colors.black),
              const SizedBox(height: 7),
              CustomTextField(
                hintText: LocaleKeys.write_here.tr(),
                controller: lastNameController,
                fillColor: Colors.white,
                borderRadius: 5,
                verticalSize: 13,
              ),
              SizedBox(height: height * 0.01),
              CustomText(title: LocaleKeys.enter_your_Job_about.tr(), fontSize: 15, fontWeight: FontWeight.normal, color: Colors.black),
              const SizedBox(height: 7),
              CustomTextField(
                hintText: LocaleKeys.write_here.tr(),
                controller: presentCompanyController,
                fillColor: Colors.white,
                borderRadius: 5,
                verticalSize: 13,
                prefixIconUrl: FontAwesomeIcons.briefcase,
                isShowPrefixIcon: true,
              ),
              SizedBox(height: height * 0.01),
              CustomText(title: LocaleKeys.enter_your_Education.tr(), fontSize: 15, fontWeight: FontWeight.normal, color: Colors.black),
              const SizedBox(height: 7),
              CustomTextField(
                hintText:LocaleKeys.write_here.tr(),
                controller: presentEducationController,
                fillColor: Colors.white,
                borderRadius: 5,
                verticalSize: 13,
                prefixIconUrl: FontAwesomeIcons.graduationCap,
                isShowPrefixIcon: true,
              ),
              SizedBox(height: height * 0.01),
              CustomText(title: LocaleKeys.select_your_Gender.tr(), fontSize: 15, fontWeight: FontWeight.normal, color: Colors.black),
              DropdownButton(
                value: provider.selectDGenderValue,
                icon: const Icon(Icons.keyboard_arrow_down),
                isExpanded: true,
                items: provider.gender.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  provider.changeGender(newValue!);
                },
              ),
              SizedBox(height: height * 0.01),
              CustomText(title: LocaleKeys.enter_your_Religion.tr(), fontSize: 15, fontWeight: FontWeight.normal, color: Colors.black),
              const SizedBox(height: 7),
              CustomTextField(
                hintText: LocaleKeys.write_here.tr(),
                controller: religionController,
                fillColor: Colors.white,
                borderRadius: 5,
                verticalSize: 13,
                prefixIconUrl: FontAwesomeIcons.personPraying,
                isShowPrefixIcon: true,
              ),
              SizedBox(height: height * 0.01),
              CustomText(title: LocaleKeys.enter_your_Current_Location.tr(), fontSize: 15, fontWeight: FontWeight.normal, color: Colors.black),
              const SizedBox(height: 7),
              CustomTextField(
                hintText: LocaleKeys.write_here.tr(),
                controller: liveInAddressController,
                fillColor: Colors.white,
                borderRadius: 5,
                verticalSize: 13,
                prefixIconUrl: FontAwesomeIcons.locationDot,
                isShowPrefixIcon: true,
              ),
              SizedBox(height: height * 0.01),
              const CustomText(title: "Enter your permanent location:", fontSize: 15, fontWeight: FontWeight.normal, color: Colors.black),
              const SizedBox(height: 7),
              CustomTextField(
                hintText: LocaleKeys.write_here.tr(),
                controller: fromAddressController,
                fillColor: Colors.white,
                borderRadius: 5,
                verticalSize: 13,
                prefixIconUrl: FontAwesomeIcons.house,
                isShowPrefixIcon: true,
              ),
              SizedBox(height: height * 0.02),
              Center(
                child: !provider.isLoading
                    ? ElevatedButton(
                        onPressed: () {
                          provider.updateData(
                              firstNameController.text,
                              lastNameController.text,
                              presentCompanyController.text,
                              presentEducationController.text,
                              religionController.text,
                              liveInAddressController.text,
                              fromAddressController.text, (bool status) {
                            if (status) {
                              Provider.of<AuthProvider>(context, listen: false).getUserInfo();
                              Helper.back();
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Palette.timeColor, textStyle: GoogleFonts.lato(fontWeight: FontWeight.bold)),
                        child:  Text(LocaleKeys.save_and_change.tr()))
                    : const CircularProgressIndicator(),
              ),
              SizedBox(height: height * 0.02),
            ],
          ),
        );
      }),
    );
  }
}
