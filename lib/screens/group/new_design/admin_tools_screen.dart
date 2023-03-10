import 'package:als_frontend/provider/group_provider.dart';
import 'package:als_frontend/util/image.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:als_frontend/widgets/custom_text_field.dart';
import 'package:als_frontend/widgets/snackbar_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class AdminToolsScreen extends StatefulWidget {
  const AdminToolsScreen({Key? key}) : super(key: key);

  @override
  State<AdminToolsScreen> createState() => _AdminToolsScreenState();
}

class _AdminToolsScreenState extends State<AdminToolsScreen> {
  final TextEditingController policyTitle = TextEditingController();
  final TextEditingController policyDesc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(title: "Admin Tools", color: AppColors.primaryColorLight, fontWeight: FontWeight.bold, fontSize: 24),
        backgroundColor: Colors.white,
        elevation: 0.3,
        centerTitle: true,
        leading: const BackButton(
          color: Colors.black, // <-- SEE HERE
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Consumer<GroupProvider>(builder: (context, groupProvider, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    child: Container(
                      width: 250,
                      height: 50,
                      decoration: BoxDecoration(color: const Color(0xff080C2F), borderRadius: BorderRadius.circular(30)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.white,
                              child: SvgPicture.asset(
                                ImagesModel.pendingApprovals,
                                height: 20,
                                width: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Pending approvals",
                                      style: robotoStyle700Bold.copyWith(fontSize: 15, color: AppColors.whiteColorLight)),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            CircleAvatar(
                              radius: 12,
                              backgroundColor: AppColors.whiteColorLight,
                              child: InkWell(
                                  onTap: () {
                                    groupProvider.changePendingApprovalsExpanded();
                                  },
                                  child: groupProvider.pendingApprovals != true
                                      ? const Icon(Icons.arrow_drop_down, color: Colors.black)
                                      : const Icon(Icons.arrow_drop_up, color: Colors.black)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  groupProvider.pendingApprovals
                      ? SizedBox(
                          height: 500,
                          child: ListView.builder(
                            itemCount: 2,
                            itemBuilder: (_, index) {
                              return SizedBox(
                                height: 150,
                                child: Card(
                                  color: const Color(0xffFFFFFF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  elevation: 0.1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            const CircleAvatar(
                                              radius: 25,
                                            ),
                                            const SizedBox(width: 10),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("Rafayetul Islam", style: robotoStyle700Bold.copyWith(fontSize: 15)),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset("assets/svg/ago_svg.svg", height: 12, width: 12),
                                                    const SizedBox(width: 5),
                                                    Text("2 Hour Ago", style: robotoStyle500Medium.copyWith(fontSize: 10)),
                                                  ],
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          "In publishing and graphic design, L commonly used tn  o the visual form of a comm dfsdf  only  to the...View More ",
                                          style: robotoStyle600SemiBold.copyWith(fontSize: 12),
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                                width: 100,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(15), color: AppColors.primaryColorLight),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset("assets/svg/approve_svg.svg", height: 13, width: 14),
                                                    const SizedBox(width: 5),
                                                    Text("Approve",
                                                        style:
                                                            robotoStyle600SemiBold.copyWith(fontSize: 15, color: AppColors.whiteColorLight))
                                                  ],
                                                )),
                                            Container(
                                                width: 100,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(15), color: AppColors.primaryColorLight),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset("assets/svg/reject_svg.svg", height: 13, width: 14),
                                                    const SizedBox(width: 5),
                                                    Text("Reject",
                                                        style:
                                                            robotoStyle600SemiBold.copyWith(fontSize: 15, color: AppColors.whiteColorLight))
                                                  ],
                                                )),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : const SizedBox.shrink(),
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    child: Container(
                      width: 250,
                      height: 50,
                      decoration: BoxDecoration(color: const Color(0xff080C2F), borderRadius: BorderRadius.circular(30)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.white,
                              child: SvgPicture.asset(
                                ImagesModel.pendingApprovals,
                                height: 20,
                                width: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Group Policy", style: robotoStyle700Bold.copyWith(fontSize: 15, color: AppColors.whiteColorLight)),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            CircleAvatar(
                              radius: 12,
                              backgroundColor: AppColors.whiteColorLight,
                              child: InkWell(
                                  onTap: () {
                                    groupProvider.changeGroupPolicyExpanded();
                                  },
                                  child: groupProvider.groupPolicy != true
                                      ? const Icon(Icons.arrow_drop_down, color: Colors.black)
                                      : const Icon(Icons.arrow_drop_up, color: Colors.black)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  groupProvider.groupPolicy
                      ? SizedBox(
                          height: 600,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 15),
                              SizedBox(
                                  height: 200,
                                child: groupProvider.isGroupPolicyLoading?
                                    const Center(
                                      child: CircularProgressIndicator(),
                                    ):groupProvider.groupPolicyList.isEmpty?
                                    const Center(
                                      child: Text("Ops No Group Policy Found"),
                                    ):
                                ListView.builder(
                                  itemCount: groupProvider.groupPolicyList.length,
                                  itemBuilder: (_,index){
                                    var rules = groupProvider.groupPolicyList[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 12),
                                            child: Text("${index+1}. ${rules.title}",
                                                style: robotoStyle700Bold.copyWith(fontSize: 15, color: AppColors.primaryColorLight)),
                                          ),
                                          const SizedBox(height: 5),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 18),
                                            child: Column(
                                              children: [
                                                Text(
                                                    "${rules.description} See more.",
                                                    style: robotoStyle500Medium.copyWith(fontSize: 12, color: AppColors.primaryColorLight)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Container(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: AppColors.primaryColorLight),
                                  height: 30,
                                  width: 150,
                                  child: Center(
                                    child: Text("Add new Policy",
                                        style: robotoStyle600SemiBold.copyWith(fontSize: 12, color: AppColors.whiteColorLight)),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Container(
                                  height: 200,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.primaryColorLight)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        CustomTextField(
                                          hintText: 'Add tittle....',
                                          isShowBorder: true,
                                          borderRadius: 11,
                                          verticalSize: 14,
                                          controller: policyTitle,
                                        ),
                                        const SizedBox(height: 10),
                                        CustomTextField(
                                          hintText: 'Add descriptions....',
                                          isShowBorder: true,
                                          borderRadius: 11,
                                          verticalSize: 14,
                                          controller: policyDesc,
                                          maxLines: 4,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: InkWell(
                                  onTap: (){
                                    if(policyTitle.text.isNotEmpty && policyDesc.text.isNotEmpty){
                                      groupProvider.createPolicy(policyTitle.text.trim(), policyDesc.text.trim()).then((value){
                                        if(value){
                                          policyTitle.clear();
                                          policyDesc.clear();
                                        }
                                        else
                                          {

                                          }
                                      });
                                    }
                                    else
                                      {
                                        showMessage(message: "Please fill in all fields");
                                      }
                                  },
                                  child: groupProvider.isLoadingCreatePolicy?
                                      const CircularProgressIndicator():
                                  Container(
                                    height: 40,
                                    width: 80,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: AppColors.primaryColorLight),
                                    child: Center(
                                      child: Text("Save", style: robotoStyle700Bold.copyWith(fontSize: 14, color: AppColors.whiteColorLight)),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      : const SizedBox.shrink(),
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    child: Container(
                      width: 250,
                      height: 50,
                      decoration: BoxDecoration(color: const Color(0xff080C2F), borderRadius: BorderRadius.circular(30)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.white,
                              child: SvgPicture.asset(
                                "assets/svg/pending_approval_svg.svg",
                                height: 20,
                                width: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Reported Content", style: robotoStyle700Bold.copyWith(fontSize: 15, color: AppColors.whiteColorLight)),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            CircleAvatar(
                              radius: 12,
                              backgroundColor: AppColors.whiteColorLight,
                              child: InkWell(
                                  onTap: () {
                                    groupProvider.changeReportedContentExpanded();
                                  },
                                  child: groupProvider.reportedContent != true
                                      ? const Icon(Icons.arrow_drop_down, color: Colors.black)
                                      : const Icon(Icons.arrow_drop_up, color: Colors.black)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  groupProvider.reportedContent?
                  SizedBox(
                    height: 500,
                    child: ListView.builder(
                      itemCount: 2,
                      itemBuilder: (_, index) {
                        return SizedBox(
                          height: 150,
                          child: Card(
                            color: const Color(0xffFFFFFF),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            elevation: 0.1,
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Column(
                                children: [
                                  Row(

                                    children: [
                                      const CircleAvatar(
                                        radius: 25,
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Rafayetul Islam", style: robotoStyle700Bold.copyWith(fontSize: 15)),
                                          Row(
                                            children: [
                                              SvgPicture.asset("assets/svg/ago_svg.svg", height: 12, width: 12),
                                              const SizedBox(width: 5),
                                              Text("2 Hour Ago", style: robotoStyle500Medium.copyWith(fontSize: 10)),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "This is an 18+ content.",
                                      style: robotoStyle600SemiBold.copyWith(fontSize: 12),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                          width: 150,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15), color: AppColors.primaryColorLight),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset("assets/svg/reject_svg.svg", height: 13, width: 14),
                                              const SizedBox(width: 5),
                                              Text("Take Actions",
                                                  style:
                                                  robotoStyle600SemiBold.copyWith(fontSize: 15, color: AppColors.whiteColorLight))
                                            ],
                                          )),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
