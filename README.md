# Umeng Analytics Plugin

[![pub package](https://img.shields.io/pub/v/umeng_analytics_flutter.svg)](https://pub.dev/packages/umeng_analytics_flutter)

友盟统计 Flutter 插件，支持 Android 和 iOS 平台。

## 功能特点

- 支持友盟统计基本功能
- 页面访问统计
- 自定义事件统计
- 用户登录统计

## 安装

在 `pubspec.yaml` 文件中添加依赖：

```yaml
dependencies:
  umeng_analytics_plugin: ^最新版本
```

然后运行：

```bash
flutter pub get
```

## 配置

### Android 配置

1. 在 `android/app/src/main` 目录下创建 `MainApplication.kt` 文件（如果不存在）：

```kotlin
package com.your.package.name

import android.app.Application
import com.umeng.commonsdk.UMConfigure

class MainApplication : Application() {

    override fun onCreate() {
        super.onCreate()

        // 预初始化友盟统计 SDK
        UMConfigure.setLogEnabled(true) // 开发阶段可以打开日志
        UMConfigure.preInit(this, "您的友盟AppKey", "您的渠道名")
    }
}
```

2. 在 `AndroidManifest.xml` 中注册 `MainApplication`：

```xml
<application
    android:name=".MainApplication"
    ...
    >
```

3. 确保 `AndroidManifest.xml` 中添加了必要的权限：

```xml
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
<uses-permission android:name="android.permission.READ_PHONE_STATE" />
<uses-permission android:name="android.permission.INTERNET" />
```

### iOS 配置

1. 打开 `ios/Runner/AppDelegate.swift` 文件，添加 URL 处理方法（注意：以下代码仅作为测试验证用途，实际项目中请根据您的应用情况进行适当调整）：

```swift
import Flutter
import UIKit
import UMCommon

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  // iOS 9 及以上
  override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
    if MobClick.handle(url) {
      return true
    }
    // 处理其他第三方
    return true
  }

  // iOS 8 及以下
  override func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
    if MobClick.handle(url) {
      return true
    }
    // 处理其他第三方
    return true
  }
}
```

> **特别说明**：上述 AppDelegate.swift 中的代码仅用于测试验证友盟 SDK 的功能。在实际项目中，您需要根据自己的应用结构和需求调整实现方式，确保与现有代码正确集成。

2. 在 `Info.plist` 中添加隐私描述（iOS 14 及以上需要）：

```xml
<key>NSUserTrackingUsageDescription</key>
<string>该标识符将用于向您推送个性化广告</string>
```

## 使用方法

### 初始化

在应用启动时（通常在 `main.dart` 的 `main()` 函数中）初始化友盟统计：

```dart
import 'package:umeng_analytics_plugin/umeng_analytics_plugin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 初始化友盟统计
  await UmengAnalyticsPlugin.initialize(
    androidAppKey: '您的Android AppKey',
    iosAppKey: '您的iOS AppKey',
    channel: '您的渠道名',
    logEnabled: true,  // 开发阶段可以打开日志
    encryptEnabled: true,  // 启用加密传输
  );

  runApp(MyApp());
}
```

### 页面统计

在每个页面的生命周期中调用：

```dart
@override
void initState() {
  super.initState();
  UmengAnalyticsPlugin.pageStart("页面名称");
}

@override
void dispose() {
  UmengAnalyticsPlugin.pageEnd("页面名称");
  super.dispose();
}
```

### 自定义事件统计

```dart
// 简单事件
UmengAnalyticsPlugin.logEvent("事件ID");

// 带属性的事件
UmengAnalyticsPlugin.logEvent(
  "事件ID",
  properties: {
    "属性1": "值1",
    "属性2": "值2",
  },
);
```

### 用户统计

```dart
// 用户登录
UmengAnalyticsPlugin.signIn("用户ID", provider: "登录平台");

// 用户登出
UmengAnalyticsPlugin.signOut();
```

## 注意事项

1. Android 端必须在 `MainApplication.kt` 中进行预初始化，然后在 Flutter 中调用 `initialize` 方法完成完整初始化。
2. iOS 端需要处理 URL 回调以支持完整功能。
3. 确保在打包发布前关闭日志输出（`logEnabled: false`）。
4. 事件 ID 命名请遵循友盟统计规范，不要使用中文或特殊字符。

## 常见问题

1. 如果统计数据未上报，请检查网络连接和 AppKey 是否正确。
2. Android 端如遇隐私合规问题，请参考友盟官方文档进行适配。
3. iOS 14 及以上版本需要在 Info.plist 中添加用户跟踪权限描述。

## 许可证

MIT
