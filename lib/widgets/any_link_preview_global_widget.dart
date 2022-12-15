import 'package:als_frontend/helper/open_call_url_map_sms_helper.dart';
import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';

class AnyLinkPreviewGlobalWidget extends StatefulWidget {
  AnyLinkPreviewGlobalWidget(this.url,this.height,this.width,this.radius, {Key? key}) : super(key: key);
  double height;
  double width;
  double radius;
  List url = [];

  @override
  State<AnyLinkPreviewGlobalWidget> createState() => _AnyListPreviewState();
}

class _AnyListPreviewState extends State<AnyLinkPreviewGlobalWidget> {

  @override
  void initState() {
    _getMetadata(widget.url.isEmpty?"https://feedback-social.com/":widget.url[widget.url.length-1]);
    super.initState();
  }

  void _getMetadata(String url) async {
    bool isValid = _getUrlValid(url);
    if (isValid) {
      Metadata? metadata = await AnyLinkPreview.getMetadata(
        link: url,
        cache: const Duration(days: 7),
        proxyUrl: "https://cors-anywhere.herokuapp.com/", // Needed for web app
      );
      debugPrint("URL6 => ${metadata?.title}");
      debugPrint(metadata?.desc);
    } else {
      debugPrint("URL is not valid");
    }
  }

  bool _getUrlValid(String url) {
    bool isUrlValid = AnyLinkPreview.isValidLink(
      url,
      protocols: ['http', 'https'],
    );
    return isUrlValid;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      height: widget.height,
      width: widget.width,
      child: AnyLinkPreview(
        onTap: (){
          openNewLink(widget.url[widget.url.length-1]);
        },
        borderRadius: widget.radius,
        errorBody: "Ops! Not Found",
        errorTitle: "Ops! Not Found",
        link: widget.url.isEmpty?"https://feedback-social.com/":widget.url[widget.url.length-1],
        displayDirection: UIDirection.uiDirectionHorizontal,
        showMultimedia: true,
        bodyMaxLines: 2,
        bodyTextOverflow: TextOverflow.ellipsis,
        titleStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
        bodyStyle: const TextStyle(color: Colors.grey, fontSize: 12),
      ),
    );
  }
}
