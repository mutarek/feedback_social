import 'package:als_frontend/helper/date_converter.dart';
import 'package:als_frontend/provider/page_provider.dart';
import 'package:als_frontend/util/image.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/snackbar_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PageAboutWidget extends StatelessWidget {
  const PageAboutWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PageProvider>(builder: (context, pageProvider, child) {
      return pageProvider.isLoadingPageDetails
          ? const Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: Text("Intro",
                      style: GoogleFonts.roboto(fontWeight: FontWeight.w700, fontSize: 15, color: AppColors.primaryColorLight)),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 18),
                    child: Text(
                      pageProvider.pageDetailsModel.bio!.isNotEmpty
                          ? pageProvider.pageDetailsModel.bio.toString()
                          : "There has no bio in the page",
                      style: GoogleFonts.roboto(fontWeight: FontWeight.w400, fontSize: 12, color: AppColors.primaryColorLight),
                    )),
                const SizedBox(height: 3),
                const Divider(height: 2),
                const SizedBox(height: 3),
                pageProvider.pageDetailsModel.category!.isEmpty &&
                        pageProvider.pageDetailsModel.email!.isEmpty &&
                        pageProvider.pageDetailsModel.website!.isEmpty &&
                        pageProvider.pageDetailsModel.contact!.isEmpty &&
                        pageProvider.pageDetailsModel.address!.isEmpty
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: Text("Details",
                            style: GoogleFonts.roboto(fontWeight: FontWeight.w700, fontSize: 15, color: AppColors.primaryColorLight)),
                      ),
                SizedBox(
                    height: pageProvider.pageDetailsModel.category!.isEmpty &&
                            pageProvider.pageDetailsModel.email!.isEmpty &&
                            pageProvider.pageDetailsModel.website!.isEmpty &&
                            pageProvider.pageDetailsModel.contact!.isEmpty &&
                            pageProvider.pageDetailsModel.address!.isEmpty
                        ? 0
                        : 15),
                pageProvider.pageDetailsModel.category!.isNotEmpty
                    ? infoWidget(ImagesModel.categoryIcons, "news & media website",
                        Text('Category - ${pageProvider.pageDetailsModel.category}', style: robotoStyle800ExtraBold.copyWith(fontSize: 15)))
                    : const SizedBox.shrink(),
                SizedBox(height: pageProvider.pageDetailsModel.category!.isEmpty ? 0 : 10),
                pageProvider.pageDetailsModel.email!.isNotEmpty
                    ? infoWidget(ImagesModel.emailIcons, pageProvider.pageDetailsModel.email!, const SizedBox.shrink())
                    : const SizedBox.shrink(),
                SizedBox(height: pageProvider.pageDetailsModel.email!.isEmpty ? 0 : 10),
                pageProvider.pageDetailsModel.website!.isNotEmpty
                    ? infoWidget(ImagesModel.websiteIcons, pageProvider.pageDetailsModel.website!, const SizedBox.shrink())
                    : const SizedBox.shrink(),
                SizedBox(height: pageProvider.pageDetailsModel.website!.isEmpty ? 0 : 10),
                pageProvider.pageDetailsModel.contact!.isNotEmpty
                    ? infoWidget(ImagesModel.callIcons, pageProvider.pageDetailsModel.contact!, const SizedBox.shrink())
                    : const SizedBox.shrink(),
                SizedBox(height: pageProvider.pageDetailsModel.contact!.isEmpty ? 0 : 10),
                pageProvider.pageDetailsModel.address!.isNotEmpty
                    ? infoWidget(ImagesModel.locationIcons, pageProvider.pageDetailsModel.address!, const SizedBox.shrink())
                    : const SizedBox.shrink(),
                const SizedBox(height: 10),
                InkWell(
                    onTap: () {
                      if (pageProvider.pageDetailsModel.address!.isEmpty) {
                        showMessage(message: 'There is no address');
                      }
                    },
                    child: infoWidget(
                        ImagesModel.directionIcons, "", Text('Get Directions', style: robotoStyle800ExtraBold.copyWith(fontSize: 15)))),
                const SizedBox(height: 12),
                const Divider(thickness: 1.8, color: Color(0xffE4E6EB)),
                Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text("Descriptions", style: robotoStyle700Bold.copyWith(fontSize: 17))),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                      pageProvider.pageDetailsModel.description!.isNotEmpty
                          ? pageProvider.pageDetailsModel.description!
                          : "There has no description",
                      style: robotoStyle400Regular.copyWith(fontSize: 12),
                      textAlign: TextAlign.justify),
                ),
                const Divider(thickness: 1.8, color: Color(0xffE4E6EB)),
                const SizedBox(height: 2),
                Padding(
                    padding: const EdgeInsets.only(left: 15), child: Text("Page Info", style: robotoStyle700Bold.copyWith(fontSize: 17))),
                const SizedBox(height: 10),
                pageProvider.pageDetailsModel.author!.fullName!.isNotEmpty
                    ? infoWidget(
                        ImagesModel.adminIcons,
                        pageProvider.pageDetailsModel.author!.fullName!,
                        Text('Admin - ${pageProvider.pageDetailsModel.author!.fullName!}',
                            style: robotoStyle800ExtraBold.copyWith(fontSize: 15)))
                    : const SizedBox.shrink(),
                const SizedBox(height: 10),
                infoWidget(ImagesModel.dateIcons, DateConverter.localDateToString(pageProvider.pageDetailsModel.createdAt!),
                    Text('Created Date - ', style: robotoStyle800ExtraBold.copyWith(fontSize: 15))),
                const SizedBox(height: 10),
              ],
            );
    });
  }

  Widget infoWidget(String imageURL, String title, Widget widget) {
    return Padding(
      padding: const EdgeInsets.only(left: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 20,
            width: 20,
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(color: AppColors.primaryColorLight, shape: BoxShape.circle),
            child: SvgPicture.asset(imageURL, height: 13, width: 13),
          ),
          const SizedBox(width: 2),
          widget,
          const SizedBox(width: 2),
          Expanded(child: Text(title, style: robotoStyle400Regular.copyWith(fontSize: 14)))
        ],
      ),
    );
  }
}
