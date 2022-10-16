import 'package:als_frontend/old_code/const/palette.dart';
import 'package:als_frontend/provider/animal_provider.dart';
import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/provider/profile_provider.dart';
import 'package:als_frontend/screens/animal/add_animal_screen.dart';
import 'package:als_frontend/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
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
            Get.back();
          },
          child: const Text(
            "FeedBack",
            style: TextStyle(color: Palette.primary, fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: -1.2),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Consumer2<AuthProvider, AnimalProvider>(
          builder: (context, authProvider, animalProvider, child) => authProvider.isLoading
              ? Center(child: CircularProgressIndicator())
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
                                "Your ID: ${authProvider.userCode}",
                                style: GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                              ),
                              SizedBox(width: width * 0.02),
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: CustomTextField(
                                        hintText: 'Search with code',
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
                                              // search.searchResult = [];
                                              // search.code = searchController.text;
                                              // if (searchController.text.isNotEmpty && searchController.text.length == 6) {
                                              //   Get.to(() => const AnimalSearchResult());
                                              // } else {
                                              //   Fluttertoast.showToast(
                                              //     msg: "Write 6 digits code to search",
                                              //   );
                                              // }
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
                                gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
                                  const Color.fromARGB(255, 42, 26, 26).withOpacity(0.1),
                                  const Color.fromARGB(255, 86, 154, 213).withOpacity(0.05),
                                ], stops: const [
                                  0.1,
                                  1,
                                ]),
                                borderRadius: BorderRadius.circular(13)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Center(
                                      child: Text(
                                        "Your added animal",
                                        style:
                                        GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 66, 40, 40)),
                                      )),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Total: ${animalProvider.animals.length}",
                                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 66, 40, 40)),
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            animalProvider.clearImage();
                                            Get.to(() =>  AddAnimalScreen());
                                          },
                                          child: const Text("Add"))
                                    ],
                                  ),
                                  Expanded(
                                    child: (animalProvider.animals.isEmpty)
                                        ? const Center(
                                      child: Text("You have not added any animal yet"),
                                    )
                                        : ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: animalProvider.animals.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              // addAnimal.animalID = provider.animals![index].id;
                                              // provider.animalIndex = index;
                                              // Get.to(() => const AnimalDetails());
                                            },
                                            child: Card(
                                              child: ListTile(
                                                leading: CircleAvatar(
                                                  backgroundImage: NetworkImage(animalProvider.animals[index].image!),
                                                ),
                                                title: Column(
                                                  children: [
                                                    Text(
                                                      animalProvider.animals[index].givenName!,
                                                      style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w600, color: Colors.teal),
                                                    ),
                                                    Text(
                                                      animalProvider.animals[index].animalName!,
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w600,
                                                          color: Color.fromARGB(255, 77, 116, 112)),
                                                    ),
                                                  ],
                                                ),
                                                trailing: Text(
                                                  animalProvider.animals[index].gender!,
                                                  style: const TextStyle(
                                                      fontSize: 19, fontWeight: FontWeight.w600, color: Color.fromARGB(255, 1, 78, 70)),
                                                ),
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
