import 'package:als_frontend/old_code/provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../const/palette.dart';

import '../screens.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  int value = 1;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Palette.scaffold,
      body: Consumer5<SearchProvider, PublicProfileDetailsProvider, GroupDetailsProvider, AuthorPageDetailsProvider,
              UserNewsfeedPostProvider>(
          builder:
              (context, provider, publicDetailsProvider, groupDetailsProvider, authorPageDetailsProvider, userNewsfeedPostProvider, child) {
        return SafeArea(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Flexible(
                          child: Container(
                            height: height * 0.055,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5))),
                            child: TextFormField(
                                controller: searchController,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  hintText: "search",
                                  hintStyle: GoogleFonts.lato(),
                                  border: InputBorder.none,
                                  fillColor: Colors.white24,
                                  labelStyle: const TextStyle(color: Colors.black),
                                  filled: true,
                                )),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.055,
                          width: width * 0.18,
                          child: ElevatedButton(
                              onPressed: () {
                                provider.getSearchResult(searchController.text);
                                setState(() {
                                  value = 1;
                                });
                              },
                              child: const Icon(Icons.search)),
                        ),
                      ],
                    ),
                  ),
                  (provider.searchData == null)
                      ? Container()
                      : (provider.loading == true)
                          ? const CircularProgressIndicator()
                          : Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          value = 1;
                                        });
                                      },
                                      child: Text(
                                        "People",
                                        style: TextStyle(color: (value == 1) ? Colors.white : Colors.black),
                                      ),
                                      style: ButtonStyle(
                                        backgroundColor: (value == 1)
                                            ? MaterialStateProperty.all<Color>(Palette.primary)
                                            : MaterialStateProperty.all<Color>(Colors.white),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          value = 2;
                                        });
                                      },
                                      child: Text(
                                        "Groups",
                                        style: TextStyle(color: (value == 2) ? Colors.white : Colors.black),
                                      ),
                                      style: ButtonStyle(
                                        backgroundColor: (value == 2)
                                            ? MaterialStateProperty.all<Color>(Palette.primary)
                                            : MaterialStateProperty.all<Color>(Colors.white),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          value = 3;
                                        });
                                      },
                                      child: Text(
                                        "Pages",
                                        style: TextStyle(color: (value == 3) ? Colors.white : Colors.black),
                                      ),
                                      style: ButtonStyle(
                                        backgroundColor: (value == 3)
                                            ? MaterialStateProperty.all<Color>(Palette.primary)
                                            : MaterialStateProperty.all<Color>(Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                (value == 1)
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: provider.searchData['people'].length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: height * 0.06,
                                              width: width * 0.5,
                                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                                              child: InkWell(
                                                onTap: () {
                                                  if (provider.userId == provider.searchData['people'][index]["id"]) {
                                                    Get.to(() => const ProfileScreen());
                                                  } else {
                                                    publicDetailsProvider.id = provider.searchData['people'][index]["id"];
                                                    userNewsfeedPostProvider.id = provider.searchData['people'][index]["id"];
                                                    Get.to(() => const PublicProfileDetailsScreen());
                                                  }
                                                },
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(5.0),
                                                      child: CircleAvatar(
                                                        backgroundImage:
                                                            NetworkImage(provider.searchData['people'][index]["profile_image"]),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: width * 0.006,
                                                    ),
                                                    Text(
                                                        "${provider.searchData['people'][index]["first_name"]} ${provider.searchData['people'][index]["last_name"]}",
                                                        style: GoogleFonts.lato(fontWeight: FontWeight.bold))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    : (value == 2)
                                        ? (provider.searchData['groups'] == null)
                                            ? const Center(
                                                child: Text("No search result found"),
                                              )
                                            : ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: provider.searchData['groups'].length,
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
                                                          if (provider.searchData['groups'][index]["is_author"] == false) {
                                                            groupDetailsProvider.groupIndex = provider.searchData['groups'][index]["id"];
                                                            Get.to(const PublicGroupView());
                                                          } else {
                                                            groupDetailsProvider.groupIndex = provider.searchData['groups'][index]["id"];
                                                            Get.to(const UserGroupView());
                                                          }
                                                        },
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(5.0),
                                                          child: Row(
                                                            children: [
                                                              CircleAvatar(
                                                                backgroundImage:
                                                                    NetworkImage(provider.searchData['groups'][index]["cover_photo"]),
                                                              ),
                                                              SizedBox(width: width * 0.006),
                                                              Column(
                                                                children: [
                                                                  Text("${provider.searchData['groups'][index]["name"]}",
                                                                      style: GoogleFonts.lato(fontWeight: FontWeight.bold)),
                                                                  Text("${provider.searchData['groups'][index]["category"]}"),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              )
                                        : (provider.searchData['pages'] == null)
                                            ? const Center(
                                                child: Text("No search result found"),
                                              )
                                            : ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: provider.searchData['pages'].length,
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
                                                          if (provider.searchData['pages'][index]["is_author"] == false) {
                                                            authorPageDetailsProvider.pageIndex = provider.searchData['pages'][index]["id"];

                                                            Get.to(const AdminPage());
                                                          } else {
                                                            authorPageDetailsProvider.pageIndex = provider.searchData['pages'][index]["id"];

                                                            Get.to(const UserGroupView());
                                                          }
                                                        },
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.all(5.0),
                                                              child: CircleAvatar(
                                                                backgroundImage:
                                                                    NetworkImage("${provider.searchData['pages'][index]["avatar"]}"),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: width * 0.006,
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.all(5.0),
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Text(
                                                                    "${provider.searchData['pages'][index]["name"]}",
                                                                    style: GoogleFonts.lato(fontWeight: FontWeight.bold),
                                                                  ),
                                                                  Text("${provider.searchData['pages'][index]["category"]}"),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              )
                              ],
                            )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
