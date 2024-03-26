import 'dart:io';
import 'dart:typed_data';
import 'dart:ui'as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:serial_generator/core/utility/extentions.dart';


class Images extends ChangeNotifier{
final double ratio;

  Images(this.ratio);

File? image;
 Size imageSize=const Size(400, 400);

   Future<Uint8List?> renderImage(GlobalKey painterKey,) async {
    try {
      RenderRepaintBoundary boundary = painterKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio : ratio);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      return pngBytes;
    } catch (e) {
     
     throw Exception("Can't render Image");
    }
  }

    Future<void> pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
    
        image = File(pickedImage.path);
     //   textDataList.clear(); // Reset text data on new image
    

      final img = await image!.readAsBytesSync().convertUint8ListToUiImage();
    
        imageSize = Size(img.width.toDouble(), img.height.toDouble());
notifyListeners();
    
    }
  }
}