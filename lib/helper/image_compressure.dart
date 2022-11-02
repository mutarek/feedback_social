import 'dart:io';

import 'package:flutter_native_image/flutter_native_image.dart';

Future<File> imageCompressed({required File imagePathToCompress, quality = 100, percentage = 30}) async {
  var path = await FlutterNativeImage.compressImage(imagePathToCompress.absolute.path, quality: quality, percentage: percentage);
  return path;
}
