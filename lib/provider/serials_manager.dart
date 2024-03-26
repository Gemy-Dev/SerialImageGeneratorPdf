import 'package:flutter/material.dart';

import '../model/model.dart';

class SerialManger{
 int serialCount = 10;
int get serial=>_serialNumber;
 int _serialNumber = 00001;
 int serialLength = 5;
 bool isDouble=false;
    List<TextData> textDataList=[] ;
  List<TextData> textDataList2=[] ;
   void addSerialToScreen() {
   // if (image != null) {
      final textData = TextData(
        text: _serialNumber.toString(),
        position: const Offset(100, 50),
      );
      final textData2 = TextData(
        text: '$_serialNumber',
        position: const Offset(0, 50),
      );
   
        textDataList.add(textData);
        textDataList2.add(textData2);
   
    }
  

  void removeSerialFromScreen() {
if(textDataList.isEmpty)return;
        textDataList.removeLast();
        textDataList2.removeLast();
    
    }

    void  updateSerialNumber(int number) {
    _serialNumber = _serialNumber + number;

  }

  void updateSirealCount(int number) {
    serialCount = number;

  }

  setSerial(String serial) {
    _serialNumber = int.tryParse(serial) ?? 0;
    serialLength = serial.length;

  }

  setCount(int count) {
    serialCount = count;

  }
  void updateDoubleSerial(){
    isDouble=!isDouble;
  }

  }
