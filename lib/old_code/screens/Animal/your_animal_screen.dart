import 'package:als_frontend/old_code/provider/provider.dart';
import 'package:als_frontend/old_code/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../const/palette.dart';

class YourAnimalScreen extends StatefulWidget {
  const YourAnimalScreen({Key? key}) : super(key: key);

  @override
  State<YourAnimalScreen> createState() => _YourAnimalScreenState();
}

class _YourAnimalScreenState extends State<YourAnimalScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    final value = Provider.of<OwnerAnimalProvider>(context, listen: false);
    value.getData();
    super.initState();
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
            Get.to(() => const NavScreen());
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
        child:
            Consumer3<OwnerAnimalProvider, AnimalSearchProvider, AddAnimalProvider>(builder: (context, provider, search, addAnimal, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Your ID: ${provider.code}",
                          style: GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        Row(
                          children: [
                            Container(
                              width: width * 0.4,
                              height: height * 0.05,
                              decoration:
                                  BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(13), color: Colors.white24),
                              child: Padding(
                                padding: EdgeInsets.only(left: width * 0.01, right: width * 0.01),
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  controller: searchController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      hintStyle: GoogleFonts.lato(),
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      hintText: "Search with code"),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.01,
                            ),
                            Container(
                              height: height * 0.05,
                              width: width * 0.1,
                              decoration:
                                  BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(), color: Colors.white70),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: height * 0.001),
                                child: IconButton(
                                    color: Colors.lightBlue,
                                    splashColor: Colors.green,
                                    onPressed: () {
                                      search.searchResult = [];
                                      search.code = searchController.text;
                                      if (searchController.text.isNotEmpty && searchController.text.length == 6) {
                                        Get.to(() => const AnimalSearchResult());
                                      } else {
                                        Fluttertoast.showToast(
                                          msg: "Write 6 digits code to search",
                                        );
                                      }
                                    },
                                    icon: const Icon(
                                      FontAwesomeIcons.magnifyingGlass,
                                      size: 25,
                                    )),
                              ),
                            )
                          ],
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
                                  "Total: ${provider.animals!.length}",
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 66, 40, 40)),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      Get.to(() => const AddAnimalScreen());
                                    },
                                    child: const Text("Add"))
                              ],
                            ),
                            Expanded(
                              child: (provider.animals!.isEmpty)
                                  ? const Center(
                                      child: Text("You have not added any animal yet"),
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: provider.animals!.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            addAnimal.animalID = provider.animals![index].id!as int;
                                            provider.animalIndex = index;
                                            Get.to(() => const AnimalDetails());
                                          },
                                          child: Card(
                                            child: ListTile(
                                              leading: CircleAvatar(
                                                backgroundImage: NetworkImage(provider.animals![index].image!),
                                              ),
                                              title: Column(
                                                children: [
                                                  Text(
                                                    provider.animals![index].givenName!,
                                                    style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w600, color: Colors.teal),
                                                  ),
                                                  Text(
                                                    provider.animals![index].animalName!,
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w600,
                                                        color: Color.fromARGB(255, 77, 116, 112)),
                                                  ),
                                                ],
                                              ),
                                              trailing: Text(
                                                provider.animals![index].gender!,
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
          );
        }),
      ),
    );
  }
}
