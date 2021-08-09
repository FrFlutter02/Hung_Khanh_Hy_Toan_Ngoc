import 'package:flutter_device_type/flutter_device_type.dart';

class ScreenUtil {
  double tabletDesignWidth = 768;
  double tabletDesignHeight = 1024;
  double phoneDesignWidth = 375;
  double phoneDesignHeight = 812;

  double height(double designedPixel) {
    return designedPixel /
        (Device.get().isTablet ? tabletDesignHeight : phoneDesignHeight) *
        Device.screenHeight;
  }

  double width(double designedPixel) {
    return designedPixel /
        (Device.get().isTablet ? tabletDesignWidth : phoneDesignWidth) *
        Device.screenWidth;
  }
}
