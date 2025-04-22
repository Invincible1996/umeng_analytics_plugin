import Flutter
import UIKit
// 导入友盟头文件 (根据你使用的集成方式可能不同)
import UMCommon // 导入 UMCommon.h
// import MobClick

public class UmengAnalyticsPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "umeng_analytics_plugin", binaryMessenger: registrar.messenger())
    let instance = UmengAnalyticsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "initialize":
        guard let args = call.arguments as? [String: Any],
              let iosAppKey = args["iosAppKey"] as? String,
              let channel = args["channel"] as? String
        else {
            result(FlutterError(code: "INVALID_ARGUMENT", message: "iosAppKey or channel is missing or invalid", details: nil))
            return
        }
        let logEnabled = args["logEnabled"] as? Bool ?? false
        // iOS SDK 没有直接设置加密的接口，通常默认开启

        // 设置 Log 开关 (需要在初始化之前)
        UMConfigure.setLogEnabled(logEnabled)

        // 初始化友盟 SDK
        UMConfigure.initWithAppkey(iosAppKey, channel: channel)

         // 设置页面采集模式为手动 (推荐 Flutter 使用)
        // iOS SDK 默认就是手动采集页面，无需像 Android 那样显式设置 PageMode.MANUAL

        result(nil)

    case "pageStart":
        guard let args = call.arguments as? [String: Any],
              let pageName = args["pageName"] as? String
        else {
             result(FlutterError(code: "INVALID_ARGUMENT", message: "pageName is missing or invalid", details: nil))
             return
        }
        MobClick.beginLogPageView(pageName)
        result(nil)

    case "pageEnd":
         guard let args = call.arguments as? [String: Any],
              let pageName = args["pageName"] as? String
        else {
             result(FlutterError(code: "INVALID_ARGUMENT", message: "pageName is missing or invalid", details: nil))
             return
        }
        MobClick.endLogPageView(pageName)
        result(nil)

    case "logEvent":
         guard let args = call.arguments as? [String: Any],
              let eventId = args["eventId"] as? String
        else {
             result(FlutterError(code: "INVALID_ARGUMENT", message: "eventId is missing or invalid", details: nil))
             return
        }
        // Flutter 传过来的是 [String: Any]?, 需要转成 [String: String]? 或 [AnyHashable: Any]?
         let properties = args["properties"] as? [String: String] // 假设 Dart 层保证了 Value 是 String

         if let props = properties, !props.isEmpty {
             // MobClick.event(_:attributes:) 的 attributes 参数类型是 [AnyHashable: Any]?
             // 如果 Dart 传来的确定是 [String: String]，可以直接用
             MobClick.event(eventId, attributes: props)
         } else {
             MobClick.event(eventId)
         }
         result(nil)

    case "signIn":
         guard let args = call.arguments as? [String: Any],
              let userId = args["userId"] as? String
         else {
             result(FlutterError(code: "INVALID_ARGUMENT", message: "userId is missing or invalid", details: nil))
             return
         }
         let provider = args["provider"] as? String // 可以为 nil

         if let prov = provider {
             MobClick.profileSignIn(withPUID: userId, provider: prov)
         } else {
             MobClick.profileSignIn(withPUID: userId)
         }
         result(nil)

    case "signOut":
         MobClick.profileSignOff()
         result(nil)

    default:
      result(FlutterMethodNotImplemented)
    }
  }
}