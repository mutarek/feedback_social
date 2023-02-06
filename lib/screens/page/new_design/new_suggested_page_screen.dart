import 'package:als_frontend/data/model/response/page/athour_pages_model.dart';
import 'package:als_frontend/provider/other_provider.dart';
import 'package:als_frontend/provider/page_provider.dart';
import 'package:als_frontend/screens/page/new_design/new_page_details_screen.dart';
import 'package:als_frontend/screens/page/widget/page_app_bar.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/image.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:als_frontend/widgets/network_image.dart';
import 'package:als_frontend/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class NewSuggestedPageScreen extends StatefulWidget {
  const NewSuggestedPageScreen({Key? key}) : super(key: key);

  @override
  State<NewSuggestedPageScreen> createState() => _NewSuggestedPageScreenState();
}

class _NewSuggestedPageScreenState extends State<NewSuggestedPageScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<PageProvider>(context, listen: false).initializeSuggestPage();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<OtherProvider, PageProvider>(
      builder: (context, otherProvider, pageProvider, child) {
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: const PageAppBar(title: 'Suggested Page'),
            body: pageProvider.isLoadingSuggested
                ? const Center(child: CircularProgressIndicator())
                : pageProvider.allSuggestPageList.isNotEmpty
                    ? MasonryGridView.count(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        itemCount: pageProvider.allSuggestPageList.length,
                        crossAxisCount: 2,
                        crossAxisSpacing: 6,
                        mainAxisSpacing: 14,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          AuthorPageModel authorPageModel = pageProvider.allSuggestPageList[index];
                          return InkWell(
                            onTap: () {
                              Helper.toScreen(NewPageDetailsScreen(authorPageModel.id.toString(),  index: index));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xffFAFAFA),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(.2),
                                        blurRadius: 10.0,
                                        spreadRadius: 3.0,
                                        offset: const Offset(0.0, 0.0))
                                  ],
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      const SizedBox(height: 120),
                                      ClipRRect(
                                          borderRadius:
                                              const BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15)),
                                          child: customNetworkImage(authorPageModel.coverPhoto!, height: 90)),
                                      Positioned(
                                          bottom: 0,
                                          child: CircleAvatar(
                                              radius: 22,
                                              backgroundColor: Colors.white,
                                              child: Padding(
                                                  padding: const EdgeInsets.all(3.0),
                                                  child: circularImage(authorPageModel.avatar!, 40, 40)))),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5),
                                    child: Text(authorPageModel.name!,
                                        textAlign: TextAlign.center,
                                        style: robotoStyle700Bold.copyWith(fontSize: 15, overflow: TextOverflow.ellipsis),
                                        maxLines: 2),
                                  ),
                                  // const SizedBox(height: 5),
                                  // Text(authorPageModel.category!,
                                  //     textAlign: TextAlign.center, style: robotoStyle500Medium.copyWith(fontSize: 10)),
                                  const SizedBox(height: 5),
                                  Text('${authorPageModel.followers!} People following',
                                      textAlign: TextAlign.center, style: robotoStyle500Medium.copyWith(fontSize: 10)),
                                  const SizedBox(height: 5),
                                  Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 15),
                                    child: RoundedButton(
                                      padding: 0,
                                      onPress: () {
                                        pageProvider.changeSearchView(1);
                                        pageProvider.pageLikeUnlike(authorPageModel.id as int, false, index: index,isGoDetails: false);
                                      },
                                      backgroundColor: MaterialStateProperty.all(colorText),
                                      boarderRadius: 100,
                                      child: Container(
                                        height: 30,
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(ImagesModel.likeIcons, width: 15, height: 15, color: Colors.white),
                                            const SizedBox(width: 6),
                                            Text(
                                              'Like',
                                              style: robotoStyle500Medium.copyWith(color: AppColors.whiteColorLight, fontSize: 14),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        })
                    : const Center(child: CustomText(title: "You haven't any Suggested Page")));
      },
    );
  }
}
