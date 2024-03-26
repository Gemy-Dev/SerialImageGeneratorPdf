import 'dart:io';

import 'package:flutter/material.dart';
import 'package:serial_generator/provider/images.dart';
import 'package:serial_generator/provider/serials_manager.dart';

import '../model/model.dart';

class AppProvider extends ChangeNotifier {

  static AppProvider instance = internal;
  static final internal = AppProvider._();
  AppProvider._();

  double  ratio = 1;

final imageManger=Images(1);
final serialManger=SerialManger();
 // int serialCount = 10;
int get serial=>serialManger.serial;
int get serialCount=>serialManger.serialCount;
  Size get imageSize =>imageManger.imageSize ;
   int get serialLen=>serialManger.serialLength;
  File? get  image => imageManger.image;
  List<TextData> get textDataList => serialManger.textDataList;
bool get isDouble=>serialManger.isDouble;
  List<TextData> get textDataList2 => serialManger.textDataList2;
  void updateRatio(double ratio) {
    this.ratio = ratio;
    notifyListeners();
  }

void  updateSerialNumber(int number) {
  serialManger.updateSerialNumber(number);
    notifyListeners();
  }

  void updateSirealCount(int number) {
   serialManger.updateSirealCount(number);
    notifyListeners();
  }

  setSerial(String serial) {
  serialManger.setSerial(serial);
    notifyListeners();
  }

  setCount(int count) {
 serialManger.setCount(count);
    notifyListeners();
  }
void addSerialToScreen(){
  if(image==null) return;
  serialManger.addSerialToScreen();
  notifyListeners();
}
void removeSerialFromScreen(){
  serialManger.removeSerialFromScreen();
  notifyListeners();
}

Future<void> pickImage()async{
 await imageManger.pickImage();
  notifyListeners();
}

void updateDouble(){
  serialManger.updateDoubleSerial();
  notifyListeners();
}

  TextStyle style = const TextStyle(
      fontSize: 20, fontWeight: FontWeight.w700, color: Colors.red);

  updateTextStyle({double? fontSize, FontWeight? fontWight, Color? color}) {
    style = TextStyle(
        color: color ?? style.color,
        fontSize: fontSize ?? style.fontSize,
        fontWeight: fontWight ?? style.fontWeight);
    notifyListeners();
  }
}
