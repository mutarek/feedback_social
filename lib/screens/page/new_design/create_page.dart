import 'package:als_frontend/data/model/response/category_model.dart';
import 'package:als_frontend/provider/other_provider.dart';
import 'package:als_frontend/provider/page_provider.dart';
import 'package:als_frontend/screens/video/widget/new_video_widgets.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/palette.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:provider/provider.dart';

import 'contact_selection_page.dart';

class CreatePageScreen extends StatefulWidget {
  const CreatePageScreen({Key? key}) : super(key: key);

  @override
  State<CreatePageScreen> createState() => _CreatePageScreenState();
}

class _CreatePageScreenState extends State<CreatePageScreen> {
  @override
  void initState() {
    Provider.of<PageProvider>(context, listen: false).initializeCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                    title: "Want to Choose a name for your page?",
                    fontSize: 21,
                    color: AppColors.primaryColorLight,
                    maxLines: 2,
                  ),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Choose a unique name for your business, organization,shop or name that helps to explore your business .",
                    style: TextStyle(fontSize: 10, color: AppColors.primaryColorLight, fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15), border: Border.all(color: AppColors.primaryColorLight)),
                    child: TextField(
                      decoration: InputDecoration(
                          fillColor: AppColors.columbiaBlue,
                          border: InputBorder.none,
                          labelText: "Your Page Name",
                          labelStyle: TextStyle(color: AppColors.primaryColorLight)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    title: "Select A Best Page Category that describe your page.",
                    fontSize: 22,
                    color: AppColors.primaryColorLight,
                    maxLines: 2,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                      decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15), border: Border.all(color: AppColors.primaryColorLight)),
                    //decoration: BoxDecoration(color: const Color(0xFF656B87), borderRadius: BorderRadius.circular(15.0)),
                    child: DropdownButton<CategoryModel>(
                      dropdownColor: Colors.white,
                      value: pageProvider.categoryValue,
                      isExpanded: true,
                      underline: const SizedBox.shrink(),
                      icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.primaryColorLight),
                      items: pageProvider.items
                          .map((item) => DropdownMenuItem<CategoryModel>(
                          value: item,
                          child: Container(
                              padding: const EdgeInsets.only(left: 10),
                              child: CustomText(
                                  title: item.name, textStyle: latoStyle500Medium.copyWith(fontSize: 22, color: AppColors.primaryColorLight)))))
                          .toList(),
                      onChanged: (item) {
                        pageProvider.changeGroupCategory(item!);
                      },
                    ),
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 10),
                //   child: Container(
                //     padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                //     decoration:
                //         BoxDecoration(borderRadius: BorderRadius.circular(15), border: Border.all(color: AppColors.primaryColorLight)),
                //     child: ListTile(
                //       onTap: () {},
                //       title: const Text(
                //         "Select Category",
                //         style: TextStyle(color: AppColors.primaryColorLight),
                //       ),
                //       trailing: const CircleAvatar(
                //         backgroundColor: AppColors.primaryColorLight,
                //         child: Center(
                //           child: Icon(
                //             Icons.arrow_drop_down,
                //             color: Colors.white,
                //             size: 35,
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                const SizedBox(
                  height: 10,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    title: "Tell a little bit about your page .",
                    fontSize: 22,
                    color: AppColors.primaryColorLight,
                    maxLines: 2,
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
                      decoration: InputDecoration(
                          fillColor: AppColors.columbiaBlue,
                          border: InputBorder.none,
                          labelText: "Enter Bio",
                          labelStyle: TextStyle(color: AppColors.primaryColorLight)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    title: "Describe Your Page.",
                    fontSize: 22,
                    color: AppColors.primaryColorLight,
                    maxLines: 1,
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
                          labelText: "Enter Description",
                          labelStyle: TextStyle(color: AppColors.primaryColorLight)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: (){
                    Helper.toScreen(ContactSelectionPage());
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
