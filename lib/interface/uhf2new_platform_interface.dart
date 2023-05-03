import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import '../method/uhf2new_method_channel.dart';

abstract class Uhf2newPlatform extends PlatformInterface {
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
  /// Constructs a Uhf2newPlatform.
  Uhf2newPlatform() : super(token: _token);
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('uhf2new');

  static final Object _token = Object();

  static Uhf2newPlatform _instance = MethodChannelUhf2new();

  /// The default instance of [Uhf2newPlatform] to use.
  ///
  /// Defaults to [MethodChannelUhf2new].
  static Uhf2newPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [Uhf2newPlatform] when
  /// they register themselves.
  static set instance(Uhf2newPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  // Future<String?> getPlatformVersion() {
  //   throw UnimplementedError('platformVersion() has not been implemented.');
  // }
  // Future<bool?> setPowerLevel(String value) {
  //   throw UnimplementedError('platformVersion() has not been implemented.');
  // }
  // Future<bool?> setWorkArea(String value) {
  //   throw UnimplementedError('platformVersion() has not been implemented.');
  // }
}
