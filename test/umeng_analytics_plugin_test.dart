import 'package:flutter_test/flutter_test.dart';
import 'package:umeng_analytics_flutter/umeng_analytics_plugin.dart';
import 'package:umeng_analytics_flutter/umeng_analytics_plugin_method_channel.dart';
import 'package:umeng_analytics_flutter/umeng_analytics_plugin_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockUmengAnalyticsPluginPlatform
    with MockPlatformInterfaceMixin
    implements UmengAnalyticsPluginPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<void> initialize({
    required String androidAppKey,
    required String iosAppKey,
    required String channel,
    required bool logEnabled,
    required bool encryptEnabled,
  }) {
    // TODO: implement initialize
    throw UnimplementedError();
  }

  @override
  Future<void> logEvent(String eventId, {Map<String, String>? properties}) {
    // TODO: implement logEvent
    throw UnimplementedError();
  }

  @override
  Future<void> pageEnd(String pageName) {
    // TODO: implement pageEnd
    throw UnimplementedError();
  }

  @override
  Future<void> pageStart(String pageName) {
    // TODO: implement pageStart
    throw UnimplementedError();
  }

  @override
  Future<void> signIn(String userId, {String? provider}) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}

void main() {
  final UmengAnalyticsPluginPlatform initialPlatform =
      UmengAnalyticsPluginPlatform.instance;

  test('$MethodChannelUmengAnalyticsPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelUmengAnalyticsPlugin>());
  });

  test('getPlatformVersion', () async {
    UmengAnalyticsPlugin umengAnalyticsPlugin = UmengAnalyticsPlugin();
    MockUmengAnalyticsPluginPlatform fakePlatform =
        MockUmengAnalyticsPluginPlatform();
    UmengAnalyticsPluginPlatform.instance = fakePlatform;

    expect(await umengAnalyticsPlugin.getPlatformVersion(), '42');
  });
}
