
import 'package:flutter/material.dart';
import 'package:serial_generator/provider/provider.dart';

import '../core/utility/app_sizes.dart';
class ImageScreen extends StatefulWidget {
  const ImageScreen(
      {super.key,

      required this.painterKey,

    });

  final GlobalKey painterKey;


 
  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  final provider=AppProvider.instance;

  GlobalKey get painterKey => widget.painterKey;

  //File? get image => provider.image;





 
  

  @override
  Widget build(BuildContext context) {
    final size0 = MediaQuery.of(context).size;
    return
     SizedBox(
      width: size0.width - 300,
      height: size0.height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          provider.image == null
              ? const Center(
                  child: Icon(Icons.image),
                )
              : RepaintBoundary(
                  key: painterKey,
                  child: ListenableBuilder(
                      listenable: provider,
                      builder: (context, provide) {
                        final size = AppSizes.calculateSizeAndRatio(
                            screen: Size(size0.width - 300, size0.height - 56),
                            canvas: provider.imageSize);
                       provider.ratio = size.sizeRatio;

                        return SizedBox(
                            width: size.size.width,
                            height: size.size.height,
                            child:
                                Stack(alignment: Alignment.topLeft, children: [
                              Image.file(
                                provider.image!,
                              ),
                              ...provider.textDataList.map((e) {
                                int index = provider.textDataList.indexOf(e);
                                e.text = ((provider.serial +
                                        ((provider.serialCount *
                                                    provider.textDataList.length *
                                                    index) ~/
                                                provider.textDataList.length)
                                            .toInt()))
                                    .toString();
                                return Positioned(
                                    top: e.position.dy,
                                    left: e.position.dx,
                                    child: GestureDetector(
                                      onPanUpdate: (details) {
                                        setState(() {
                                          e.position = Offset(
                                            e.position.dx + details.delta.dx,
                                            e.position.dy + details.delta.dy,
                                          );
                                        });
                                      },
                                      child: Text(
                                        e.text.padLeft(
                                            provider.serialLen, "0"),
                                        style: provider.style,
                                      ),
                                    ));
                              }),
                              if (provider.isDouble)
                                ...provider.textDataList2.map((e) {
                                  int index = provider.textDataList2.indexOf(e);
                                  e.text = ((provider.serial +
                                          ((provider.serialCount *
                                                      provider.textDataList2.length *
                                                      index) ~/
                                                  provider.textDataList2.length)
                                              .toInt()))
                                      .toString();
                                  return Positioned(
                                      top: e.position.dy,
                                      left: e.position.dx,
                                      child: GestureDetector(
                                        onPanUpdate: (details) {
                                          setState(() {
                                            e.position = Offset(
                                              e.position.dx + details.delta.dx,
                                              e.position.dy + details.delta.dy,
                                            );
                                          });
                                        },
                                        child: Text(
                                          e.text.padLeft(
                                              provider.serialLen, "0"),
                                          style: provider.style,
                                        ),
                                      ));
                                })
                            ]));
                      })),
        ],
      ),
    );
  }
}
