import 'package:als_frontend/data/model/response/owner_animal_model.dart';
import 'package:als_frontend/old_code/const/palette.dart';
import 'package:als_frontend/provider/animal_provider.dart';
import 'package:als_frontend/screens/animal/add_animal_screen.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:als_frontend/widgets/network_image.dart';
import 'package:als_frontend/widgets/single_image_view.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class AnimalDetailsScreen extends StatelessWidget {
  final OnwerAnimalModel animalModel;
  final int index;
  final bool isEditDelete;

  const AnimalDetailsScreen(this.animalModel, this.index, {this.isEditDelete = false, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Palette.scaffold,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Palette.primary),
        title: CustomText(title: 'Animal Details', textStyle: latoStyle700Bold.copyWith(fontSize: 18)),
        elevation: 0,
      ),
      body: Consumer<AnimalProvider>(
          builder: (context, animalProvider, child) => ModalProgressHUD(
                inAsyncCall: animalProvider.isLoading,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    width: w,
                    decoration: const BoxDecoration(color: Colors.white),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        detailsWidget('Animal name: ', animalModel.animalName!),
                        const Divider(),
                        detailsWidget('Given name: ', animalModel.givenName!),
                        const Divider(),
                        detailsWidget('Gender: ', animalModel.gender!),
                        const Divider(),
                        detailsWidget('Genus: ', animalModel.genus!),
                        const Divider(),
                        detailsWidget('Species: ', animalModel.species!),
                        const Divider(),
                        detailsWidget('Age: ', animalModel.age!),
                        const Divider(),
                        isEditDelete
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
                                      onPressed: () {
                                        animalProvider.changeGenderStatus(animalModel.gender!);
                                        Get.to(() => AddEditAnimalScreen(isEdit: true, animalModel: animalModel, index: index));
                                      },
                                      child: const Text("Edit")),
                                  ElevatedButton(
                                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
                                      onPressed: () {
                                        animalProvider.deleteAnimal(animalModel.id as int, index, (bool status) {
                                          if (status) {
                                            Get.back();
                                          }
                                        });
                                      },
                                      child: const Text("Delete")),
                                ],
                              )
                            : const SizedBox.shrink(),
                        Container(
                            margin: const EdgeInsets.only(top: 30),
                            height: 400,
                            width: w,
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () {
                                Get.to(() => SingleImageView(imageURL: animalModel.image!));
                              },
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10), child: customNetworkImage(context, animalModel.image!)),
                            ))
                      ],
                    ),
                  ),
                ),
              )),
    );
  }

  Widget detailsWidget(String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(child: CustomText(title: title, textStyle: latoStyle400Regular.copyWith(fontSize: 16))),
        const SizedBox(width: 5),
        Expanded(
          child:
              CustomText(title: value, textStyle: latoStyle600SemiBold.copyWith(fontSize: 16, color: const Color.fromARGB(255, 0, 59, 30))),
        ),
      ],
    );
  }
}