import 'package:als_frontend/data/model/response/owner_animal_model.dart';
import 'package:als_frontend/provider/animal_provider.dart';
import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/screens/animal/my_animal_screen.dart';
import 'package:als_frontend/screens/animal/widget/owner_info_widget.dart';
import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/palette.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_button.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:als_frontend/widgets/custom_text_field.dart';
import 'package:als_frontend/widgets/network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class AddEditAnimalScreen extends StatefulWidget {
  final bool isEdit;
  final OnwerAnimalModel? animalModel;
  final int index;

  const AddEditAnimalScreen({this.isEdit = false, this.animalModel, this.index = 0, Key? key}) : super(key: key);

  @override
  State<AddEditAnimalScreen> createState() => _AddEditAnimalScreenState();
}

class _AddEditAnimalScreenState extends State<AddEditAnimalScreen> {
  final TextEditingController animalNameController = TextEditingController();

  final TextEditingController speciesController = TextEditingController();

  final TextEditingController genusController = TextEditingController();

  final TextEditingController givenNameController = TextEditingController();

  final TextEditingController ageController = TextEditingController();

  final FocusNode nameFocus = FocusNode();

  final FocusNode speciesFocus = FocusNode();

  final FocusNode genusFocus = FocusNode();

  final FocusNode givenNameFocus = FocusNode();

  final FocusNode ageFocus = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isEdit) {
      animalNameController.text = widget.animalModel!.animalName!;
      speciesController.text = widget.animalModel!.species!;
      genusController.text = widget.animalModel!.genus!;
      givenNameController.text = widget.animalModel!.givenName!;
      ageController.text = widget.animalModel!.age!;
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Consumer2<AuthProvider, AnimalProvider>(
        builder: (context, authProvider, animalProvider, child) => ModalProgressHUD(
              inAsyncCall: animalProvider.isLoading,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  iconTheme: const IconThemeData(color: Palette.primary),
                  title: CustomText(
                      title: '${widget.isEdit ? LocaleKeys.update.tr() : LocaleKeys.add.tr()} animal',
                      textStyle: latoStyle700Bold.copyWith(fontSize: 18)),
                  elevation: 0,
                ),
                body: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: height * 0.02),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: OwnerInfoWidget(
                                  name: authProvider.name,
                                  image: (authProvider.profileImage != null)
                                      ? authProvider.profileImage
                                      : "https://meektecbacekend.s3.amazonaws.com/media/profile/default.jpeg",
                                ),
                              ),
                              SizedBox(
                                width: 120,
                                child: CustomButton(
                                    btnTxt: LocaleKeys.your_animals.tr(),
                                    onTap: () {
                                      Helper.toScreen( const MyAnimalScreen());
                                    },
                                    textWhiteColor: true,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(.1), blurRadius: 10.0, spreadRadius: 3.0, offset: const Offset(0.0, 0.0))
                            ]),
                            child: Column(
                              children: [
                                CustomTextField(
                                  hintText: LocaleKeys.animal_name.tr(),
                                  controller: animalNameController,
                                  borderRadius: 5,
                                  fillColor: Colors.white,
                                  focusNode: nameFocus,
                                  nextFocus: speciesFocus,
                                  verticalSize: 13,
                                ),
                                const SizedBox(height: 10),
                                CustomTextField(
                                  hintText:LocaleKeys.species.tr(),
                                  controller: speciesController,
                                  borderRadius: 5,
                                  fillColor: Colors.white,
                                  focusNode: speciesFocus,
                                  nextFocus: genusFocus,
                                  verticalSize: 13,
                                ),
                                const SizedBox(height: 10),
                                CustomTextField(
                                  hintText: 'Genus',
                                  controller: genusController,
                                  borderRadius: 5,
                                  fillColor: Colors.white,
                                  focusNode: genusFocus,
                                  nextFocus: givenNameFocus,
                                  verticalSize: 13,
                                ),
                                const SizedBox(height: 10),
                                CustomTextField(
                                  hintText: LocaleKeys.given_name.tr(),
                                  controller: givenNameController,
                                  borderRadius: 5,
                                  fillColor: Colors.white,
                                  focusNode: givenNameFocus,
                                  nextFocus: ageFocus,
                                  verticalSize: 13,
                                ),
                                const SizedBox(height: 10),
                                CustomTextField(
                                  hintText: LocaleKeys.age.tr(),
                                  controller: ageController,
                                  borderRadius: 5,
                                  fillColor: Colors.white,
                                  focusNode: ageFocus,
                                  inputType: TextInputType.number,
                                  inputAction: TextInputAction.done,
                                  verticalSize: 13,
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      LocaleKeys.gender.tr(),
                                      style: const TextStyle(color: Colors.black, fontSize: 20),
                                    ),
                                    SizedBox(width: width * 0.2),
                                    Expanded(
                                      child: Container(
                                        height: height * 0.045,
                                        decoration:
                                            BoxDecoration(color: const Color(0xFF656B87), borderRadius: BorderRadius.circular(15.0)),
                                        child: Center(
                                          child: DropdownButton<String>(
                                            dropdownColor: const Color(0xFF656B87),
                                            value: animalProvider.selectGender,
                                            underline: const SizedBox.shrink(),
                                            icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                                            isExpanded: true,
                                            items: animalProvider.gender
                                                .map((item) => DropdownMenuItem<String>(
                                                    value: item,
                                                    child: Center(
                                                      child: Text(
                                                        item,
                                                        style: const TextStyle(color: Colors.white, fontSize: 16),
                                                      ),
                                                    )))
                                                .toList(),
                                            onChanged: (item) {
                                              animalProvider.changeGenderStatus(item!);
                                            },
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      LocaleKeys.pick_a_photo.tr(),
                                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                                    ),
                                    InkWell(
                                      onTap: () => animalProvider.pickImage(),
                                      child: Container(
                                        height: 30,
                                        width: 90,
                                        decoration: BoxDecoration(color: Palette.primary, borderRadius: BorderRadius.circular(13)),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Icon(Icons.photo, color: Colors.white),
                                            Text(LocaleKeys.photo.tr(), style: const TextStyle(color: Colors.white)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    (animalProvider.image != null)
                                        ? SizedBox(height: 40, width: 40, child: Image.file(animalProvider.image!))
                                        : (widget.isEdit && widget.animalModel!.image != null)
                                            ? SizedBox(
                                                height: 40, width: 40, child: customNetworkImage(context, widget.animalModel!.image!))
                                            : Text(LocaleKeys.no_images_elected.tr()),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                CustomButton(
                                  btnTxt: widget.isEdit ? "Update" : "Add",
                                  textWhiteColor: true,
                                  height: 40,
                                  onTap: () {
                                    if (widget.isEdit) {
                                      animalProvider.updateAnimal(animalNameController.text, givenNameController.text,
                                          speciesController.text, ageController.text, genusController.text, (bool status) {
                                        if (status) {
                                          animalNameController.clear();
                                          givenNameController.clear();
                                          speciesController.clear();
                                          ageController.clear();
                                          genusController.clear();
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pop();
                                        }
                                      }, widget.animalModel!.id! as int, widget.index);
                                    } else {
                                      animalProvider.addAnimal(animalNameController.text, givenNameController.text, speciesController.text,
                                          ageController.text, genusController.text, (bool status) {
                                        if (status) {
                                          animalNameController.clear();
                                          givenNameController.clear();
                                          speciesController.clear();
                                          ageController.clear();
                                          genusController.clear();
                                          Navigator.of(context).pop();
                                        }
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
