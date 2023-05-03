import 'package:flutter/src/services/platform_channel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uhf2new/uhf2new.dart';
import 'package:uhf2new/interface/uhf2new_platform_interface.dart';
import 'package:uhf2new/method/uhf2new_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockUhf2newPlatform
    with MockPlatformInterfaceMixin
    implements Uhf2newPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  // TODO: implement clearData
  Future<bool?> get clearData => throw UnimplementedError();

  @override
  // TODO: implement close
  Future<bool?> get close => throw UnimplementedError();

  @override
  // TODO: implement connect
  Future<bool?> get connect => throw UnimplementedError();

  @override
  // TODO: implement isConnected
  Future<bool?> get isConnected => throw UnimplementedError();

  @override
  // TODO: implement isEmptyTags
  Future<bool?> get isEmptyTags => throw UnimplementedError();

  @override
  // TODO: implement isStared
  Future<bool?> get isStared => throw UnimplementedError();

  @override
  // TODO: implement methodChannel
  MethodChannel get methodChannel => throw UnimplementedError();

  @override
  Future<bool?> setPowerLevel(String value) {
    // TODO: implement setPowerLevel
    throw UnimplementedError();
  }

  @override
  Future<bool?> setWorkArea(String value) {
    // TODO: implement setWorkArea
    throw UnimplementedError();
  }

  @override
  // TODO: implement startContinuous
  Future<bool?> get startContinuous => throw UnimplementedError();

  @override
  // TODO: implement startSingle
  Future<bool?> get startSingle => throw UnimplementedError();

  @override
  // TODO: implement stop
  Future<bool?> get stop => throw UnimplementedError();
}

void main() {
  final Uhf2newPlatform initialPlatform = Uhf2newPlatform.instance;

  test('$MethodChannelUhf2new is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelUhf2new>());
  });

  test('getPlatformVersion', () async {
    Uhf2new uhf2newPlugin = Uhf2new();
    MockUhf2newPlatform fakePlatform = MockUhf2newPlatform();
    Uhf2newPlatform.instance = fakePlatform;

    expect(await Uhf2new.platformVersion, '42');
  });
}
