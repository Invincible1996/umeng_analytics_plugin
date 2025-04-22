import 'umeng_analytics_plugin_platform_interface.dart';

class UmengAnalyticsPlugin {
  Future<String?> getPlatformVersion() {
    return UmengAnalyticsPluginPlatform.instance.getPlatformVersion();
  }

  /// 初始化友盟统计 SDK
  ///
  /// [androidAppKey] : Android平台的AppKey
  /// [iosAppKey]     : iOS平台的AppKey
  /// [channel]       : 渠道标识，可随意填写，但不能为空
  /// [logEnabled]    : 是否开启日志打印（建议调试时开启，发布时关闭）
  /// [encryptEnabled]: 是否开启加密传输（默认开启）
  static Future<void> initialize({
    required String androidAppKey,
    required String iosAppKey,
    required String channel,
    bool logEnabled = false,
    bool encryptEnabled = true,
  }) async {
    // await _channel.invokeMethod('initialize', {
    //   'androidAppKey': androidAppKey,
    //   'iosAppKey': iosAppKey,
    //   'channel': channel,
    //   'logEnabled': logEnabled,
    //   'encryptEnabled': encryptEnabled,
    // });
    return UmengAnalyticsPluginPlatform.instance.initialize(
      androidAppKey: androidAppKey,
      iosAppKey: iosAppKey,
      channel: channel,
      logEnabled: logEnabled,
      encryptEnabled: encryptEnabled,
    );
  }

  /// 页面开始统计
  ///
  /// [pageName] : 页面名称
  static Future<void> pageStart(String pageName) async {
    return UmengAnalyticsPluginPlatform.instance.pageStart(pageName);
  }

  /// 页面结束统计
  ///
  /// [pageName] : 页面名称
  static Future<void> pageEnd(String pageName) async {
    return UmengAnalyticsPluginPlatform.instance.pageEnd(pageName);
  }

  /// 自定义事件统计
  ///
  /// [eventId]    : 事件ID，不能为空
  /// [properties] : 事件属性，可选，Map类型，Key 和 Value 都必须是 String 类型
  static Future<void> logEvent(
    String eventId, {
    Map<String, String>? properties,
  }) async {
    return UmengAnalyticsPluginPlatform.instance.logEvent(
      eventId,
      properties: properties,
    );
  }

  /// 用户登录统计
  ///
  /// [userId]   : 用户ID，不能为空
  /// [provider] : 登录平台，可选，默认值为 null
  static Future<void> signIn(String userId, {String? provider}) async {
    return UmengAnalyticsPluginPlatform.instance.signIn(
      userId,
      provider: provider,
    );
  }

  /// 用户登出统计
  static Future<void> signOut() async {
    return UmengAnalyticsPluginPlatform.instance.signOut();
  }
}
