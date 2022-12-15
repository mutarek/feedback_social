import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/provider/search_provider.dart';
import 'package:als_frontend/screens/group/public_group_screen.dart';
import 'package:als_frontend/screens/group/user_group_screen.dart';
import 'package:als_frontend/screens/page/public_page_screen.dart';
import 'package:als_frontend/screens/page/user_page_screen.dart';
import 'package:als_frontend/screens/profile/profile_screen.dart';
import 'package:als_frontend/screens/profile/public_profile_screen.dart';
import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/palette.dart';
import 'package:als_frontend/widgets/custom_text_field.dart';
import 'package:als_frontend/widgets/network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Palette.scaffold,
      body: Consumer<SearchProvider>(
        builder: (context, searchProvider, child) => SafeArea(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Column(
              children: [
                const SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(width: width * 0.02),
                    Expanded(
                      child: CustomTextField(
                        hintText: LocaleKeys.search.tr(),
                        controller: searchController,
                        inputType: TextInputType.text,
                        autoFocus: true,
                        inputAction: TextInputAction.done,
                        fillColor: Colors.white,
                        borderRadius: 10,
                        verticalSize: 13,
                      ),
                    ),
                    SizedBox(width: width * 0.02),
                    Container(
                      height: height * 0.062,
                      width: width * 0.12,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.blue), color: Colors.white70),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: height * 0.001),
                        child: IconButton(
                            color: Colors.lightBlue,
                            splashColor: Colors.green,
                            onPressed: () {
                              if (searchController.text.isNotEmpty) {
                                searchProvider.searchQuery(searchController.text);
                                FocusScope.of(context).unfocus();
                              } else {
                                Fluttertoast.showToast(msg: LocaleKeys.please_Write_somethings.tr());
                              }
                            },
                            icon: const Icon(FontAwesomeIcons.magnifyingGlass, size: 20)),
                      ),
                    ),
                    SizedBox(width: width * 0.02),
                  ],
                ),
                const SizedBox(height: 10),
                searchProvider.isFirstTime
                    ? const SizedBox.shrink()
                    : (searchProvider.isLoading == true)
                        ? const CircularProgressIndicator()
                        : Expanded(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        searchProvider.changeValue(1);
                                      },
                                      style: ButtonStyle(
                                          backgroundColor: (searchProvider.value == 1)
                                              ? MaterialStateProperty.all<Color>(Palette.primary)
                                              : MaterialStateProperty.all<Color>(Colors.white)),
                                      child: Text(LocaleKeys.people.tr(),
                                          style: TextStyle(color: (searchProvider.value == 1) ? Colors.white : Colors.black)),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        searchProvider.changeValue(2);
                                      },
                                      style: ButtonStyle(
                                          backgroundColor: (searchProvider.value == 2)
                                              ? MaterialStateProperty.all<Color>(Palette.primary)
                                              : MaterialStateProperty.all<Color>(Colors.white)),
                                      child: Text(LocaleKeys.group.tr(),
                                          style: TextStyle(color: (searchProvider.value == 2) ? Colors.white : Colors.black)),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        searchProvider.changeValue(3);
                                      },
                                      style: ButtonStyle(
                                          backgroundColor: (searchProvider.value == 3)
                                              ? MaterialStateProperty.all<Color>(Palette.primary)
                                              : MaterialStateProperty.all<Color>(Colors.white)),
                                      child:
                                          Text(LocaleKeys.pages.tr(), style: TextStyle(color: (searchProvider.value == 3) ? Colors.white : Colors.black)),
                                    ),
                                  ],
                                ),
                                (searchProvider.value == 1)
                                    ? Expanded(
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: searchProvider.searchModel.people!.length,
                                          physics: const BouncingScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Container(
                                                height: height * 0.06,
                                                width: width * 0.5,
                                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                                                child: InkWell(
                                                  onTap: () {
                                                    if (Provider.of<AuthProvider>(context, listen: false).userID ==
                                                        searchProvider.searchModel.people![index].id!.toString()) {
                                                      Helper.toScreen( const ProfileScreen());
                                                    } else {
                                                      Helper.toScreen(
                                                      PublicProfileScreen(searchProvider.searchModel.people![index].id!.toString()));
                                                    }
                                                  },
                                                  child: Row(
                                                    children: [
                                                      const SizedBox(width: 4),
                                                      SizedBox(
                                                        width: 35,
                                                        height: 35,
                                                        child: ClipRRect(
                                                          borderRadius: BorderRadius.circular(100),
                                                          child: customNetworkImage2(
                                                              context, searchProvider.searchModel.people![index].profileImage!,
                                                              boxFit: BoxFit.cover),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 4),
                                                      Text(
                                                          "${searchProvider.searchModel.people![index].firstName} ${searchProvider.searchModel.people![index].lastName}",
                                                          style: GoogleFonts.lato(fontWeight: FontWeight.bold))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    : (searchProvider.value == 2)
                                        ? (searchProvider.searchModel.groups == null)
                                            ?  Center(child: Text(LocaleKeys.no_search_result_found.tr()))
                                            : Expanded(
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  physics: const BouncingScrollPhysics(),
                                                  itemCount: searchProvider.searchModel.groups!.length,
                                                  itemBuilder: (context, index) {
                                                    return Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Container(
                                                        height: height * 0.06,
                                                        width: width * 0.5,
                                                        decoration:
                                                            BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                                                        child: InkWell(
                                                          onTap: () {
                                                            if (searchProvider.searchModel.groups![index].isAuthor == false) {
                                                              Helper.toScreen( PublicGroupScreen(
                                                                  searchProvider.searchModel.groups![index].id.toString(),
                                                                  index: index));
                                                            } else {
                                                              Helper.toScreen( UserGroupScreen(
                                                                  searchProvider.searchModel.groups![index].id.toString(), index));
                                                            }
                                                          },
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(5.0),
                                                            child: Row(
                                                              children: [
                                                                SizedBox(
                                                                  width: 35,
                                                                  height: 35,
                                                                  child: ClipRRect(
                                                                    borderRadius: BorderRadius.circular(100),
                                                                    child: customNetworkImage2(
                                                                        context, searchProvider.searchModel.groups![index].coverPhoto!,
                                                                        boxFit: BoxFit.cover),
                                                                  ),
                                                                ),
                                                                SizedBox(width: width * 0.006),
                                                                Column(
                                                                  children: [
                                                                    Text(searchProvider.searchModel.groups![index].name!,
                                                                        style: GoogleFonts.lato(fontWeight: FontWeight.bold)),
                                                                    Text(searchProvider.searchModel.groups![index].category!),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              )
                                        : (searchProvider.searchModel.pages == null)
                                            ? Center(child: Text(LocaleKeys.no_search_result_found.tr()))
                                            : Expanded(
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  physics: const BouncingScrollPhysics(),
                                                  itemCount: searchProvider.searchModel.pages!.length,
                                                  itemBuilder: (context, index) {
                                                    return Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Container(
                                                        height: height * 0.06,
                                                        width: width * 0.5,
                                                        decoration:
                                                            BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                                                        child: InkWell(
                                                          onTap: () {
                                                            if (searchProvider.searchModel.pages![index].isAuthor == false) {
                                                              Helper.toScreen( PublicPageScreen(
                                                                  searchProvider.searchModel.pages![index].id.toString()));
                                                            } else {
                                                              Helper.toScreen( UserPageScreen(
                                                                  searchProvider.searchModel.pages![index].id.toString(), index));
                                                            }
                                                          },
                                                          child: Row(
                                                            children: [
                                                              const SizedBox(width: 4),
                                                              SizedBox(
                                                                width: 35,
                                                                height: 35,
                                                                child: ClipRRect(
                                                                  borderRadius: BorderRadius.circular(100),
                                                                  child: customNetworkImage2(
                                                                      context, searchProvider.searchModel.pages![index].coverPhoto!,
                                                                      boxFit: BoxFit.cover),
                                                                ),
                                                              ),
                                                              SizedBox(width: width * 0.006),
                                                              Padding(
                                                                padding: const EdgeInsets.all(5.0),
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text(
                                                                      searchProvider.searchModel.pages![index].name!,
                                                                      style: GoogleFonts.lato(fontWeight: FontWeight.bold),
                                                                    ),
                                                                    Text("${searchProvider.searchModel.pages![index].category}"),
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              )
                              ],
                            ),
                          )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
