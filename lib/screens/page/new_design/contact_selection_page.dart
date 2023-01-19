import 'package:als_frontend/data/model/response/category_model.dart';
import 'package:als_frontend/provider/page_provider.dart';
import 'package:als_frontend/screens/page/new_design/page_profile_cover.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/other_provider.dart';
import '../../../util/theme/app_colors.dart';

class ContactSelectionPage extends StatefulWidget {
  const ContactSelectionPage({Key? key}) : super(key: key);

  @override
  State<ContactSelectionPage> createState() => _ContactSelectionPageState();
}

class _ContactSelectionPageState extends State<ContactSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const CustomText(title: "Feedback Pages", color: AppColors.primaryColorLight, fontWeight: FontWeight.bold, fontSize: 27),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: const [
          CircleAvatar(
            backgroundColor: AppColors.primaryColorLight,
            child: Center(
              child: Icon(
                Icons.settings,
                size: 25.0,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
        ],
      ),
      body: Consumer2<OtherProvider, PageProvider>(builder: (context, otherProvider, pageProvider, child) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    title: "Contact Selection",
                    fontSize: 22,
                    color: AppColors.primaryColorLight,
                    fontWeight: FontWeight.w500,
                    maxLines: 1,
                  ),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Please enter your valid contact information so people can reach with you easily.",
                    style: TextStyle(fontSize: 10, color: AppColors.primaryColorLight, fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                    decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(11), border: Border.all(color: AppColors.primaryColorLight)),
                    child: TextField(
                      decoration: InputDecoration(
                          fillColor: AppColors.columbiaBlue,
                          border: InputBorder.none,
                          labelText: "Enter Contact Number",
                          labelStyle: TextStyle(color: AppColors.primaryColorLight)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                    decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(11), border: Border.all(color: AppColors.primaryColorLight)),
                    child: TextField(
                      decoration: InputDecoration(
                          fillColor: AppColors.columbiaBlue,
                          border: InputBorder.none,
                          labelText: "Enter Email",
                          labelStyle: TextStyle(color: AppColors.primaryColorLight)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                    decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(11), border: Border.all(color: AppColors.primaryColorLight)),
                    child: TextField(
                      decoration: InputDecoration(
                          fillColor: AppColors.columbiaBlue,
                          border: InputBorder.none,
                          labelText: "Enter Your Website Link",
                          labelStyle: TextStyle(color: AppColors.primaryColorLight)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    title: "Location Selection",
                    fontSize: 22,
                    color: AppColors.primaryColorLight,
                    fontWeight: FontWeight.w500,
                    maxLines: 1,
                  ),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Please enter your valid location place so people can visit your place.",
                    style: TextStyle(fontSize: 10, color: AppColors.primaryColorLight, fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: InkWell(
                    onTap: (){

                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(15), border: Border.all(color: AppColors.primaryColorLight)),
                      child: ListTile(
                        onTap: () {
                          pageProvider.pickupCountry(context);
                        },
                        title:  Text(
                          pageProvider.countryName,
                          style: TextStyle(color: AppColors.primaryColorLight),
                        ),
                        trailing: const CircleAvatar(
                          backgroundColor: AppColors.primaryColorLight,
                          child: Center(
                            child: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                              size: 35,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                    decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15), border: Border.all(color: AppColors.primaryColorLight)),
                    child: TextField(
                      maxLines: 4,
                      decoration: InputDecoration(
                          fillColor: AppColors.columbiaBlue,
                          border: InputBorder.none,
                          labelText: "Enter Your Address",
                          labelStyle: TextStyle(color: AppColors.primaryColorLight)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: (){
                    Helper.toScreen(PageProfileCover());
                  },
                  child: Container(
                    padding: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: AppColors.primaryColorLight,
                    ),
                    child: const Center(
                      child: CustomText(
                        title: "Next Page",
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
