import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FindPage extends StatefulWidget {
  const FindPage({Key? key}) : super(key: key);

  @override
  State<FindPage> createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(title: "Find Page", color: AppColors.primaryColorLight, fontWeight: FontWeight.bold, fontSize: 24),
        backgroundColor: Colors.white,
        elevation: 0.3,
        centerTitle: true,
        leading: const BackButton(
          color: Colors.black, // <-- SEE HERE
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
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
                      decoration:
                          InputDecoration(border: InputBorder.none, hintText: "Search..", hintStyle: TextStyle(color: Colors.black)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2),
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: AppColors.primaryColorLight),
                      height: 38,
                      width: 71,
                      child: Center(
                        child: Text('Search', style: GoogleFonts.roboto(fontWeight: FontWeight.w300, fontSize: 12, color: Colors.white)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (_, index) {
                  return Card(
                    color: const Color(0xffFAFAFA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      leading: Container(
                          height: 36, width: 36, color: const Color(0xffFFFFFF), child: const Icon(Icons.share_location_rounded, size: 29)),
                      title: Text('News 74', style: GoogleFonts.roboto(fontWeight: FontWeight.w700, fontSize: 15, color: Colors.black)),
                      trailing: PopupMenuButton(
                        itemBuilder: (context) => [
                          // PopupMenuItem 1
                          PopupMenuItem(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Icon(
                                      Icons.thumb_up,
                                      size: 15,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      "Like",
                                      style:
                                          GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 12, color: AppColors.primaryColorLight),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    // SvgPicture.asset("assets/svg/add.svg",height: 10,width:20,),
                                    const Icon(
                                      Icons.copy,
                                      size: 15,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      "Copy Link",
                                      style:
                                          GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 12, color: AppColors.primaryColorLight),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // PopupMenuItem 2
                        ],
                        offset: const Offset(0, 58),
                        color: Colors.white,
                        elevation: 4,
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                        child: Container(
                          height: 24,
                          width: 30,
                          color: const Color(0x00e4e6eb),
                          child: const Icon(Icons.more_horiz),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
