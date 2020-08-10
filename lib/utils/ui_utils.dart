
import 'package:flutter/widgets.dart';
import 'package:guitarfashion/enums/device_screen_type.dart';

DeviceScreenType getDeviceType (MediaQueryData mediaQuery) {
  double deviceWidth = mediaQuery.size.width;

  if(deviceWidth > 950) {
    return DeviceScreenType.Desktop;
  }

  if(deviceWidth >= 600) {
    return DeviceScreenType.Table;
  }

  return DeviceScreenType.Mobile;
}