import 'package:als_frontend/old_code/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../../const/palette.dart';
import '../../widgets/widgets.dart';

class EditAnimalScreen extends StatefulWidget {
  const EditAnimalScreen({Key? key}) : super(key: key);

  @override
  State<EditAnimalScreen> createState() => _EditAnimalScreenState();
}

class _EditAnimalScreenState extends State<EditAnimalScreen> {
  TextEditingController animalNameController = TextEditingController();
  TextEditingController givenNameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController genusController = TextEditingController();
  TextEditingController speciesController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  @override
  void initState() {
    final value = Provider.of<OwnerAnimalProvider>(context, listen: false);
    value.getData();

    setState(() {
      animalNameController.text = value.animals![value.animalIndex!].animalName!;
      givenNameController.text = value.animals![value.animalIndex!].givenName!;
      genderController.text = value.animals![value.animalIndex!].gender!;
      genusController.text = value.animals![value.animalIndex!].genus!;
      speciesController.text = value.animals![value.animalIndex!].species!;
      ageController.text = value.animals![value.animalIndex!].age!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Palette.scaffold,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            "ALS",
            style: TextStyle(
                color: Palette.primary,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: -1.2),
          ),
          actions: [
            CustomIconButton(iconName: Icons.search, onPressed: () {}),
            CustomIconButton(
                iconName: MdiIcons.facebookMessenger, onPressed: () {}),
          ],
        ),
        body: Consumer2<OwnerAnimalProvider, AddAnimalProvider>(
            builder: (context, provider, editDelete, child) {
          return SingleChildScrollView(
            child: SafeArea(
              child: SingleChildScrollView(
                  child: Container(
                height: h,
                width: w,
                color: Palette.scaffold,
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: w * 0.36),
                      child: Text(
                        "Animal Details",
                        style: GoogleFonts.lato(
                            fontSize: h * 0.03, fontWeight: FontWeight.w700),
                      ),
                    ),
                    Positioned(
                      top: h * 0.1,
                      right: w * 0.04,
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                          height: h * 0.64,
                          width: w * 0.9,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: h * 0.06,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: w * 0.04),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: h * 0.03,
                                      ),
                                      Row(
                                        children: [
                                          Text("Animal name : ",
                                              style: GoogleFonts.lato(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            width: w * 0.1,
                                          ),
                                          SizedBox(
                                            width: w * 0.4,
                                            height: w * 0.04,
                                            child: TextField(
                                              controller: animalNameController,
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: h * 0.017,
                                      ),
                                      Row(
                                        children: [
                                          Text("Given name :",
                                              style: GoogleFonts.lato(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            width: w * 0.129,
                                          ),
                                          SizedBox(
                                            width: w * 0.4,
                                            height: w * 0.04,
                                            child: TextField(
                                              controller: givenNameController,
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: h * 0.017,
                                      ),
                                      Row(
                                        children: [
                                          Text("Gender : ",
                                              style: GoogleFonts.lato(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            width: w * 0.211,
                                          ),
                                          SizedBox(
                                            width: w * 0.4,
                                            height: w * 0.04,
                                            child: TextField(
                                              controller: genderController,
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: h * 0.017,
                                      ),
                                      Row(
                                        children: [
                                          Text("Genus : ",
                                              style: GoogleFonts.lato(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            width: w * 0.23,
                                          ),
                                          SizedBox(
                                            width: w * 0.4,
                                            height: w * 0.04,
                                            child: TextField(
                                              controller: genderController,
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: h * 0.017,
                                      ),
                                      Row(
                                        children: [
                                          Text("Species : ",
                                              style: GoogleFonts.lato(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            width: w * 0.212,
                                          ),
                                          SizedBox(
                                            width: w * 0.4,
                                            height: w * 0.04,
                                            child: TextField(
                                              controller: speciesController,
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: h * 0.017,
                                      ),
                                      Row(
                                        children: [
                                          Text("Age : ",
                                              style: GoogleFonts.lato(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            width: w * 0.29,
                                          ),
                                          SizedBox(
                                            width: w * 0.4,
                                            height: w * 0.04,
                                            child: TextField(
                                              controller: ageController,
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: h * 0.1,
                                      ),
                                      Center(
                                          child: ElevatedButton(
                                              onPressed: () {
                                                editDelete.editanimal(
                                                    animalNameController.text,
                                                    givenNameController.text,
                                                    speciesController.text,
                                                    genderController.text,
                                                    ageController.text,
                                                    genusController.text);
                                              },
                                              child: const Text("Save")))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: h * 0.05,
                      left: w * 0.42,
                      child: CircleAvatar(
                        radius: h * 0.05,
                        backgroundColor: Palette.notificationColor,
                        child: CircleAvatar(
                          radius: h * 0.1,
                          backgroundColor: Palette.scaffold,
                          backgroundImage: NetworkImage(
                              provider.animals![provider.animalIndex!].image!),
                        ),
                      ),
                    )
                  ],
                ),
              )),
            ),
          );
        }));
  }
}
