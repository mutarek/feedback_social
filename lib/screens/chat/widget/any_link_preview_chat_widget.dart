import 'package:als_frontend/helper/open_call_url_map_sms_helper.dart';
import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';

class AnyLinkPreviewChat extends StatefulWidget {
  AnyLinkPreviewChat(this.url, {Key? key}) : super(key: key);

  List url = [];

  @override
  State<AnyLinkPreviewChat> createState() => _AnyListPreviewState();
}

class _AnyListPreviewState extends State<AnyLinkPreviewChat> {

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
    return SizedBox(
      height: 50,
      width: 200,
      child: AnyLinkPreview(
        onTap: (){
          openNewLink(widget.url[widget.url.length-1]);
        },
        link: widget.url.isEmpty?"https://feedback-social.com/":widget.url[widget.url.length-1],
        displayDirection: UIDirection.uiDirectionHorizontal,
        showMultimedia: true,
        bodyMaxLines: 5,
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
