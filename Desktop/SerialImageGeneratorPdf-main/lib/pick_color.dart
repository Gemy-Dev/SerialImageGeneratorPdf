
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

class PickColor extends StatelessWidget {
  const PickColor(  {required this.color, required this.pickedColor,this.position=PreferredPosition.bottom,required this.removeColor, 
    super.key,
   
  });

final PreferredPosition? position;
final Color color;
final Function (Color) pickedColor;
final VoidCallback  removeColor;
  @override
  Widget build(BuildContext context, ) {
 
    print('reed');

    return Row(
          children: [const Text('Select Color'),
            Stack(
                alignment: Alignment.center,
                children: [
                 
                  InkWell(
                 
                    child: Icon(Icons.rectangle_rounded,size: 42, color: color,)
                  
                  ),
                  
                    CustomPopupMenu(
                        horizontalMargin: 10,
                        position: position,
                        menuBuilder: () => Container(
                           color:Colors.white,
                            width: 250,height: 430,
                            child: ColorPicker(color: color,
                            recentColors: const [Colors.transparent],
                            width: 32,height: 32,
                              padding: const EdgeInsets.all(5),
                              //    wheelDiameter: 120,
                              opacitySubheading: const Text('Opacity'),
                              borderRadius: 5,
                             enableOpacity: true,
                          opacityThumbRadius: 12,opacityTrackHeight: 20,
                              pickersEnabled: const {
                                ColorPickerType.primary: true,
                                ColorPickerType.accent: true,
                                ColorPickerType.custom: true,
                                ColorPickerType.wheel: true,
                              },
    
                            
    
                              onColorChangeEnd: pickedColor, onColorChanged: (Color value) {  },
                            )),
                        pressType: PressType.singleClick,
                        child: const SizedBox(
                          width: 40,
                          height: 40,
                        ))
                ],
              ),
          ],
        );
  }
}

Future<void> colorPicker(context, Function(Color) callBack) async =>
    await showDialog(
        context: context,
        builder: (ctx) => SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AlertDialog(
                    content: StatefulBuilder(builder: (context, setState) {
                      return ColorPicker(
                        padding: const EdgeInsets.all(5),
                        //    wheelDiameter: 120,
                        opacitySubheading: const Text('Opacity'),
                        borderRadius: 50,
                        opacityTrackHeight: 20,
                        enableOpacity: true,
                        enableTooltips: true,
                        pickersEnabled: const {
                          ColorPickerType.primary: true,
                          ColorPickerType.accent: true,
                          ColorPickerType.custom: true,
                          ColorPickerType.wheel: true,
                        },

                        // selectedPickerTypeColor: currenColor,
                        actionButtons: const ColorPickerActionButtons(
                            alignment: Alignment.bottomRight,
                            constraints: BoxConstraints(maxHeight: 100),
                            okButton: false,
                            closeButton: true,
                            dialogActionButtons: true,
                            dialogActionIcons: true,
                            dialogCancelButtonType:
                                ColorPickerActionButtonType.text,
                            dialogOkButtonType:
                                ColorPickerActionButtonType.outlined),

                        onColorChanged: callBack,
                      );
                    }),
                  ),
                ],
              ),
            ));