import 'package:als_frontend/data/model/response/group/group_details_model.dart';
import 'package:als_frontend/provider/group_provider.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupComuinityWidget extends StatefulWidget {
  final GroupDetailsModel authorEachGroupModel;
  final int index;

  const GroupComuinityWidget(this.authorEachGroupModel, this.index, {Key? key}) : super(key: key);

  @override
  State<GroupComuinityWidget> createState() => _GroupComuinityWidgetState();
}

class _GroupComuinityWidgetState extends State<GroupComuinityWidget> {
  @override
  void initState() {
    Provider.of<GroupProvider>(context,listen: false).getAllGroupPolicies(widget.authorEachGroupModel.id.toString());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<GroupProvider>(
      builder: (context, groupProvider,child) {
        return SizedBox(
          height: 300,
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
        );
      }
    );
  }
}
