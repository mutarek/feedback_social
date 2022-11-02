import 'package:als_frontend/data/model/response/owner_animal_model.dart';
import 'package:als_frontend/provider/animal_provider.dart';
import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/screens/animal/animal_details_screen.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:als_frontend/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class SearchAnimalScreen extends StatefulWidget {
  final String code;

  SearchAnimalScreen(this.code, {Key? key}) : super(key: key);

  @override
  State<SearchAnimalScreen> createState() => _SearchAnimalScreenState();
}

class _SearchAnimalScreenState extends State<SearchAnimalScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchController = TextEditingController();
    searchController.text = widget.code;
    Provider.of<AnimalProvider>(context, listen: false).searchAnimal(widget.code);
  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Consumer<AnimalProvider>(
            builder: (context, animalProvider, child) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    children: [
                      Row(
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
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(), color: Colors.white70),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: height * 0.001),
                              child: IconButton(
                                  color: Colors.lightBlue,
                                  splashColor: Colors.green,
                                  onPressed: () {
                                    if (searchController.text.isNotEmpty && searchController.text.length == 6) {
                                      animalProvider.searchAnimal(searchController.text);
                                      searchController.clear();
                                    } else {
                                      Fluttertoast.showToast(msg: "Write 6 digits code to search");
                                    }
                                  },
                                  icon: const Icon(FontAwesomeIcons.magnifyingGlass, size: 20)),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      animalProvider.isLoadingSearch
                          ? Center(child: CircularProgressIndicator())
                          : Expanded(
                              child: animalProvider.searchAnimalLists.isNotEmpty
                                  ? ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      itemCount: animalProvider.searchAnimalLists.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            OnwerAnimalModel o = OnwerAnimalModel(
                                              image: animalProvider.searchAnimalLists[index].image,
                                              age: animalProvider.searchAnimalLists[index].age,
                                              animalName: animalProvider.searchAnimalLists[index].animalName,
                                              animalOwner: animalProvider.searchAnimalLists[index].animalOwner,
                                              gender: animalProvider.searchAnimalLists[index].gender,
                                              genus: animalProvider.searchAnimalLists[index].genus,
                                              givenName: animalProvider.searchAnimalLists[index].givenName,
                                              id: animalProvider.searchAnimalLists[index].id,
                                              ownerProfilePicture: animalProvider.searchAnimalLists[index].ownerProfilePicture,
                                              species: animalProvider.searchAnimalLists[index].species,
                                            );
                                            String searchCode = '';
                                            if (searchController.text.isEmpty) {
                                              searchCode = widget.code;
                                            } else {
                                              searchCode = searchController.text;
                                            }
                                            bool isEdit =
                                                Provider.of<AuthProvider>(context, listen: false).userCode == searchCode ? true : false;

                                            Get.to(() => AnimalDetailsScreen(o, index, isEditDelete: isEdit));
                                          },
                                          child: Card(
                                            child: ListTile(
                                              leading: CircleAvatar(
                                                backgroundImage: NetworkImage(animalProvider.searchAnimalLists[index].image!),
                                              ),
                                              title: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  CustomText(
                                                      title: animalProvider.searchAnimalLists[index].givenName!,
                                                      textStyle: latoStyle600SemiBold.copyWith(color: Colors.teal, fontSize: 15)),
                                                  CustomText(
                                                      title: animalProvider.searchAnimalLists[index].animalName!,
                                                      textStyle: latoStyle400Regular.copyWith(
                                                          color: const Color.fromARGB(255, 77, 116, 112), fontSize: 15)),
                                                ],
                                              ),
                                              trailing: CustomText(
                                                  title: animalProvider.searchAnimalLists[index].gender!,
                                                  textStyle: latoStyle400Regular.copyWith(
                                                      color: const Color.fromARGB(255, 1, 78, 70), fontSize: 15)),
                                            ),
                                          ),
                                        );
                                      })
                                  : Center(child: CustomText(title: 'No Data Found',color: Colors.black,fontSize: 18)),
                            )
                    ],
                  ),
                )),
      ),
    );
  }
}
