import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'umeng_analytics_plugin_platform_interface.dart';

/// An implementation of [UmengAnalyticsPluginPlatform] that uses method channels.
class MethodChannelUmengAnalyticsPlugin extends UmengAnalyticsPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('umeng_analytics_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>(
      'getPlatformVersion',
    );
    return version;
  }

  @override
  Future<void> initialize({
    required String androidAppKey,
    required String iosAppKey,
    required String channel,
    required bool logEnabled,
    required bool encryptEnabled,
  }) async {
    await methodChannel.invokeMethod('initialize', {
      'androidAppKey': androidAppKey,
      'iosAppKey': iosAppKey,
      'channel': channel,
      'logEnabled': logEnabled,
      'encryptEnabled': encryptEnabled,
    });
  }

  @override
  Future<void> pageStart(String pageName) async {
    await methodChannel.invokeMethod('pageStart', {'pageName': pageName});
  }

  @override
  Future<void> pageEnd(String pageName) async {
    await methodChannel.invokeMethod('pageEnd', {'pageName': pageName});
  }

  @override
  Future<void> logEvent(
    String eventId, {
    Map<String, String>? properties,
  }) async {
    await methodChannel.invokeMethod('logEvent', {
      'eventId': eventId,
      'properties': properties,
    });
  }

  @override
  Future<void> signIn(String userId, {String? provider}) async {
    await methodChannel.invokeMethod('signIn', {
      'userId': userId,
      'provider': provider,
    });
  }

  @override
  Future<void> signOut() async {
    await methodChannel.invokeMethod('signOut');
  }
}
