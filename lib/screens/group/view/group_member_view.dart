import 'package:als_frontend/util/palette.dart';
import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/provider/group_provider.dart';
import 'package:als_frontend/screens/profile/profile_screen.dart';
import 'package:als_frontend/screens/profile/public_profile_screen.dart';
import 'package:als_frontend/widgets/network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class GroupMemberView extends StatelessWidget {
  const GroupMemberView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Consumer<GroupProvider>(
        builder: (context, provider, child) => ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: provider.groupMembersLists.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    if (Provider.of<AuthProvider>(context, listen: false).userID ==
                        provider.groupMembersLists[index].member.id.toString()) {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProfileScreen()));
                    } else {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => PublicProfileScreen(provider.groupMembersLists[index].member.id.toString())));
                    }
                  },

                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.01),
                    child: Container(
                      height: height * 0.09,
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(7)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.01),
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
                                    child:  circularImage(provider.groupMembersLists[index].member.profileImage,45,45),

                                    // CircleAvatar(
                                    //     radius: 22, backgroundImage: NetworkImage(provider.groupMembersLists[index].member.profileImage)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: height * 0.007, left: width * 0.03),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(provider.groupMembersLists[index].member.fullName,
                                            style: GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.bold)),
                                        Text(provider.groupMembersLists[index].memberStatus, style: GoogleFonts.lato(fontSize: 12))
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
            ));
  }
}
