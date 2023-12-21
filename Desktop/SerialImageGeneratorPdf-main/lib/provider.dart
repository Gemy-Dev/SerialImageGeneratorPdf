import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  static AppProvider instance = internal;
  static final internal = AppProvider._();
  AppProvider._();
  int serialCount = 10;
  double ratio = 1;
  int _serialNumber = 20000;
  void updateRatio(double ratio) {
    this.ratio = ratio;
    notifyListeners();
  }

  updateSerialNumber(int number) {
    _serialNumber=_serialNumber+number;
    notifyListeners();
  }
void updateSirealCount(int number){
  serialCount=number;
  notifyListeners();
}
  setSerial(int serial) {
    _serialNumber = serial;
    notifyListeners();
  }
  setCount(int count) {
    serialCount = count;
    notifyListeners();
  }

  get serial => _serialNumber;

  TextStyle style = const TextStyle(
      fontSize: 20, fontWeight: FontWeight.w700, color: Colors.red);

  updateTextStyle({double? fontSize, FontWeight? fontWight, Color? color}) {
    style = TextStyle(
        color: color ?? style.color,
        fontSize: fontSize ?? style.fontSize,
        fontWeight: fontWight ??style.fontWeight
           );
    notifyListeners();
  }
}