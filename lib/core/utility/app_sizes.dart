
import 'package:flutter/material.dart';


abstract class AppSizes {






  /// this method [getOrientation]  is chec if width > height return it landscap ...
  static OrientationMode getOrientation(Size size) {
    if (size.width > size.height) {
      return OrientationMode.landscap;
    } else if (size.width < size.height) {
      return OrientationMode.portrate;
    }
    return OrientationMode.square;
  }

  /// this method [getRatio] calculate  Ratio between width and height
  static double getRatio(Size size) {
    if (getOrientation(size) == OrientationMode.portrate) {
      return size.height / size.width;
    } else if (getOrientation(size) == OrientationMode.landscap) {
      return size.width / size.height;
    }
    return 1;
  }

  static CanvasSizeRatio calculateSizeAndRatio(
      {required Size screen, required Size canvas}) {
    /// if screen ratio > canvas ration we will use screen width const and change
    /// in screen height and ratio is used befour we extract image
    if (getOrientation(screen) == OrientationMode.portrate) {

      /// [canvas Portrate]////////
      if (getOrientation(canvas) == OrientationMode.portrate) {

        /// [canvas ratio] > [screen ratio]
        if (getRatio(canvas) > getRatio(screen)) {
        
          final sizeRatio = canvas.height / screen.height;
          return CanvasSizeRatio(
              size: Size(canvas.width / sizeRatio, screen.height),
              sizeRatio: sizeRatio);

        }/// [screen ratio]>[canvas ratio]
         else {
     
          final sizeRatio = canvas.width / screen.width;
          return CanvasSizeRatio(
              size: Size(screen.width, canvas.height / sizeRatio),
              sizeRatio: sizeRatio);
        }
      } ///[canvas landscape]----------------
      else {
    
        final sizeRatio = canvas.width / screen.width;
        return CanvasSizeRatio(
            size: Size(screen.width, canvas.height / sizeRatio),
            sizeRatio: sizeRatio);
      }

      ////////////[screen landscap]////////////////
      //////////////////////////////////////////
    } else if (getOrientation(screen) == OrientationMode.landscap) {
      if(getOrientation(canvas) == OrientationMode.landscap){
        if(getRatio(canvas)>getRatio(screen)){
           final sizeRatio = canvas.width / screen.width;
        return CanvasSizeRatio(
            size: Size(screen.width, canvas.height / sizeRatio),
            sizeRatio: sizeRatio);
        }else{
           final sizeRatio = canvas.height / screen.height;
      return CanvasSizeRatio(
          size: Size(canvas.width / sizeRatio, screen.height),
          sizeRatio: sizeRatio);
        }
      }else{



      final sizeRatio = canvas.height / screen.height;
      return CanvasSizeRatio(
          size: Size(canvas.width / sizeRatio, screen.height),
          sizeRatio: sizeRatio);
      }
    } else {
      final sizeRatio = canvas.width / screen.width;
      return CanvasSizeRatio(
          size: Size(screen.width, screen.height), sizeRatio: sizeRatio);
    }
  }



}


enum OrientationMode { landscap, portrate, square }

class CanvasSizeRatio {
  final Size size;
  final double sizeRatio;

  CanvasSizeRatio({required this.size, required this.sizeRatio});
}
