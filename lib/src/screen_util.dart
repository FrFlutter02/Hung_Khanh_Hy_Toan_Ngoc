import 'package:flutter_device_type/flutter_device_type.dart';

class ScreenUtil {
  double height(double designedPixel) {
    return designedPixel /
        (Device.get().isTablet ? 1024 : 812) *
        Device.screenHeight;
  }

  double width(double designedPixel) {
    return designedPixel /
        (Device.get().isTablet ? 768 : 375) *
        Device.screenWidth;
  }
}
