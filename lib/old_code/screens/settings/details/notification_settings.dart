
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


import '../../../provider/provider.dart';
import '../../../widgets/card container/snackbar_message.dart';
import '../../../widgets/settings widgets/setteings_widget.dart';

class NotificationSettins extends StatefulWidget {
  const NotificationSettins({Key? key}) : super(key: key);

  @override
  State<NotificationSettins> createState() => _NotificationSettinsState();
}

class _NotificationSettinsState extends State<NotificationSettins> {
  @override
  void initState() {
    final value =
        Provider.of<SettingsNotificationProvider>(context, listen: false);
    value.getData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Consumer2<NotificationUpdateProvider, SettingsNotificationProvider>(
        builder: (context, provider, notifiactionpro, child) {
      return ExpansionTile(
        title: SettingsWidget(
          width: width,
          height: height * 0.06,
          iconName: FontAwesomeIcons.bell,
          boxName: "Notifications",
          boxDetails:
              "Select the kinds of notifications you get about your activities, interests, and recommendations",
        ),
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    provider.likebool();
                  },
                  icon: Icon(
                    (provider.likepost ==
                            notifiactionpro.notifiaction.isLikePost)
                        ? FontAwesomeIcons.squareCheck
                        : FontAwesomeIcons.square,
                    color: (provider.likepost ==
                            notifiactionpro.notifiaction.isLikePost)
                        ? Colors.green
                        : Colors.red,
                    size: 15,
                  )),
              Text(
                "When Anybody Like Your Post",
                style: GoogleFonts.lato(),
              )
            ],
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    provider.sharebool();
                  },
                  icon: Icon(
                    (provider.sharepost ==
                            notifiactionpro.notifiaction.isSharePost)
                        ? FontAwesomeIcons.squareCheck
                        : FontAwesomeIcons.square,
                    color: (provider.sharepost ==
                            notifiactionpro.notifiaction.isSharePost)
                        ? Colors.green
                        : Colors.red,
                    size: 15,
                  )),
              Text(
                "When Anybody Share Your Post",
                style: GoogleFonts.lato(),
              )
            ],
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    provider.commentbool();
                  },
                  icon: Icon(
                    (provider.commentpost ==
                            notifiactionpro.notifiaction.isCommentPost)
                        ? FontAwesomeIcons.squareCheck
                        : FontAwesomeIcons.square,
                    color: (provider.commentpost ==
                            notifiactionpro.notifiaction.isCommentPost)
                        ? Colors.green
                        : Colors.red,
                    size: 15,
                  )),
              Text(
                "When Anybody Comment Your Post",
                style: GoogleFonts.lato(),
              )
            ],
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    provider.followbool();
                  },
                  icon: Icon(
                    (provider.follow ==
                            notifiactionpro.notifiaction.isFollowerAlert)
                        ? FontAwesomeIcons.squareCheck
                        : FontAwesomeIcons.square,
                    color: (provider.follow ==
                            notifiactionpro.notifiaction.isFollowerAlert)
                        ? Colors.green
                        : Colors.red,
                    size: 15,
                  )),
              Text(
                "New Follwer alert",
                style: GoogleFonts.lato(),
              )
            ],
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    provider.waitingbool();
                  },
                  icon: Icon(
                    (provider.waiting ==
                            notifiactionpro.notifiaction.isWaitingAlert)
                        ? FontAwesomeIcons.squareCheck
                        : FontAwesomeIcons.square,
                    color: (provider.waiting ==
                            notifiactionpro.notifiaction.isWaitingAlert)
                        ? Colors.green
                        : Colors.red,
                    size: 15,
                  )),
              Text(
                "Notifications waiting alert ",
                style: GoogleFonts.lato(),
              )
            ],
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    provider.friendpostBool();
                  },
                  icon: Icon(
                    (provider.friendpost ==
                            notifiactionpro.notifiaction.isFriendPostAlert)
                        ? FontAwesomeIcons.squareCheck
                        : FontAwesomeIcons.square,
                    color: (provider.friendpost ==
                            notifiactionpro.notifiaction.isFriendPostAlert)
                        ? Colors.green
                        : Colors.red,
                    size: 15,
                  )),
              Text(
                "Close friend post alert",
                style: GoogleFonts.lato(),
              )
            ],
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    provider.mailstonealrtbool();
                  },
                  icon: Icon(
                    (provider.milstonealart ==
                            notifiactionpro.notifiaction.isMilestoneAlert)
                        ? FontAwesomeIcons.squareCheck
                        : FontAwesomeIcons.square,
                    color: (provider.milstonealart ==
                            notifiactionpro.notifiaction.isMilestoneAlert)
                        ? Colors.green
                        : Colors.red,
                    size: 15,
                  )),
              Text(
                "Milestone alert",
                style: GoogleFonts.lato(),
              )
            ],
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    provider.winawordbool();
                  },
                  icon: Icon(
                    (provider.winaword ==
                            notifiactionpro.notifiaction.isIconWinsAward)
                        ? FontAwesomeIcons.squareCheck
                        : FontAwesomeIcons.square,
                    color: (provider.winaword ==
                            notifiactionpro.notifiaction.isIconWinsAward)
                        ? Colors.green
                        : Colors.red,
                    size: 15,
                  )),
              Text(
                "Icon win award",
                style: GoogleFonts.lato(),
              )
            ],
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    provider.pointawordbool();
                  },
                  icon: Icon(
                    (provider.pointaword ==
                            notifiactionpro.notifiaction.isPointWinsAward)
                        ? FontAwesomeIcons.squareCheck
                        : FontAwesomeIcons.square,
                    color: (provider.pointaword ==
                            notifiactionpro.notifiaction.isPointWinsAward)
                        ? Colors.green
                        : Colors.red,
                    size: 15,
                  )),
              Text(
                "Points win award",
                style: GoogleFonts.lato(),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              top: height * 0.01,
            ),
            child: Consumer<NotificationUpdateProvider>(
                builder: (context, provider, child) {
              return ElevatedButton(
                  onPressed: () {
                    if (provider.success = false) {
                      showMessage(
                        message: "Something went wrong",
                        context: context,
                      );
                    } else {
                      provider.loading = true;
                      provider.updateNotification(
                        provider.likepost.toString(),
                        provider.sharepost.toString(),
                        provider.commentpost.toString(),
                        provider.follow.toString(),
                        provider.waiting.toString(),
                        provider.friendpost.toString(),
                        provider.milstonealart.toString(),
                        provider.winaword.toString(),
                        provider.pointaword.toString(),
                      );

                      if (provider.success == true) {
                        provider.loading = false;
                      }
                    }
                  },
                  child: Text(
                    "Update & Save",
                    style: GoogleFonts.lato(fontSize: 10),
                  ));
            }),
          )
        ],
      );
    });
  }
}
