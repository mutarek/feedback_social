import 'package:als_frontend/provider/other_provider.dart';
import 'package:als_frontend/provider/page_provider.dart';
import 'package:als_frontend/screens/video/widget/new_video_widgets.dart';
import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

import '../../../provider/search_provider.dart';
import '../../../util/helper.dart';
import '../../../widgets/circle_button.dart';
import '../../../widgets/network_image.dart';
import '../../profile/profile_screen.dart';
import '../../search/search_screen.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const CustomText(
            title: "Feedback Pages",
            color: AppColors.primaryColorLight,
            fontWeight: FontWeight.bold,
            fontSize: 27),
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
      body: Consumer2<OtherProvider, PageProvider>(
          builder: (context, otherProvider, pageProvider, child) {
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
                    style: TextStyle(
                        fontSize: 10,
                        color: AppColors.primaryColorLight,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: AppColors.primaryColorLight)),
                    child: TextField(
                      decoration: InputDecoration(
                          fillColor: AppColors.columbiaBlue,
                          border: InputBorder.none,
                          labelText: "Your Page Name",
                          labelStyle:
                              TextStyle(color: AppColors.primaryColorLight)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    title:
                        "Select A Best Page Category that describe your page.",
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
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: AppColors.primaryColorLight)),
                    child: ListTile(
                      onTap: () {},
                      title: const Text(
                        "Select Category",
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
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: AppColors.primaryColorLight)),
                    child: TextField(
                      decoration: InputDecoration(
                          fillColor: AppColors.columbiaBlue,
                          border: InputBorder.none,
                          labelText: "Enter Bio",
                          labelStyle:
                              TextStyle(color: AppColors.primaryColorLight)),
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
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: AppColors.primaryColorLight)),
                    child: TextField(
                      maxLines: 4,
                      decoration: InputDecoration(
                          fillColor: AppColors.columbiaBlue,
                          border: InputBorder.none,
                          labelText: "Enter Description",
                          labelStyle:
                              TextStyle(color: AppColors.primaryColorLight)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
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
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
