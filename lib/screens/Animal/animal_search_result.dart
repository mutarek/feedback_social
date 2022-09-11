import 'package:als_frontend/provider/provider.dart';
import 'package:als_frontend/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AnimalSearchResult extends StatefulWidget {
  const AnimalSearchResult({Key? key}) : super(key: key);

  @override
  State<AnimalSearchResult> createState() => _AnimalSearchResultState();
}

class _AnimalSearchResultState extends State<AnimalSearchResult> {
  @override
  void initState() {
    final value = Provider.of<AnimalSearchProvider>(context, listen: false);
    value.getResultData();
    // final value2 =
    //     Provider.of<PublicProfileDetailsProvider>(context, listen: false);
    // value2.getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Center(
          child: Text(
            "Search result",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Consumer2<AnimalSearchProvider, PublicProfileDetailsProvider>(
          builder: (context, provider, publicProfileProvider, child) {
        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.01, vertical: height * 0.01),
          child: (provider.loading == true)
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: provider.searchResult!.length,
                  itemBuilder: ((context, index) {
                    return InkWell(
                      onTap: () {
                        publicProfileProvider.id =
                            provider.searchResult![index].owner;
                        Get.to(() => const PublicProfileDetailsScreen());
                       
                      },
                      child: Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              provider.searchResult![index].image,
                            ),
                          ),
                          title: Column(
                            children: [
                              Text(
                                provider.searchResult![index].givenName,
                                style: const TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.teal),
                              ),
                              Text(
                                provider.searchResult![index].animalName,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromARGB(255, 77, 116, 112)),
                              ),
                            ],
                          ),
                          trailing: Text(
                            provider.searchResult![index].gender,
                            style: const TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 1, 78, 70)),
                          ),
                        ),
                      ),
                    );
                  })),
        );
      }),
    );
  }
}
