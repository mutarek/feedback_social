import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnyListPreview extends StatefulWidget {
  AnyListPreview(this.url, {Key? key}) : super(key: key);

  List url = [];

  @override
  State<AnyListPreview> createState() => _AnyListPreviewState();
}

class _AnyListPreviewState extends State<AnyListPreview> {

  @override
  void initState() {
    _getMetadata(widget.url.isEmpty?"https://feedback-social.com/":widget.url[widget.url.length-1]);
    super.initState();
  }

  void _getMetadata(String url) async {
    bool _isValid = _getUrlValid(url);
    if (_isValid) {
      Metadata? _metadata = await AnyLinkPreview.getMetadata(
        link: url,
        cache: Duration(days: 7),
        proxyUrl: "https://cors-anywhere.herokuapp.com/", // Needed for web app
      );
      debugPrint("URL6 => ${_metadata?.title}");
      debugPrint(_metadata?.desc);
    } else {
      debugPrint("URL is not valid");
    }
  }

  bool _getUrlValid(String url) {
    bool _isUrlValid = AnyLinkPreview.isValidLink(
      url,
      protocols: ['http', 'https'],
    );
    return _isUrlValid;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AnyLinkPreview(
        onTap: (){
          Get.snackbar("Web", "You clicked on url",snackPosition: SnackPosition.BOTTOM);
        },
        link: widget.url.isEmpty?"https://feedback-social.com/":widget.url[widget.url.length-1],
        displayDirection: UIDirection.uiDirectionHorizontal,
        showMultimedia: true,
        bodyMaxLines: 5,
        bodyTextOverflow: TextOverflow.ellipsis,
        titleStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
        bodyStyle: TextStyle(color: Colors.grey, fontSize: 12),
      ),
    );
  }
}