

import 'package:flutter/material.dart';
import 'package:serial_generator/view/home.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: false),
      home: const HomePage(),
    );
  }
}






