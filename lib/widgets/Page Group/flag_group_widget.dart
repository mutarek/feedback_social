import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../const/palette.dart';
import '../../provider/provider.dart';
import '../../screens/screens.dart';
import '../widgets.dart';

class FlagGroupWidget extends StatelessWidget {
  const FlagGroupWidget({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(top: height * 0.02, left: width * 0.03),
          child: Column(
            children: [
              SizedBox(
                height: height * 0.15,
                width: width,
                child: Row(
                  children: [
                    Consumer4<AuthorGroupProvider, GroupDetailsProvider,
                            CreateGroupPost, GroupPostProvider>(
                        builder: (context, provider, groupDetailsProvider,
                            createGroupPost, groupPostProvider, child) {
                      return (provider.groups!.isEmpty)
                          ? const Center(
                              child: Text(
                              "You have no Group",
                              style: TextStyle(fontSize: 16),
                            ))
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: provider.groups!.length,
                              itemBuilder: (context, index2) {
                                return InkWell(
                                  onTap: () {
                                    groupPostProvider.id = provider.groups![index2].id;
                                    groupDetailsProvider.groupIndex =
                                        provider.groups![index2].id;
                                    createGroupPost.groupId =
                                        provider.groups![index2].id;
                                    
                                    Get.to(const UserGroupView());
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          radius: height * 0.04,
                                          backgroundColor:
                                              Palette.notificationColor,
                                          child: CircleAvatar(
                                            radius: height * 0.0368,
                                            backgroundColor: Palette.scaffold,
                                            backgroundImage: NetworkImage(
                                                provider.groups![index2]
                                                    .coverPhoto),
                                          ),
                                        ),
                                        Text(
                                          provider.groups![index2].name,
                                          style: GoogleFonts.lato(
                                              fontSize: height * 0.02,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                    })
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Groups",
                  style: GoogleFonts.lato(
                      fontSize: height * 0.03, fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Get.to(const CreateGroup());
                  },
                  child: Container(
                      height: height * 0.037,
                      width: width * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: const LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          stops: [
                            0.1,
                            0.7,
                          ],
                          colors: [
                            Palette.primary,
                            Palette.notificationColor,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Palette.primary.withOpacity(0.4),
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: const Offset(
                                0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Center(
                          child: Text("Create ",
                              style: GoogleFonts.lato(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white)))),
                ),
              ),
              const Text(
                "Suggested Groups",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Consumer5<AllGroupProvider, GroupMembersProvider,
                      GroupDetailsProvider, GroupPostProvider, CreateGroupPost>(
                  builder: (context, provider, membersProvider,
                      groupDetailsProvider, groupPostProvider,
                      createGroupPost, child) {
                return Visibility(
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: provider.groups!.length,
                      itemBuilder: (context, index) {
                        return CustomPageGroupButton(
                            onTap: () {
                               groupPostProvider.id =
                                  provider.groups![index].id;
                              groupDetailsProvider.groupIndex =
                                  provider.groups![index].id;
                              createGroupPost.groupId =
                                  provider.groups![index].id;

                              Get.to(const PublicGroupView());
                            },
                            goToGroupOrPage: () {},
                            groupOrPageImage:
                                provider.groups![index].coverPhoto,
                            groupOrPageName: provider.groups![index].name,
                            groupOrPageLikes:
                                "${provider.groups![index].totalMember} Members");
                      }),
                  replacement: const CircularProgressIndicator(),
                );
              }),
            ],
          ),
        ));
  }
}
