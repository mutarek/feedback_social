import 'package:als_frontend/provider/group_provider.dart';
import 'package:als_frontend/screens/group/widget/friend_list_card.dart';
import 'package:als_frontend/screens/profile/public_profile_screen.dart';
import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:als_frontend/widgets/custom_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class InviteGroupScreen extends StatefulWidget {
  final int groupID;

  const InviteGroupScreen(this.groupID, {Key? key}) : super(key: key);

  @override
  State<InviteGroupScreen> createState() => _InviteGroupScreenState();
}

class _InviteGroupScreenState extends State<InviteGroupScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<GroupProvider>(context, listen: false).callForGetAllGroupMemberWhoNotMember(widget.groupID);
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Consumer<GroupProvider>(
            builder: (context, groupProvider, child) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              hintText: LocaleKeys.write_a_name_to_search.tr(),
                              onChanged: (value) {
                                groupProvider.searchUser(value!);
                                return null;
                              },
                              isSearch: true,
                              controller: searchController,
                              inputType: TextInputType.name,
                              inputAction: TextInputAction.done,
                              fillColor: Colors.white,
                              borderRadius: 10,
                            ),
                          ),
                          SizedBox(width: width * 0.02),
                          Container(
                            height: height * 0.05,
                            width: width * 0.1,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(), color: Colors.white70),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: height * 0.001),
                              child: IconButton(
                                  color: Colors.lightBlue,
                                  splashColor: Colors.green,
                                  onPressed: () {
                                    groupProvider.searchUser(searchController.text);

                                    // if (searchController.text.isNotEmpty && searchController.text.length == 6) {
                                    //   groupProvider.searchAnimal(searchController.text);
                                    //   searchController.clear();
                                    // } else {
                                    //   Fluttertoast.showToast(msg: "Write 6 digits code to search");
                                    // }
                                  },
                                  icon: const Icon(FontAwesomeIcons.magnifyingGlass, size: 20)),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      groupProvider.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : Expanded(
                              child: groupProvider.friendsList.isNotEmpty
                                  ? ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: groupProvider.friendsList.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(MaterialPageRoute(
                                                builder: (_) => PublicProfileScreen(groupProvider.friendsList[index].id.toString())));
                                          },
                                          child: FriendListCard(
                                              verb: LocaleKeys.invite.tr(),
                                              onPressed: () {
                                                groupProvider.sendInvitation(widget.groupID, groupProvider.friendsList[index].id, index);
                                              },
                                              width: width,
                                              height: height,
                                              name: groupProvider.friendsList[index].fullName,
                                              image: groupProvider.friendsList[index].profileImage),
                                        );
                                      })
                                  :  Center(child: CustomText(title: LocaleKeys.no_Data_Found.tr(), color: Colors.black, fontSize: 18)),
                            )
                    ],
                  ),
                )),
      ),
    );
  }
}
