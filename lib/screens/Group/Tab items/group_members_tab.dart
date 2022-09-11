import 'package:als_frontend/const/palette.dart';
import 'package:als_frontend/provider/provider.dart';
import 'package:als_frontend/screens/profile/other%20user/public_profile_details_screen.dart';
import 'package:als_frontend/screens/profile/user/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class GroupMembersTab extends StatefulWidget {
  const GroupMembersTab({
    Key? key,
  }) : super(key: key);

  @override
  State<GroupMembersTab> createState() => _GroupMembersTabState();
}

class _GroupMembersTabState extends State<GroupMembersTab> {
  @override
  void initState() {
    final value = Provider.of<GroupMembersProvider>(context, listen: false);
    value.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Consumer2<GroupMembersProvider, PublicProfileDetailsProvider>(
        builder: (context, provider, publicProfileProvider, child) {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: provider.members!.length,
        itemBuilder: (context, index) {
          return (provider.members == null)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : InkWell(
                  onTap: () {
                    if (provider.userId == provider.members![index].member.id) {
                      Get.to(() => const ProfileScreen());
                    } else {
                      publicProfileProvider.id =
                          provider.members![index].member.id;
                      Get.to(() => const PublicProfileDetailsScreen());
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.03, vertical: height * 0.01),
                    child: Container(
                      height: height * 0.09,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 0.03, vertical: height * 0.01),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 24,
                                    backgroundColor: Palette.notificationColor,
                                    child: CircleAvatar(
                                      radius: 22,
                                      backgroundImage: NetworkImage(provider
                                          .members![index].member.profileImage),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: height * 0.007,
                                        left: width * 0.03),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          provider
                                              .members![index].member.fullName,
                                          style: GoogleFonts.lato(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          provider.members![index].memberStatus,
                                          style: GoogleFonts.lato(
                                            fontSize: 12,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
        },
      );
    });
  }
}
