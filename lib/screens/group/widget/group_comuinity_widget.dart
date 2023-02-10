import 'package:als_frontend/data/model/response/group/group_details_model.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter/material.dart';

class GroupComuinityWidget extends StatelessWidget {
  final GroupDetailsModel authorEachGroupModel;
  final int index;

  const GroupComuinityWidget(this.authorEachGroupModel, this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Text("Admin group policies", style: robotoStyle700Bold.copyWith(fontSize: 15, color: AppColors.primaryColorLight)),
        ),
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Column(
            children: [
              Text("1 .No Promotion or spam", style: robotoStyle700Bold.copyWith(fontSize: 15, color: AppColors.primaryColorLight)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Column(
            children: [
              Text(
                  "We're all in this together to create a welcoming environment. Let's treat everyone with respect. Healthy debates are natural, but kindness irequired ... See more",
                  style: robotoStyle500Medium.copyWith(fontSize: 12, color: AppColors.primaryColorLight)),
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Column(
            children: [
              Text("2. No hate speech", style: robotoStyle700Bold.copyWith(fontSize: 15, color: AppColors.primaryColorLight)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Column(
            children: [
              Text(
                  "We're all in this together to create a welcoming environment. Let's treat everyone with respect. Healthy debates are natural, but kindnessrequired... See more.",
                  style: robotoStyle500Medium.copyWith(fontSize: 12, color: AppColors.primaryColorLight)),
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Column(
            children: [
              Text("3. Respect everyone", style: robotoStyle700Bold.copyWith(fontSize: 15, color: AppColors.primaryColorLight)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Column(
            children: [
              Text(
                  "We're all in this together to create a welcoming environment. Let's treat everyone with respect. Healthy debates are natural, but kindnessrequired... See more.",
                  style: robotoStyle500Medium.copyWith(fontSize: 12, color: AppColors.primaryColorLight)),
            ],
          ),
        ),
      ],
    );
  }
}
