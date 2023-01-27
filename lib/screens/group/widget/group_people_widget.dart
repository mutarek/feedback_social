import 'package:als_frontend/screens/video/widget/new_video_widgets.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';

class GroupPeopleWidget extends StatelessWidget {
  const GroupPeopleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Text(
              "Admin group policies",
              style: robotoStyle700Bold.copyWith(fontSize: 15,color: AppColors.primaryColorLight)
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          height: 400,
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (_,index){
              return Container(
                margin: const EdgeInsets.all(1),
                padding: const EdgeInsets.all(2),
                child: Row(
                  children: [
                    const SizedBox(width:10),
                    const CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.teal,
                    ),
                    const SizedBox(width: 10),
                    Text('Mehedi Hasan Shuvo',style: robotoStyle700Bold.copyWith(fontSize: 15))
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
