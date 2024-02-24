import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  static AppProvider instance = internal;
  static final internal = AppProvider._();
  AppProvider._();
  int serialCount = 10;
  double ratio = 1;
  int _serialNumber = 00001;
  int serialLength = 5;
  void updateRatio(double ratio) {
    this.ratio = ratio;
    notifyListeners();
  }

  updateSerialNumber(int number) {
    _serialNumber = _serialNumber + number;
    notifyListeners();
  }

  void updateSirealCount(int number) {
    serialCount = number;
    notifyListeners();
  }

  setSerial(String serial) {
    _serialNumber = int.tryParse(serial) ?? 0;
    serialLength = serial.length;

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
        fontWeight: fontWight ?? style.fontWeight);
    notifyListeners();
  }
}
