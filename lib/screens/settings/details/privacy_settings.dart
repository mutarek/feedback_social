
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../const/palette.dart';
import '../../../provider/provider.dart';
import '../../../widgets/card container/snackbar_message.dart';
import '../../../widgets/settings widgets/privacy_safety_widget.dart';
import '../../../widgets/settings widgets/setteings_widget.dart';

class PrivacySettings extends StatefulWidget {
  const PrivacySettings({Key? key}) : super(key: key);

  @override
  State<PrivacySettings> createState() => _PrivacySettingsState();
}

class _PrivacySettingsState extends State<PrivacySettings> {
  @override
  void initState() {
    final value = Provider.of<BlockUpProvider>(context, listen: false);
    value.getData();
    final value2 =
        Provider.of<SettingsAudienceTagProvider>(context, listen: false);
    value2.getData();

    final value3 =
        Provider.of<SettingsDrectMassagesProvider>(context, listen: false);
    value3.getData();

    super.initState();
  }

  Future<void> _refresh() async {
    final data = Provider.of<BlockUpProvider>(context, listen: false);
    data.getData();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return RefreshIndicator(
      onRefresh: () => _refresh(),
      child: ExpansionTile(
        title: SettingsWidget(
          width: width,
          height: height * 0.06,
          iconName: FontAwesomeIcons.userShield,
          boxName: "Privacy and safety ",
          boxDetails: "Manage what information you see and share on.",
        ),
        children: [
          Consumer2<ParivacyAudienceTagProvider, SettingsAudienceTagProvider>(
              builder: (context, provider, audienceTag, child) {
            return ExpansionTile(
              title: PrivacysafetyWidget(
                icon: FontAwesomeIcons.peopleLine,
                name: "Audience and tagging",
                width: width,
              ),
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              provider.anyonetagbool();
                            },
                            icon: Icon(
                              (provider.anyonetag ==
                                      audienceTag.audienceTag.isAnyoneTag)
                                  ? FontAwesomeIcons.squareCheck
                                  : FontAwesomeIcons.square,
                              color: (provider.anyonetag ==
                                      audienceTag.audienceTag.isAnyoneTag)
                                  ? Colors.green
                                  : Colors.red,
                              size: 15,
                            )),
                        Text(
                          "Anyone can tag you",
                          style: GoogleFonts.lato(),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              provider.onlyFollowPeopletagbool();
                            },
                            icon: Icon(
                              (provider.onlyFollowPeopletag ==
                                      audienceTag.audienceTag.isPeopleFollowTag)
                                  ? FontAwesomeIcons.squareCheck
                                  : FontAwesomeIcons.square,
                              color: (provider.onlyFollowPeopletag ==
                                      audienceTag.audienceTag.isPeopleFollowTag)
                                  ? Colors.green
                                  : Colors.red,
                              size: 15,
                            )),
                        Text(
                          "Only people you follow can tag you",
                          style: GoogleFonts.lato(),
                        )
                      ],
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (provider.success = false) {
                            showMessage(
                              message: "Something went wrong",
                              context: context,
                            );
                          } else {
                            provider.loading = true;
                            provider.updatetaging(provider.anyonetag.toString(),
                                provider.onlyFollowPeopletag.toString());

                            if (provider.success == true) {
                              provider.message;
                            }
                          }
                        },
                        child: Text(
                          "Update & Save",
                          style: GoogleFonts.lato(fontSize: 10),
                        )),
                  ],
                ),
              ],
            );
          }),
          Consumer2<ParivacyDirectMessagesProvider,
                  SettingsDrectMassagesProvider>(
              builder: (context, provider, drectMassages, child) {
            return ExpansionTile(
              title: PrivacysafetyWidget(
                icon: FontAwesomeIcons.message,
                name: "Direct Messages",
                width: width,
              ),
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          provider.alloweveryonebool();
                        },
                        icon: Icon(
                          (provider.alloweveryone ==
                                  drectMassages.drectMassages.isAnyoneMessage)
                              ? FontAwesomeIcons.squareCheck
                              : FontAwesomeIcons.square,
                          color: (provider.alloweveryone ==
                                  drectMassages.drectMassages.isAnyoneMessage)
                              ? Colors.green
                              : Colors.red,
                          size: 15,
                        )),
                    Text(
                      "Allow message requests from everyone",
                      style: GoogleFonts.lato(),
                    )
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          provider.youFollowbool();
                        },
                        icon: Icon(
                          (provider.youFollow ==
                                  drectMassages.drectMassages.isFollowerMessage)
                              ? FontAwesomeIcons.squareCheck
                              : FontAwesomeIcons.square,
                          color: (provider.youFollow ==
                                  drectMassages.drectMassages.isFollowerMessage)
                              ? Colors.green
                              : Colors.red,
                          size: 15,
                        )),
                    Text(
                      "Only people you follow ",
                      style: GoogleFonts.lato(),
                    )
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          provider.yourFollowerbool();
                        },
                        icon: Icon(
                          (provider.yourFollower ==
                                  drectMassages
                                      .drectMassages.isFollowingMessage)
                              ? FontAwesomeIcons.square
                              : FontAwesomeIcons.squareCheck,
                          color: (provider.yourFollower ==
                                  drectMassages
                                      .drectMassages.isFollowingMessage)
                              ? Colors.red
                              : Colors.green,
                          size: 15,
                        )),
                    Text(
                      "People who follow you",
                      style: GoogleFonts.lato(),
                    )
                  ],
                ),
                ElevatedButton(
                    onPressed: () {
                      if (provider.success = false) {
                        showMessage(
                          message: "Something went wrong",
                          context: context,
                        );
                      } else {
                        provider.loading = true;
                        provider.updatedirctmasge(
                            provider.alloweveryone.toString(),
                            provider.youFollow.toString(),
                            provider.yourFollower.toString());

                        if (provider.success == true) {
                          provider.message;
                        }
                      }
                    },
                    child: Text(
                      "Update & Save",
                      style: GoogleFonts.lato(fontSize: 10),
                    )),
              ],
            );
          }),
          Consumer4<LcsProvider, PLikeProvider,
                  ParivacyCommnetProvider, ParivacyShareProvider>(
              builder: (context, provalue, likeprovider, cmntprovider,
                  shareprovider, child) {
            return ExpansionTile(
              title: PrivacysafetyWidget(
                icon: FontAwesomeIcons.exclamation,
                name: "Like and Comments & Share",
                width: width,
              ),
              children: [
                Text(
                  "Who can Like Your post ?",
                  style: GoogleFonts.lato(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          provalue.likepostAnyonebool();
                        },
                        icon: Icon(
                          (provalue.likepostAnyone == false)
                              ? FontAwesomeIcons.square
                              : FontAwesomeIcons.squareCheck,
                          color: (provalue.likepostAnyone == false)
                              ? Colors.red
                              : Colors.green,
                          size: 15,
                        )),
                    Text(
                      "Anyone",
                      style: GoogleFonts.lato(),
                    )
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          provalue.likepostUFollowbool();
                        },
                        icon: Icon(
                          (provalue.likepostUFollow == false)
                              ? FontAwesomeIcons.square
                              : FontAwesomeIcons.squareCheck,
                          color: (provalue.likepostUFollow == false)
                              ? Colors.red
                              : Colors.green,
                          size: 15,
                        )),
                    Text(
                      "Only people you follow ",
                      style: GoogleFonts.lato(),
                    )
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          provalue.likepostYourFollowbool();
                        },
                        icon: Icon(
                          (provalue.likepostYourFollow == false)
                              ? FontAwesomeIcons.square
                              : FontAwesomeIcons.squareCheck,
                          color: (provalue.likepostYourFollow == false)
                              ? Colors.red
                              : Colors.green,
                          size: 15,
                        )),
                    Text(
                      "People who follow you",
                      style: GoogleFonts.lato(),
                    )
                  ],
                ),
                ElevatedButton(
                    onPressed: () {
                      if (likeprovider.success = false) {
                        showMessage(
                          message: "Something went wrong",
                          context: context,
                        );
                      } else {
                        likeprovider.loading = true;
                        likeprovider.updatelike(
                            provalue.likepostAnyone.toString(),
                            provalue.likepostUFollow.toString(),
                            provalue.likepostYourFollow.toString());

                        if (likeprovider.success == true) {
                          likeprovider.message;
                        }
                      }
                    },
                    child: Text(
                      "Update & Save",
                      style: GoogleFonts.lato(fontSize: 10),
                    )),

                /*.............comment................*/

                Text(
                  "Who can Comment Your post ?",
                  style: GoogleFonts.lato(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          provalue.cmntpostAnyonebool();
                        },
                        icon: Icon(
                          (provalue.cmntpostAnyone == false)
                              ? FontAwesomeIcons.square
                              : FontAwesomeIcons.squareCheck,
                          color: (provalue.cmntpostAnyone == false)
                              ? Colors.red
                              : Colors.green,
                          size: 15,
                        )),
                    Text(
                      "Anyone",
                      style: GoogleFonts.lato(),
                    )
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          provalue.cmntpostUFollowbool();
                        },
                        icon: Icon(
                          (provalue.cmntpostUFollow == false)
                              ? FontAwesomeIcons.square
                              : FontAwesomeIcons.squareCheck,
                          color: (provalue.cmntpostUFollow == false)
                              ? Colors.red
                              : Colors.green,
                          size: 15,
                        )),
                    Text(
                      "Only people you follow ",
                      style: GoogleFonts.lato(),
                    )
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          provalue.cmntpostYourFollowbool();
                        },
                        icon: Icon(
                          (provalue.cmntpostYourFollow == false)
                              ? FontAwesomeIcons.square
                              : FontAwesomeIcons.squareCheck,
                          color: (provalue.cmntpostYourFollow == false)
                              ? Colors.red
                              : Colors.green,
                          size: 15,
                        )),
                    Text(
                      "People who follow you",
                      style: GoogleFonts.lato(),
                    )
                  ],
                ),
                ElevatedButton(
                    onPressed: () {
                      if (cmntprovider.success = false) {
                        showMessage(
                          message: "Something went wrong",
                          context: context,
                        );
                      } else {
                        cmntprovider.loading = true;
                        cmntprovider.updatecoment(
                            provalue.cmntpostAnyone.toString(),
                            provalue.cmntpostUFollow.toString(),
                            provalue.cmntpostYourFollow.toString());

                        if (cmntprovider.success == true) {
                          cmntprovider.message;
                        }
                      }
                    },
                    child: Text(
                      "Update & Save",
                      style: GoogleFonts.lato(fontSize: 10),
                    )),

                /*................share............*/
                Text(
                  "Who can Share Your post ?",
                  style: GoogleFonts.lato(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          provalue.sharepostAnyonebool();
                        },
                        icon: Icon(
                          (provalue.sharepostAnyone == false)
                              ? FontAwesomeIcons.square
                              : FontAwesomeIcons.squareCheck,
                          color: (provalue.sharepostAnyone == false)
                              ? Colors.red
                              : Colors.green,
                          size: 15,
                        )),
                    Text(
                      "Anyone",
                      style: GoogleFonts.lato(),
                    )
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          provalue.sharepostUFollowbool();
                        },
                        icon: Icon(
                          (provalue.sharepostUFollow == false)
                              ? FontAwesomeIcons.square
                              : FontAwesomeIcons.squareCheck,
                          color: (provalue.sharepostUFollow == false)
                              ? Colors.red
                              : Colors.green,
                          size: 15,
                        )),
                    Text(
                      "Only people you follow ",
                      style: GoogleFonts.lato(),
                    )
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          provalue.sharepostYourFollowbool();
                        },
                        icon: Icon(
                          (provalue.sharepostYourFollow == false)
                              ? FontAwesomeIcons.square
                              : FontAwesomeIcons.squareCheck,
                          color: (provalue.sharepostYourFollow == false)
                              ? Colors.red
                              : Colors.green,
                          size: 15,
                        )),
                    Text(
                      "People who follow you",
                      style: GoogleFonts.lato(),
                    )
                  ],
                ),
                ElevatedButton(
                    onPressed: () {
                      if (shareprovider.success = false) {
                        showMessage(
                          message: "Something went wrong",
                          context: context,
                        );
                      } else {
                        shareprovider.loading = true;
                        shareprovider.updateshare(
                            provalue.sharepostAnyone.toString(),
                            provalue.sharepostUFollow.toString(),
                            provalue.sharepostYourFollow.toString());

                        if (shareprovider.success == true) {
                          shareprovider.message;
                        }
                      }
                    },
                    child: Text(
                      "Update & Save",
                      style: GoogleFonts.lato(fontSize: 10),
                    )),
              ],
            );
          }),
          ExpansionTile(
            title: PrivacysafetyWidget(
              icon: FontAwesomeIcons.lock,
              name: "Blocked Contacts",
              width: width,
            ),
            children: [
              SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Consumer2<BlockUpProvider, UnblockProvider>(
                    builder: (context, provider, idsend, child) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: provider.blocklist.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(
                                    provider.blocklist[index].profileImage),
                              ),
                              SizedBox(
                                width: width * 0.04,
                              ),
                              Text(
                                provider.blocklist[index].fullName,
                                style: GoogleFonts.lato(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              const Spacer(),
                              TextButton(
                                  onPressed: () {
                                    if (idsend.success = false) {
                                      showMessage(
                                        message: "Something went wrong",
                                        context: context,
                                      );
                                    } else {
                                      idsend.loading = true;
                                      idsend.unblock(provider
                                          .blocklist[index].id
                                          .toString());

                                      if (idsend.success == true) {
                                        idsend.message;
                                      }
                                    }
                                    _refresh();
                                  },
                                  child: Text(
                                    "Unblock",
                                    style: GoogleFonts.lato(
                                        color: Palette.notificationColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ))
                            ],
                          ),
                        );
                      });
                }),
              )
            ],
          ),
          Consumer<DiscoversbilityProvider>(
              builder: (context, provider, child) {
            return ExpansionTile(
              title: PrivacysafetyWidget(
                icon: FontAwesomeIcons.magnifyingGlassChart,
                name: "Discoverabilty",
                width: width,
              ),
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                provider.emailbool();
                              },
                              icon: Icon(
                                (provider.email == false)
                                    ? FontAwesomeIcons.square
                                    : FontAwesomeIcons.squareCheck,
                                color: (provider.email == false)
                                    ? Colors.red
                                    : Colors.green,
                                size: 15,
                              )),
                          Flexible(
                            child: Text(
                              "Let people who have your email address find and connect with you",
                              style: GoogleFonts.lato(),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                provider.phonenumberbool();
                              },
                              icon: Icon(
                                (provider.phonenumber == false)
                                    ? FontAwesomeIcons.square
                                    : FontAwesomeIcons.squareCheck,
                                color: (provider.phonenumber == false)
                                    ? Colors.red
                                    : Colors.green,
                                size: 15,
                              )),
                          Flexible(
                            child: Text(
                              "Let people who have your phone number find you",
                              style: GoogleFonts.lato(),
                            ),
                          )
                        ],
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (provider.success = false) {
                            showMessage(
                              message: "Something went wrong",
                              context: context,
                            );
                          } else {
                            provider.loading = true;
                            provider.updatedicoverability(
                                provider.email.toString(),
                                provider.phonenumber.toString());

                            if (provider.success == true) {
                              provider.message;
                            }
                          }
                        },
                        child: Text(
                          "Update & Save",
                          style: GoogleFonts.lato(fontSize: 10),
                        )),
                  ],
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
