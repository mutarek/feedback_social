import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget customNetworkImage(BuildContext context, String imageUrl, {double? height, BoxFit boxFit = BoxFit.fill}) {
  return CachedNetworkImage(
    imageUrl: imageUrl,
    fit: boxFit,
    width: MediaQuery.of(context).size.width,
    height: height == 0 ? MediaQuery.of(context).size.height : height,
    errorWidget: (context, url, error) => const Icon(Icons.error),
    placeholder: ((context, url) => Container(alignment: Alignment.center, child: const CupertinoActivityIndicator())),
  );
}

Widget zoomableCustomNetworkImage(BuildContext context, String imageUrl, {double? height}) {
  return ExtendedImage.network(
    imageUrl,
    cache: true,
    height: height == 0 ? MediaQuery.of(context).size.height : height,
    mode: ExtendedImageMode.gesture,
    initGestureConfigHandler: (state) {
      return GestureConfig(
        minScale: 0.9,
        animationMinScale: 0.7,
        maxScale: 3.0,
        animationMaxScale: 3.5,
        speed: 1.0,
        inertialSpeed: 100.0,
        initialScale: 1.0,
        inPageView: false,
        initialAlignment: InitialAlignment.center,
      );
    },
    loadStateChanged: (ExtendedImageState state) {
      switch (state.extendedImageLoadState) {
        case LoadState.loading:
          Image.asset("assets/logo/logo.jpeg", fit: BoxFit.fill);
          break;
        case LoadState.completed:
          ExtendedRawImage(image: state.extendedImageInfo?.image);
          break;
        case LoadState.failed:
          GestureDetector(
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Image.asset("assets/failed.jpg", fit: BoxFit.fill),
                const Positioned(
                    bottom: 0.0, left: 0.0, right: 0.0, child: Text("load image failed, click to reload", textAlign: TextAlign.center))
              ],
            ),
            onTap: () {
              state.reLoadImage();
            },
          );
          break;
      }
    },
  );
}

Widget customNetworkImage2(BuildContext context, String imageUrl, {double? height, BoxFit boxFit = BoxFit.fill}) {
  return ExtendedImage.network(
    imageUrl,
    cache: true,
    width: MediaQuery.of(context).size.width,
    height: height == 0 ? MediaQuery.of(context).size.height : height,
    matchTextDirection: true,
    mode: ExtendedImageMode.none,
    fit: boxFit,
    loadStateChanged: (ExtendedImageState state) {
      switch (state.extendedImageLoadState) {
        case LoadState.loading:
          const CupertinoActivityIndicator();
          break;
        case LoadState.completed:
          ExtendedRawImage(image: state.extendedImageInfo?.image);
          break;
        case LoadState.failed:
          GestureDetector(
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Image.asset("assets/failed.jpg", fit: BoxFit.fill),
                const Positioned(
                    bottom: 0.0, left: 0.0, right: 0.0, child: Text("load image failed, click to reload", textAlign: TextAlign.center))
              ],
            ),
            onTap: () {
              state.reLoadImage();
            },
          );
          break;
      }
    },
  );
}

Widget circularImage(String imageUrl) {
  return CachedNetworkImage(
      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      imageBuilder: (context, imageProvider) => Container(
          width: 60.0,
          height: 60.0,
          decoration: BoxDecoration(shape: BoxShape.circle, image: DecorationImage(image: imageProvider, fit: BoxFit.contain))),
      fit: BoxFit.contain,
      imageUrl: imageUrl);
}
