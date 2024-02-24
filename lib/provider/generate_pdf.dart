import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:file_selector/file_selector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:serial_generator/core/either/either.dart';
import 'package:serial_generator/provider/provider.dart';
class PdfGenerator{
  final AppProvider provider;

  PdfGenerator({required this.provider});
  

 

  Future<Either<String,String>> generatePdf(
      { required GlobalKey painterKey}) async {
    final pdf = pw.Document();
try {
     for (int i = 0; i < provider.serialCount; i++) {
      provider.updateSerialNumber(1);

      final imageBytes = await Images().renderImage(painterKey);

      if (imageBytes == null) return Either.left('Can\'t get image');
      final imageProvider = pw.MemoryImage(
        imageBytes,
      );

      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (context) {
            final imgWidth = PdfPageFormat.a4.width;
            final imgHeight = PdfPageFormat.a4.height;
            return pw.Center(
                child: pw.Image(
              imageProvider,
              alignment: pw.Alignment.topLeft,
              width: imgWidth,
              height: imgHeight,
            ));
          }));
    }
    // Check and request permission if needed
 final result= await compute((message)async =>await  pdf.save(), Uint8List) ;
   
 
 await    Service().saveFileToLocation(Uint16List.fromList(result));
 return Either.right('Pdf Saved Successfully');

} catch (e) {
 return Either.left(e.toString());
}
 
    
    
      
    
  }


 
}

class Service{
Future<FileSaveLocation?>  _getLocation()async{
    try {
        var status = await Permission.storage.status;
      if (status.isDenied) {
        await Permission.storage.request();
      }
      final outputDirectory = await getSaveLocation();
      
      return outputDirectory;
    } catch (e) {
      throw (" can't access to location");
    }
  }
  saveFileToLocation(List<int>byteData)async{
try {
  String?path;
  if(Platform.isMacOS){
path=await getSaveLocation().then((value) => value?.path);
  }else{

  final location=await _getLocation();
    path=location?.path;
  }
  print(path);
  if(path !=null){

      final outputFile = File('${path}.pdf');
      await outputFile.writeAsBytes(byteData);
  }else{

  throw Exception('Can\'t Save Pdf to Location');
  }
} catch (e) {
  throw Exception('Can\'t Save Pdf to Location');
}
  }
}

class Images{
  final  provider=AppProvider.instance;

   Future<Uint8List?> renderImage(GlobalKey painterKey,) async {
    try {
      RenderRepaintBoundary boundary = painterKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: provider.ratio);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      return pngBytes;
    } catch (e) {
     
     throw Exception("Can't render Image");
    }
  }

  
}