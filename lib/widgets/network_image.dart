import 'package:als_frontend/util/image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/cupertino.dart';

Widget customNetworkImage(BuildContext context, String imageUrl,
    {double? height, BoxFit boxFit = BoxFit.fill}) {
  return CachedNetworkImage(
    imageUrl: imageUrl,
    fit: boxFit,
    width: MediaQuery.of(context).size.width,
    height: height == 0 ? MediaQuery.of(context).size.height : height,
    cacheKey: imageUrl,
    cacheManager:
        CacheManager(Config(imageUrl, stalePeriod: const Duration(hours: 5))),
    errorWidget: (context, url, error) => const Icon(Icons.error),
    placeholder: ((context, url) => Center(
          child: Stack(
            children: [
              Shimmer.fromColors(
                  baseColor: Colors.black.withOpacity(.1),
                  highlightColor: Colors.grey.withOpacity(.1),
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                  )),
              Opacity(
                  opacity: 0.2,
                  child: Image.asset(ImagesModel.logo, height: 100, width: 100))
            ],
          ),
        )),
  );
}

Widget zoomableCustomNetworkImage(BuildContext context, String imageUrl,
    {double? height}) {
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
                Image.asset("assets/background/profile.png", fit: BoxFit.fill),
                // const Positioned(
                //     bottom: 0.0, left: 0.0, right: 0.0, child: Text("load image failed, click to reload", textAlign: TextAlign.center))
              ],
            ),
            onTap: () {
              state.reLoadImage();
            },
          );
          break;
      }
      return null;
    },
  );
}

Widget customNetworkImage2(BuildContext context, String imageUrl,
    {double? height, BoxFit boxFit = BoxFit.fill}) {
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
          Shimmer.fromColors(
              baseColor: Colors.black.withOpacity(.1),
              highlightColor: Colors.grey.withOpacity(.1),
              child: Container(
                height: 100,
                width: 100,
                color: Colors.red,
              ));
          // const CupertinoActivityIndicator();
          break;
        case LoadState.completed:
          ExtendedRawImage(image: state.extendedImageInfo?.image);
          break;
        case LoadState.failed:
          GestureDetector(
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Image.asset("assets/background/profile.png", fit: BoxFit.fill),
                // const Positioned(
                //     bottom: 0.0, left: 0.0, right: 0.0, child: Text("load image failed, click to reload", textAlign: TextAlign.center))
              ],
            ),
            onTap: () {
              state.reLoadImage();
            },
          );
          break;
      }
      return null;
    },
  );
}

Widget circularImage(String imageUrl, double height, double width) {
  return CachedNetworkImage(
      cacheKey: imageUrl,
      cacheManager:
          CacheManager(Config(imageUrl, stalePeriod: const Duration(hours: 5))),
      placeholder: (context, url) =>
          const Center(child: CupertinoActivityIndicator()),
      errorWidget: (context, url, error) => Image.asset(
          "assets/background/profile.png",
          fit: BoxFit.cover,
          width: height,
          height: width),
      imageBuilder: (context, imageProvider) => Container(
          width: height,
          height: width,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image:
                  DecorationImage(image: imageProvider, fit: BoxFit.contain))),
      fit: BoxFit.contain,
      imageUrl: imageUrl);
}
