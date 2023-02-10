import 'package:als_frontend/data/model/response/group/group_details_model.dart';
import 'package:als_frontend/provider/group_provider.dart';
import 'package:als_frontend/util/image.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class GroupAboutViewWidget extends StatelessWidget {
  final GroupDetailsModel authorEachGroupModel;
  final int index;
  const GroupAboutViewWidget(this.authorEachGroupModel,this.index,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GroupProvider>(builder: (context, groupProvider, child) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 18),
            child: Text("Intro", style: robotoStyle700Bold.copyWith(fontSize: 15, color: AppColors.primaryColorLight)),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(left: 18),
              child: Text(
                authorEachGroupModel.bio!,
                style: robotoStyle400Regular.copyWith(fontSize: 12, color: AppColors.primaryColorLight),
              ),
            ),
          ),
          const SizedBox(height: 3),
          const Divider(height: 2),
          const SizedBox(height: 3),
          Padding(
            padding: const EdgeInsets.only(left: 18),
            child: Text(
              "Details",
              style: GoogleFonts.roboto(fontWeight: FontWeight.w700, fontSize: 15, color: AppColors.primaryColorLight),
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 17,
                  backgroundColor: AppColors.primaryColorLight,
                  child: Icon(Icons.account_balance_wallet_rounded, color: Colors.white),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(authorEachGroupModel.isPrivate==true?"Private":"Public", style: robotoStyle800ExtraBold.copyWith(fontSize: 15, color: AppColors.primaryColorLight)),
                      const SizedBox(height: 2),
                      Text("Only members can see who is in the group and what they post.",
                          style: robotoStyle400Regular.copyWith(fontSize: 12)),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                CircleAvatar(
                    radius: 17,
                    backgroundColor: AppColors.primaryColorLight,
                    child: SvgPicture.asset(
                      ImagesModel.createDateIcon,
                      height: 12,
                      width: 12,
                      color: Colors.white,
                    )),
                const SizedBox(width: 5),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 3),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Created Date -',
                              style: robotoStyle400Regular.copyWith(
                                  fontSize: 15, color: AppColors.primaryColorLight, fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: '  15 March 2022!', style: robotoStyle400Regular.copyWith(fontSize: 13)),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                CircleAvatar(
                    radius: 17,
                    backgroundColor: AppColors.primaryColorLight,
                    child: SvgPicture.asset(
                      ImagesModel.groupLocationIcon,
                      height: 14,
                      width: 14,
                      color: Colors.white,
                    )),
                const SizedBox(width: 5),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 3),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                                text: authorEachGroupModel.address,
                                style: robotoStyle400Regular.copyWith(fontSize: 13)),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 3),
          const Divider(height: 2),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text("Description", style: robotoStyle700Bold.copyWith(fontSize: 15, color: AppColors.primaryColorLight)),
          ),
          const SizedBox(height: 7),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text:
                              authorEachGroupModel.description,
                          style: robotoStyle600SemiBold.copyWith(fontSize: 10)),
                      TextSpan(
                        text: '... View More ',
                        style: robotoStyle700Bold.copyWith(fontSize: 13),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 3),
          const Divider(height: 2),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text("Members Info  - 70k", style: robotoStyle700Bold.copyWith(fontSize: 15, color: AppColors.primaryColorLight)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              padding: const EdgeInsets.all(2),
              height: 30,
              width: 200,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: AppColors.primaryColorLight),
              child: InkWell(
                onTap: () {
                  groupProvider.changeAdminListGroupStatus();
                },
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: const Color(0xffF5F5F5),
                      child: SvgPicture.asset(
                        ImagesModel.groupAdminIcon,
                        height: 13,
                        width: 13,
                        color: AppColors.primaryColorLight,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text("Admin", style: robotoStyle800ExtraBold.copyWith(fontSize: 17, color: AppColors.whiteColorLight)),
                    const Spacer(),
                    SvgPicture.asset(groupProvider.adminList ? "assets/svg/play_up_vector.svg" : "assets/svg/play_down_vector.svg",
                        color: AppColors.whiteColorLight),
                    const SizedBox(width: 5),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          groupProvider.adminList
              ? Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: SizedBox(
                    height: 100,
                    child: ListView.builder(
                      itemCount: 2,
                      itemBuilder: (_, index) {
                        return Padding(
                          padding: const EdgeInsets.all(2),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                backgroundColor: Color(0xff8600DE),
                                radius: 15,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "Rafayetul Islam",
                                style: robotoStyle500Medium.copyWith(fontSize: 12),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                )
              : const SizedBox.shrink(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              padding: const EdgeInsets.all(2),
              height: 30,
              width: 200,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: AppColors.primaryColorLight),
              child: InkWell(
                onTap: () {
                  groupProvider.changeModeratorListGroupStatus();
                },
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: const Color(0xffF5F5F5),
                      child: SvgPicture.asset(
                        ImagesModel.groupModeratorIcon,
                        height: 13,
                        width: 13,
                        color: AppColors.primaryColorLight,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text("Moderator", style: robotoStyle800ExtraBold.copyWith(fontSize: 17, color: AppColors.whiteColorLight)),
                    const Spacer(),
                    SvgPicture.asset(groupProvider.moderatorList ? "assets/svg/play_up_vector.svg" : "assets/svg/play_down_vector.svg",
                        color: AppColors.whiteColorLight),
                    const SizedBox(width: 5),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          groupProvider.moderatorList
              ? Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: SizedBox(
                    height: 100,
                    child: ListView.builder(
                      itemCount: 2,
                      itemBuilder: (_, index) {
                        return Padding(
                          padding: const EdgeInsets.all(2),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                backgroundColor: Color(0xff8600DE),
                                radius: 15,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "Rafayetul Islam",
                                style: robotoStyle500Medium.copyWith(fontSize: 12),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                )
              : const SizedBox.shrink(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              padding: const EdgeInsets.all(2),
              height: 30,
              width: 200,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: AppColors.primaryColorLight),
              child: InkWell(
                onTap: () {
                  groupProvider.changeMemberListGroupStatus();
                },
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: const Color(0xffF5F5F5),
                      child: SvgPicture.asset(
                        ImagesModel.groupPublicIcon,
                        height: 13,
                        width: 13,
                        color: AppColors.primaryColorLight,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text("Member", style: robotoStyle800ExtraBold.copyWith(fontSize: 17, color: AppColors.whiteColorLight)),
                    const Spacer(),
                    SvgPicture.asset(groupProvider.memberList ? "assets/svg/play_up_vector.svg" : "assets/svg/play_down_vector.svg",
                        color: AppColors.whiteColorLight),
                    const SizedBox(width: 5),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          groupProvider.memberList
              ? Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: SizedBox(
                    height: 400,
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: 12,
                            itemBuilder: (_, index) {
                              return Padding(
                                padding: const EdgeInsets.all(2),
                                child: Row(
                                  children: [
                                    const CircleAvatar(
                                      backgroundColor: Color(0xff8600DE),
                                      radius: 15,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      "Rafayetul Islam",
                                      style: robotoStyle500Medium.copyWith(fontSize: 12),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          height: 30,
                          width: 200,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: const Color(0xff080C2F)),
                          child: Center(
                            child: Text("View All Members",
                                style: robotoStyle700Bold.copyWith(fontSize: 15, color: AppColors.whiteColorLight)),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                )
              : const SizedBox.shrink(),

          // infoWidget(
          //     ImagesModel.categoryIcons, "news & media website", Text('Category - ', style: robotoStyle800ExtraBold.copyWith(fontSize: 15))),
          // const SizedBox(height: 10),
          // infoWidget(ImagesModel.emailIcons, "abs@google.com", const SizedBox.shrink()),
          // const SizedBox(height: 10),
          // infoWidget(ImagesModel.websiteIcons, "abs.com.bd", const SizedBox.shrink()),
          // const SizedBox(height: 10),
          // infoWidget(ImagesModel.callIcons, "+880170000000", const SizedBox.shrink()),
          // const SizedBox(height: 10),
          // infoWidget(ImagesModel.locationIcons, "151/7, Good Luck Center (7th & 8th)1205 Dhaka, Dhaka Division, Bangladesh",
          //     const SizedBox.shrink()),
          // const SizedBox(height: 10),
          // infoWidget(ImagesModel.directionIcons, "", Text('Get Directions', style: robotoStyle800ExtraBold.copyWith(fontSize: 15))),
          // const SizedBox(height: 12),
          // const Divider(thickness: 1.8, color: Color(0xffE4E6EB)),
          // Padding(padding: const EdgeInsets.only(left: 15), child: Text("Descriptions", style: robotoStyle700Bold.copyWith(fontSize: 17))),
          // const SizedBox(height: 5),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 15),
          //   child: Text(
          //     "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to the visual form of a commonly  to.used to the visual form of a commonly  to. placeholder text commonly used to the visual form of a commonly  to.used to thezxxzc...View More",
          //     style: robotoStyle400Regular.copyWith(fontSize: 12),
          //     textAlign: TextAlign.justify,
          //   ),
          // ),
          // const Divider(thickness: 1.8, color: Color(0xffE4E6EB)),
          // const SizedBox(height: 2),
          // Padding(padding: const EdgeInsets.only(left: 15), child: Text("Page Info", style: robotoStyle700Bold.copyWith(fontSize: 17))),
          // const SizedBox(height: 10),
          // infoWidget(ImagesModel.adminIcons, "Mehedi Hasan Shuvo", Text('Admin - ', style: robotoStyle800ExtraBold.copyWith(fontSize: 15))),
          // const SizedBox(height: 10),
          // infoWidget(ImagesModel.dateIcons, "15 March 2022", Text('Created Date - ', style: robotoStyle800ExtraBold.copyWith(fontSize: 15))),
          // const SizedBox(height: 10),
        ],
      );
    });
  }
}
