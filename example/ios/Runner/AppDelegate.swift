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
    
  // iOS 9 and above
  override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
    if MobClick.handle(url) {
      return true
    }
    // Handle other third-party processing
    return true
  }
    
  // iOS 8 and below
  override func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
    if MobClick.handle(url) {
      return true
    }
    // Handle other third-party processing
    return true
  }
}
