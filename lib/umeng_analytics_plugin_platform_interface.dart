import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'umeng_analytics_plugin_method_channel.dart';

abstract class UmengAnalyticsPluginPlatform extends PlatformInterface {
  /// Constructs a UmengAnalyticsPluginPlatform.
  UmengAnalyticsPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static UmengAnalyticsPluginPlatform _instance =
      MethodChannelUmengAnalyticsPlugin();

  /// The default instance of [UmengAnalyticsPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelUmengAnalyticsPlugin].
  static UmengAnalyticsPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [UmengAnalyticsPluginPlatform] when
  /// they register themselves.
  static set instance(UmengAnalyticsPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> initialize({
    required String androidAppKey,
    required String iosAppKey,
    required String channel,
    required bool logEnabled,
    required bool encryptEnabled,
  }) {
    throw UnimplementedError('initialize() has not been implemented.');
  }

  /// 页面开始统计
  ///
  /// [pageName] : 页面名称
  Future<void> pageStart(String pageName) async {
    throw UnimplementedError('pageStart() has not been implemented.');
  }

  /// 页面结束统计
  ///
  /// [pageName] : 页面名称
  Future<void> pageEnd(String pageName) async {
    throw UnimplementedError('pageEnd() has not been implemented.');
  }

  /// 自定义事件统计
  ///
  /// [eventId]    : 事件ID，不能为空
  /// [properties] : 事件属性，可选，Map类型，Key 和 Value 都必须是 String 类型
  Future<void> logEvent(
    String eventId, {
    Map<String, String>? properties,
  }) async {
    throw UnimplementedError('logEvent() has not been implemented.');
  }

  /// 账号登录统计
  /// [userId]   : 用户账号ID，不能为空
  /// [provider] : 账号来源。如果用户通过第三方账号登录，可以传入第三方名称，如："Weibo", "QQ" 等，可选
  Future<void> signIn(String userId, {String? provider}) async {
    throw UnimplementedError('signIn() has not been implemented.');
  }

  /// 账号登出统计
  Future<void> signOut() async {
    throw UnimplementedError('signOut() has not been implemented.');
  }
}
