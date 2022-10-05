// ignore_for_file: unnecessary_string_interpolations

import 'package:als_frontend/old_code/const/palette.dart';
import 'package:als_frontend/old_code/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import '../../provider/provider.dart';
import '../../widgets/widgets.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class AddAnimalScreen extends StatefulWidget {
  const AddAnimalScreen({Key? key}) : super(key: key);

  @override
  State<AddAnimalScreen> createState() => _AddAnimalScreenState();
}

class _AddAnimalScreenState extends State<AddAnimalScreen> {
  TextEditingController animalNameController = TextEditingController();

  TextEditingController speciesController = TextEditingController();

  TextEditingController genusController = TextEditingController();

  TextEditingController givenNameController = TextEditingController();

  TextEditingController ageController = TextEditingController();

  @override
  void initState() {
    final value = Provider.of<GetInfoFromDb>(context, listen: false);
    value.info();
    final image = Provider.of<UserProfileProvider>(context, listen: false);
    image.getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Consumer<AddAnimalProvider>(builder: (context, provider, child) {
      return ModalProgressHUD(
        inAsyncCall: provider.spinner,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Palette.primary),
            title: const Text(""),
            elevation: 0,
          ),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05, vertical: height * 0.02),
              child: Column(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(13)),
                      child: Consumer<UserProfileProvider>(
                          builder: (context, provider, child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            OnwerInfoWidget(
                              name:
                                  "${provider.userprofileData.firstName} ${provider.userprofileData.lastName}",
                              image: (provider.userprofileData.profileImage !=
                                      null)
                                  ? provider.userprofileData.profileImage!
                                  : "https://meektecbacekend.s3.amazonaws.com/media/profile/default.jpeg",
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  Get.to(() => const YourAnimalScreen());
                                },
                                child: const Text("Your animals")),
                          ],
                        );
                      })),
                  const Text(
                    "Add animal",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.01, vertical: height * 0.02),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(13)),
                      width: double.maxFinite,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 0.015, vertical: height * 0.01),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.015,
                                  vertical: height * 0.01),
                              child: CustomTextField(
                                fontColor: Colors.black,
                                hintTextColor: Colors.black,
                                labelColor: Colors.black,
                                label: const Text("Animal name"),
                                controller: animalNameController,
                                height: height * 0.06,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.015,
                                  vertical: height * 0.01),
                              child: CustomTextField(
                                fontColor: Colors.black,
                                hintTextColor: Colors.black,
                                labelColor: Colors.black,
                                label: const Text("Species"),
                                controller: speciesController,
                                height: height * 0.06,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.015,
                                  vertical: height * 0.01),
                              child: CustomTextField(
                                fontColor: Colors.black,
                                hintTextColor: Colors.black,
                                labelColor: Colors.black,
                                label: const Text("Genus"),
                                controller: genusController,
                                height: height * 0.06,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.015,
                                  vertical: height * 0.01),
                              child: CustomTextField(
                                fontColor: Colors.black,
                                hintTextColor: Colors.black,
                                labelColor: Colors.black,
                                label: const Text("Given name"),
                                controller: givenNameController,
                                height: height * 0.06,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0.10, 5, 25, 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  const Text(
                                    "Gender",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                  SizedBox(
                                    width: width*0.2,
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
                                        items: provider.gender
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
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.015,
                                  vertical: height * 0.01),
                              child: CustomTextField(
                                fontColor: Colors.black,
                                hintTextColor: Colors.black,
                                labelColor: Colors.black,
                                label: const Text("age"),
                                controller: ageController,
                                height: height * 0.06,
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(vertical: height * 0.01),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                    "Pick a photo",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  InkWell(
                                    onTap: () => provider.pickImage(),
                                    child: Container(
                                      height: 30,
                                      width: 90,
                                      decoration: BoxDecoration(
                                          color: Palette.primary,
                                          borderRadius:
                                              BorderRadius.circular(13)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(
                                            Icons.photo,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            "Photo",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  (provider.image != null)
                                      ? SizedBox(
                                          height: 40,
                                          width: 40,
                                          child: Image.file(provider.image!),
                                        )
                                      : const Text("No image selected"),
                                ],
                              ),
                            ),
                            Consumer<AddAnimalProvider>(
                                builder: (context, provider, child) {
                              return ElevatedButton(
                                onPressed: () {
                                  provider.uploadImage(
                                    animalNameController.text,
                                    givenNameController.text,
                                    speciesController.text,
                                    provider.drondownValue,
                                    ageController.text,
                                    genusController.text,
                                  );
                                },
                                child: const Text(
                                  "Add",
                                  style: TextStyle(fontSize: 18),
                                ),
                                style: ElevatedButton.styleFrom(
                                  onPrimary: Colors.white,
                                  shadowColor: Colors.greenAccent,
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(32.0)),
                                  minimumSize:
                                      const Size(250, 50), //////// HERE
                                ),
                              );
                            })
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
