import 'package:flutter/material.dart';
import 'package:serial_generator/widgets/pick_color.dart';
import 'package:serial_generator/provider/provider.dart';

import 'i_slider.dart';

class SideBar extends StatelessWidget {
  SideBar({
    super.key,
    required this.add,
    required this.remove,
    required this.updateDouble,
    required this.isDouble,
  });
  final VoidCallback add;
  final VoidCallback remove;
  final Function(bool) updateDouble;
  final bool isDouble;
  final provider = AppProvider.instance;
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: provider,
        builder: (context, pro) {
          return Column(children: [
            Row(
              children: [
          const      Text(
                  'Enter Serial No.',
                  style: style,
                ),
                Expanded(
                    child: SizedBox(
                  height: 40,
                  child: TextFormField(
                    onChanged: (value) {
                      if (value.isEmpty) value = '0';
                      provider.setSerial(value);
                    },
                    decoration: InputDecoration(
                        hintText: provider.serial.toString(),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        border: const OutlineInputBorder()),
                  ),
                )),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
           const     Text(
                  'Count Of Serials',
                  style: style,
                ),
                Expanded(
                    child: SizedBox(
                  height: 40,
                  child: TextFormField(
                    onChanged: (value) {
                      if (value.isEmpty) value = '0';
                      provider.setCount ( int.parse(value));
                    },
                    decoration: InputDecoration(
                        hintText: provider.serialCount.toString(),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        border: const OutlineInputBorder()),
                  ),
                )),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
                width: 300,
                child: ISlider(
                    max: 200,
                    title: 'Font Size',
                    value: provider.style.fontSize!,
                    onChanged: (value) {
                      provider.updateTextStyle(fontSize: value);
                    })),
            SizedBox(
                width: 300,
                child: ISlider(
                    max: 8,
                    min: 2,
                    title: 'Font Wight',
                    value: provider.style.fontWeight!.index.toDouble(),
                    onChanged: (value) {
                      provider.updateTextStyle(
                          fontWight: FontWeight.values[value!.toInt()]);
                    })),
            SizedBox(
              width: 300,
              height: 100,
              child: PickColor(
                  color: provider.style.color!,
                  pickedColor: (color) {
                    provider.updateTextStyle(color: color);
                  },
                  removeColor: () {}),
            ),
            SizedBox(
                height: 40,
                child: Row(
                  children: [
                 const   Text('Double Serial'),
                 const   Spacer(),
                    Checkbox(
                        value: isDouble,
                        onChanged: (value) => updateDouble(value!))
                  ],
                )),
              const  Divider(),
            ElevatedButton(
              onPressed: add,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
              child: const Text('Add Serial To Screen'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: remove,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Remove Serial From Screen'),
            )
          ]);
        });
  }
}

const style = TextStyle(fontWeight: FontWeight.w600);
