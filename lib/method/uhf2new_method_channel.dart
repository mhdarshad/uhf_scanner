import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../interface/uhf2new_platform_interface.dart';

/// An implementation of [Uhf2newPlatform] that uses method channels.
class MethodChannelUhf2new extends Uhf2newPlatform {

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  // TODO: implement isStared
  Future<bool?> get isStared => methodChannel.invokeMethod('isStarted');

  @override
  // TODO: implement startSingle
  Future<bool?> get startSingle => methodChannel.invokeMethod('startSingle');

  @override
  // TODO: implement clearData
  Future<bool?> get clearData => methodChannel.invokeMethod('clearDatas');

  @override
  // TODO: implement close
  Future<bool?> get close => methodChannel.invokeMethod('close');

  @override
  // TODO: implement connect
  Future<bool?> get connect => methodChannel.invokeMethod('connect');

  @override
  // TODO: implement isConnected
  Future<bool?> get isConnected => methodChannel.invokeMethod('isConnected');

  @override
  // TODO: implement isEmptyTags
  Future<bool?> get isEmptyTags => methodChannel.invokeMethod('isEmptyTags');

  @override
  // TODO: implement startContinuous
  Future<bool?> get startContinuous => methodChannel.invokeMethod('startContinuous');

  @override
  // TODO: implement stop
  Future<bool?> get stop => methodChannel.invokeMethod('stop');
  @override
  Future<bool?> setPowerLevel(String value) {
    // TODO: implement setPowerLevel
    return methodChannel.invokeMethod('setPowerLevel', <String, String>{'value': value});
  }
  @override
  Future<bool?> setWorkArea(String value) {
    // TODO: implement setWorkArea
    return methodChannel.invokeMethod('setWorkArea', <String, String>{'value': value});;
  }
}
