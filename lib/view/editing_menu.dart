import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:serial_generator/provider/provider.dart';

import '../provider/generate_pdf.dart';
import '../widgets/side_bar.dart';

class EditingMenu extends StatefulWidget {
   const EditingMenu({super.key, required this.printerKey});
final GlobalKey printerKey;
  @override
  State<EditingMenu> createState() => _EditingMenuState();
}

class _EditingMenuState extends State<EditingMenu> {
final provider=AppProvider.instance;
GlobalKey get painterKey=>widget.printerKey;
bool isDouble=false;
  @override
  Widget build(BuildContext context) {
    return     Container(
                  width: 300,
                  color: Colors.grey.shade100,
                  padding: const EdgeInsets.all(20),
                  height: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed:()async=> await provider.pickImage() ,
                        child: const Text('Pick Image'),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                          child: SideBar(
                        add: provider.addSerialToScreen,
                        remove: provider.removeSerialFromScreen,
                 
                      )),
                      ElevatedButton(
                        onPressed: () async {
                          if (provider.image != null &&
                             
                             provider. textDataList.isNotEmpty) {
            _showLoadingDialog(context);
           
          ///
                            final result = await PdfGenerator(provider: provider)
                                .generatePdf(painterKey: painterKey);
                                ///
                            final message = result.fold((left)=> left
                            , (right) => right
                            );
          
          ///
                            if (context.mounted) {
                              Navigator.pop(context);
                              showDialog(
                                  context: context,
                                  builder: (
                                    context,
                                  ) =>
                                      AlertDialog(
                                        content: SelectableText(message.toString()),
                                      ));
                            }
          
                           
                          }
                        },
                        child:const Text('Generate PDF'),
                      ),
                    ],
                  ));
  }

    Future<Object?> _showLoadingDialog(BuildContext context) {
    return showGeneralDialog(context: context,barrierDismissible: false,
                      pageBuilder:(_,anime1,anime2)=>  CupertinoAlertDialog(title:const Text('Please Wait ...'),
                        content:Container(padding: const EdgeInsets.symmetric(horizontal: 50),
                        constraints: const BoxConstraints(maxHeight: 200,maxWidth: 100),
                                              child: const LinearProgressIndicator()) ,),
                  );
  }

  void updateDoubleText(value) {
   setState(() {
      isDouble = value;
   });
  }
}