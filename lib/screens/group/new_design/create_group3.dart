import 'package:als_frontend/provider/group_provider.dart';
import 'package:als_frontend/provider/other_provider.dart';
import 'package:als_frontend/provider/page_provider.dart';
import 'package:als_frontend/screens/group/new_design/create_group4.dart';
import 'package:als_frontend/screens/page/widget/page_app_bar.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_button.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CreateGroup3 extends StatefulWidget {
  const CreateGroup3({Key? key}) : super(key: key);

  @override
  State<CreateGroup3> createState() => _CreateGroup3State();
}

class _CreateGroup3State extends State<CreateGroup3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PageAppBar(title: 'Create Feedback Group'),
      body: Consumer3<OtherProvider, GroupProvider,PageProvider>(builder: (context, otherProvider, groupProvider,pageProvider, child) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                        title: "Invite friends to this group ", maxLines: 2, textStyle: robotoStyle500Medium.copyWith(fontSize: 17)),
                    SizedBox(
                        height: 400,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20, right: 20),
                                    child: Container(
                                      height: 48.0,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: AppColors.primaryColorLight),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: Row(
                                        children: [
                                          const Expanded(
                                            child: TextField(
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: "Search..",
                                                  hintStyle: TextStyle(color: Colors.black)),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(2),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(100), color: AppColors.primaryColorLight),
                                              height: 38,
                                              width: 71,
                                              child: Center(
                                                child: Text('Search',
                                                    style:
                                                    GoogleFonts.roboto(fontWeight: FontWeight.w300, fontSize: 12, color: Colors.white)),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                        itemCount: 10,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            leading: CircleAvatar(
                                              backgroundColor: index % 2 == 0 ? Colors.amber : Colors.teal,
                                            ),
                                            title: Text('Rafatul Islam',style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                color: AppColors.primaryColorLight),),
                                            trailing: SizedBox(
                                              height: 8,
                                              width: 8,
                                              child: Checkbox(
                                                activeColor: Colors.black,
                                                value: index % 2 == 0 ? true : false,
                                                onChanged: (value) {},
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    height: 25,
                                    width: 250,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(45), color: AppColors.primaryColorLight),
                                    child: Center(
                                      child: Text('Send invitations',
                                          style: GoogleFonts.roboto(fontWeight: FontWeight.w700, fontSize: 13, color: Colors.white)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
                const SizedBox(height: 300),
                CustomButton(
                    btnTxt: 'Next Page',
                    onTap: () {
                      // if (pageNameController.text.isEmpty || pageBioController.text.isEmpty || pageDetailsController.text.isEmpty) {
                      //   showMessage(message: 'Please write all the information');
                      // } else if (pageBioController.text.length > 90) {
                      //   showMessage(message: 'please insert BIO at Most 90 characters');
                      // } else {
                      //   //Helper.toScreen(const CreatePageScreen2());
                      // }
                      Helper.toScreen(const CreateGroup4());
                    },
                    radius: 100,
                    height: 48),
              ],
            ),
          ),
        );
      }),
    );
  }
}
