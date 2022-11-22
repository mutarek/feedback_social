import 'package:als_frontend/provider/page_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class likedPageSuggestedPage extends StatefulWidget {
  const likedPageSuggestedPage({Key? key}) : super(key: key);

  @override
  State<likedPageSuggestedPage> createState() => _likedPageSuggestedPageState();
}

class _likedPageSuggestedPageState extends State<likedPageSuggestedPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<PageProvider>(context, listen: false).initializeAuthorPageLists();
  }
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: height * 0.06, left: 10, right: 10),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back_ios)),
                SizedBox(
                  width: width * 0.26,
                ),
                const Text(
                  "Pages",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: height * 0.035,
                  width: width * 0.24,
                  decoration: BoxDecoration(
                      color: const Color(0xff090D2A), borderRadius: BorderRadius.circular(4)),
                  child: const Center(
                      child: Text(
                        "My page",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                SizedBox(
                  width: width * 0.03,
                ),
                Container(
                  height: height * 0.035,
                  width: width * 0.24,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 1)),
                  child: const Center(child: Text("Discover")),
                )
              ],
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: const [
                  Text(
                    "My pages",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      "See all",
                      style: TextStyle(fontSize: 10, color: Colors.black54),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: SizedBox(
                height: height * 0.26,
                child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 150,
                      childAspectRatio: 2.7,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: 6,
                    itemBuilder: (BuildContext ctx, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.black12,
                          ),
                          SizedBox(
                            width: width * 0.01,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: height * 0.01,
                              ),
                              const Text(
                                "Page name",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              const Text(
                                "5908 likes",
                                style: TextStyle(color: Colors.black26, fontSize: 10),
                              ),
                            ],
                          )
                        ],
                      );
                    }),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: const [
                  Text(
                    "Page you liked",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      "See all",
                      style: TextStyle(fontSize: 10, color: Colors.black54),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.26,
              child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        leading: const CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.black12,
                        ),
                        trailing: Container(
                          height: height*0.027,
                          width: width*0.15,
                          decoration: BoxDecoration(
                              color: const Color(0xff090D2A),
                              borderRadius: BorderRadius.circular(4)
                          ),
                          child: const Center(child: Text("Follow",style: TextStyle(color:Colors.white),)),
                        ),
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: height * 0.01,
                            ),
                            const Text(
                              "Page name",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            const Text(
                              "5908 likes",
                              style: TextStyle(color: Colors.black26, fontSize: 10),
                            ),
                          ],
                        ));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
