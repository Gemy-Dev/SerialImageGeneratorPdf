 import 'dart:typed_data';
import 'dart:ui'as ui;


  extension ConvertImage on Uint8List{
Future<ui.Image> convertUint8ListToUiImage() async {
    var codec = await ui.instantiateImageCodec(this);
    var frameInfo = await codec.getNextFrame();
    return frameInfo.image;
  }
  }