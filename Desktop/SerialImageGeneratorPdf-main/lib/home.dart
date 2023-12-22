import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/pdf.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:serial_generator/app_sizes.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:serial_generator/model.dart';
import 'package:serial_generator/provider.dart';
import 'package:serial_generator/side_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? image;
  List<TextData> textDataList = [];
  List<TextData> textDataList2 = [];
  Size imageSize = const Size(400, 400);
  final provider = AppProvider.instance;
  final painterKey = GlobalKey();
  bool isLoading = false;
  bool isDouble = false;
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Serial PDF Generator'),
      ),
      body: Row(
        children: [
          SizedBox(
            width: _size.width - 300,
            height: _size.height,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                image == null
                    ? const Center(
                        child: Icon(Icons.image),
                      )
                    : RepaintBoundary(
                        key: painterKey,
                        child: ListenableBuilder(
                            listenable: provider,
                            builder: (context, _) {
                              final size = AppSizes.calculateSizeAndRatio(
                                  screen: Size(
                                      _size.width - 300, _size.height - 56),
                                  canvas: imageSize);
                              provider.ratio = size.sizeRatio;

                              return SizedBox(
                                  width: size.size.width,
                                  height: size.size.height,
                                  child: Stack(
                                      alignment: Alignment.topLeft,
                                      children: [
                                        Image.file(
                                          image!,
                                        ),
                                        ...textDataList.map((e) {
                                          int index = textDataList.indexOf(e);
                                          e.text = ((provider.serial +
                                                  ((provider.serialCount *
                                                              textDataList
                                                                  .length *
                                                              index) ~/
                                                          textDataList.length)
                                                      .toInt()))
                                              .toString();
                                          return Positioned(
                                              top: e.position.dy,
                                              left: e.position.dx,
                                              child: GestureDetector(
                                                onPanUpdate: (details) {
                                                  setState(() {
                                                    e.position = Offset(
                                                      e.position.dx +
                                                          details.delta.dx,
                                                      e.position.dy +
                                                          details.delta.dy,
                                                    );
                                                  });
                                                },
                                                child: Text(
                                                  e.text.padLeft(provider.serialLength,"0"),
                                                  style: provider.style,
                                                ),
                                              ));
                                        }).toList(),
                                        if (isDouble)
                                          ...textDataList2.map((e) {
                                            int index =
                                                textDataList2.indexOf(e);
                                            e.text = ((provider.serial +
                                                    ((provider.serialCount *
                                                                textDataList2
                                                                    .length *
                                                                index) ~/
                                                            textDataList2
                                                                .length)
                                                        .toInt()))
                                                .toString();
                                            return Positioned(
                                                top: e.position.dy,
                                                left: e.position.dx,
                                                child: GestureDetector(
                                                  onPanUpdate: (details) {
                                                    setState(() {
                                                      e.position = Offset(
                                                        e.position.dx +
                                                            details.delta.dx,
                                                        e.position.dy +
                                                            details.delta.dy,
                                                      );
                                                    });
                                                  },
                                                  child: Text(
                                                    e.text.padLeft(provider.serialLength,"0"),
                                                    style: provider.style,
                                                  ),
                                                ));
                                          }).toList()
                                      ]));
                            })),
              ],
            ),
          ),
          Container(
              width: 300,
              color: Colors.grey.shade100,
              padding: const EdgeInsets.all(20),
              height: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: const Text('Pick Image'),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                      child: SideBar(
                    add: _addSerialToScreen,
                    remove: _removeSerialFromScreen,
                    isDouble: isDouble,
                    updateDouble: updateDoubleText,
                  )),
                  ElevatedButton(
                    onPressed: () async {
                      if (image != null &&
                          !isLoading &&
                          textDataList.isNotEmpty) {
                        setState(() {
                          isLoading = true;
                        });
                        await _generatePdf(
                            provider: provider, length: textDataList.length);
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                    child: isLoading
                        ? CircularProgressIndicator(
                            color: Colors.amber.shade100,
                            strokeWidth: 2,
                          )
                        : Text('Generate PDF'),
                  ),
                ],
              ))
        ],
      ),
    );
  }

  void _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);

        textDataList.clear(); // Reset text data on new image
      });

      final img = await convertUint8ListToUiImage(image!.readAsBytesSync());
      setState(() {
        imageSize = Size(img.width.toDouble(), img.height.toDouble());
      });
    }
  }

  Future<Uint8List?> renderImage() async {
    try {
      RenderRepaintBoundary boundary = painterKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: provider.ratio);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      return pngBytes;
    } catch (e) {
      print("Error converting widget to image: $e");
      return null;
    }
  }

  Future<ui.Image> convertUint8ListToUiImage(Uint8List uint8list) async {
    var codec = await ui.instantiateImageCodec(uint8list);
    var frameInfo = await codec.getNextFrame();
    return frameInfo.image;
  }

  Future<void> _generatePdf(
      {required AppProvider provider, required int length}) async {
    final pdf = pw.Document();

    for (int i = 0; i < provider.serialCount; i++) {
      provider.updateSerialNumber(1);

      final imageBytes = await renderImage();

      if (imageBytes == null) return;
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
    try {
      var status = await Permission.storage.status;
      if (status.isDenied) {
        await Permission.storage.request();
      }
      final outputDirectory = await getSaveLocation();
      if (outputDirectory == null) return;
      final outputFile = File('${outputDirectory.path}.pdf');
      await outputFile.writeAsBytes(Uint8List.fromList(await pdf.save()));
      print(outputFile.path);
      // Open the generated PDF using the default PDF viewer
      //await Process.run('open', [outputFile.path]);
      if (context.mounted) {
        showDialog(
            context: context,
            builder: (
              context,
            ) =>
                AlertDialog(
                  content:
                      SelectableText('PDF File saved in : ${outputFile.path}'),
                ));
      }
    } catch (e) {
      if (context.mounted) {
        showDialog(
            context: context,
            builder: (
              context,
            ) =>
                AlertDialog(
                  content: SelectableText(e.toString()),
                ));
      }
    }
  }

  void _addSerialToScreen() {
    if (image != null) {
      final textData = TextData(
        text: '${provider.serial}',
        position: const Offset(50, 50),
      );
      final textData2 = TextData(
        text: '${provider.serial}',
        position: const Offset(0, 50),
      );
      setState(() {
        textDataList.add(textData);
        textDataList2.add(textData2);
      });
    }
  }

  void _removeSerialFromScreen() {
    if (image != null && textDataList.isNotEmpty && textDataList2.isNotEmpty) {
      setState(() {
        textDataList.removeLast();
        textDataList2.removeLast();
      });
    }
  }

  void updateDoubleText(value) {
    setState(() {
      isDouble = value;
    });
  }
}
