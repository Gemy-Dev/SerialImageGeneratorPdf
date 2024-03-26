import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:serial_generator/provider/generate_pdf.dart';
import 'package:serial_generator/provider/provider.dart';
import 'package:serial_generator/view/editing_menu.dart';
import 'package:serial_generator/view/image_screen.dart';
import 'package:serial_generator/widgets/side_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? image;
  final provider = AppProvider.instance;



  final painterKey = GlobalKey();

  bool isDouble = false;


  @override
  Widget build(BuildContext context) {
 
 
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Serial PDF Generator'),
      ),
      body: ListenableBuilder(listenable: provider,
        builder: (context,_) {
          return Row(
            children: [
              ImageScreen(painterKey: painterKey,  ),
          EditingMenu(printerKey: painterKey)
            ],
          );
        }
      ),
    );
  }


}
