import 'package:als_frontend/provider/animal_provider.dart';
import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/provider/profile_provider.dart';
import 'package:als_frontend/screens/animal/add_animal_screen.dart';
import 'package:als_frontend/screens/animal/animal_details_screen.dart';
import 'package:als_frontend/screens/animal/search_animal_screen.dart';
import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/palette.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:als_frontend/widgets/custom_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MyAnimalScreen extends StatefulWidget {
  const MyAnimalScreen({Key? key}) : super(key: key);

  @override
  State<MyAnimalScreen> createState() => _MyAnimalScreenState();
}

class _MyAnimalScreenState extends State<MyAnimalScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AnimalProvider>(context, listen: false).initializeOwnerAnimalList((bool status) {});
    Provider.of<ProfileProvider>(context, listen: false).initializeUserData();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Palette.scaffold,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Text(
            LocaleKeys.feedback.tr(),
            style: const TextStyle(color: Palette.primary, fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: -1.2),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Consumer2<AuthProvider, AnimalProvider>(
          builder: (context, authProvider, animalProvider, child) => authProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "${LocaleKeys.your_ID.tr()}: ${authProvider.userCode}",
                                style: GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                              ),
                              SizedBox(width: width * 0.02),
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: CustomTextField(
                                        hintText: LocaleKeys.search_with_code.tr(),
                                        controller: searchController,
                                        inputType: TextInputType.number,
                                        inputAction: TextInputAction.done,
                                        fillColor: Colors.white,
                                        borderRadius: 10,
                                      ),
                                    ),
                                    SizedBox(width: width * 0.02),
                                    Container(
                                      height: height * 0.05,
                                      width: width * 0.1,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12), border: Border.all(), color: Colors.white70),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: height * 0.001),
                                        child: IconButton(
                                            color: Colors.lightBlue,
                                            splashColor: Colors.green,
                                            onPressed: () {
                                              if (searchController.text.isNotEmpty && searchController.text.length == 6) {
                                                Helper.toScreen( SearchAnimalScreen(searchController.text));
                                                FocusScope.of(context).unfocus();
                                              } else {
                                                Fluttertoast.showToast(msg: LocaleKeys.write_6_digits_code_to_search.tr());
                                              }
                                            },
                                            icon: const Icon(FontAwesomeIcons.magnifyingGlass, size: 20)),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: height * 0.77,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(.1),
                                      blurRadius: 10.0,
                                      spreadRadius: 3.0,
                                      offset: const Offset(0.0, 0.0))
                                ],
                                borderRadius: BorderRadius.circular(13)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  CustomText(title: LocaleKeys.your_added_animal.tr(), textStyle: latoStyle700Bold.copyWith(fontSize: 18)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Total: ${animalProvider.animals.length}",
                                        style: const TextStyle(
                                            fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 66, 40, 40)),
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            animalProvider.clearImage();
                                            Helper.toScreen( const AddEditAnimalScreen());
                                          },
                                          child: Text(LocaleKeys.add.tr()))
                                    ],
                                  ),
                                  Expanded(
                                    child: (animalProvider.animals.isEmpty)
                                        ? Center(
                                            child: Text(LocaleKeys.you_have_not_added_any_animal_yet.tr()),
                                          )
                                        : ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: animalProvider.animals.length,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  Helper.toScreen( AnimalDetailsScreen(animalProvider.animals[index], index));
                                                },
                                                child: Card(
                                                  child: ListTile(
                                                    leading: CircleAvatar(
                                                      backgroundImage: NetworkImage(animalProvider.animals[index].image!),
                                                    ),
                                                    title: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        CustomText(
                                                            title: animalProvider.animals[index].givenName!,
                                                            textStyle: latoStyle600SemiBold.copyWith(color: Colors.teal, fontSize: 15)),
                                                        CustomText(
                                                            title: animalProvider.animals[index].animalName!,
                                                            textStyle: latoStyle400Regular.copyWith(
                                                                color: const Color.fromARGB(255, 77, 116, 112), fontSize: 15)),
                                                      ],
                                                    ),
                                                    trailing: CustomText(
                                                        title: animalProvider.animals[index].gender!,
                                                        textStyle: latoStyle400Regular.copyWith(
                                                            color: const Color.fromARGB(255, 1, 78, 70), fontSize: 15)),
                                                  ),
                                                ),
                                              );
                                            }),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
