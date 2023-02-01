import 'package:als_frontend/provider/page_provider.dart';
import 'package:als_frontend/util/image.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PageAboutViewWidget extends StatefulWidget {
  const PageAboutViewWidget({Key? key}) : super(key: key);


  @override
  State<PageAboutViewWidget> createState() => _PageAboutViewWidgetState();
}

class _PageAboutViewWidgetState extends State<PageAboutViewWidget> {
  @override
  void initState() {
    Provider.of<PageProvider>(context, listen: false).pageDetails(1);
    super.initState();
  }
  @override

  Widget build(BuildContext context) {
    return Consumer<PageProvider>(

      builder: (context, pageProvider,child) {
        return pageProvider.isLoadingPageDetails?const Center(child: CircularProgressIndicator()):Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 18),
              child: Text("Intro", style: GoogleFonts.roboto(fontWeight: FontWeight.w700, fontSize: 15, color: AppColors.primaryColorLight)),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 18),
                child:Text(
                  pageProvider.pageDetailsList!.bio.toString(),
                  style: GoogleFonts.roboto(fontWeight: FontWeight.w400, fontSize: 12, color: AppColors.primaryColorLight),
                )
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
            pageProvider.pageDetailsList!.category!.isNotEmpty? infoWidget(ImagesModel.categoryIcons, "news & media website", Text('Category - ${pageProvider.pageDetailsList!.category}', style: robotoStyle800ExtraBold.copyWith(fontSize: 15))):const SizedBox.shrink(),
            const SizedBox(height: 10),
            pageProvider.pageDetailsList!.email!.isNotEmpty?infoWidget(ImagesModel.emailIcons,pageProvider.pageDetailsList!.email!,const SizedBox.shrink()):const SizedBox.shrink(),
            const SizedBox(height: 10),
            pageProvider.pageDetailsList!.website!.isNotEmpty?infoWidget(ImagesModel.websiteIcons, pageProvider.pageDetailsList!.website!, const SizedBox.shrink()):const SizedBox.shrink(),
            const SizedBox(height: 10),
            pageProvider.pageDetailsList!.contact!.isNotEmpty?infoWidget(ImagesModel.callIcons, pageProvider.pageDetailsList!.contact!, const SizedBox.shrink()):const SizedBox.shrink(),
            const SizedBox(height: 10),
            pageProvider.pageDetailsList!.address!.isNotEmpty?infoWidget(ImagesModel.locationIcons, pageProvider.pageDetailsList!.address!,
                const SizedBox.shrink()):  const SizedBox.shrink(),
            const SizedBox(height: 10),
            infoWidget(ImagesModel.directionIcons, "", Text('Get Directions', style: robotoStyle800ExtraBold.copyWith(fontSize: 15))),
            const SizedBox(height: 12),
            const Divider(thickness: 1.8, color: Color(0xffE4E6EB)),
            Padding(padding: const EdgeInsets.only(left: 15), child: Text("Descriptions", style: robotoStyle700Bold.copyWith(fontSize: 17))),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                pageProvider.pageDetailsList!.description!,
                style: robotoStyle400Regular.copyWith(fontSize: 12),
                textAlign: TextAlign.justify,
              ),
            ),
            const Divider(thickness: 1.8, color: Color(0xffE4E6EB)),
            const SizedBox(height: 2),
            Padding(padding: const EdgeInsets.only(left: 15), child: Text("Page Info", style: robotoStyle700Bold.copyWith(fontSize: 17))),
            const SizedBox(height: 10),
            pageProvider.pageDetailsList!.author!.fullName!.isNotEmpty?infoWidget(ImagesModel.adminIcons, pageProvider.pageDetailsList!.author!.fullName!, Text('Admin - ', style: robotoStyle800ExtraBold.copyWith(fontSize: 15))):const SizedBox.shrink(),
            const SizedBox(height: 10),
            infoWidget(ImagesModel.dateIcons, "${pageProvider.pageDetailsList!.createdAt!} day ago", Text('Created Date - ', style: robotoStyle800ExtraBold.copyWith(fontSize: 15))),
            const SizedBox(height: 10),
          ],
        );
      }
    );
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
