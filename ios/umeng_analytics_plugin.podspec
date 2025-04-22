#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint umeng_analytics_plugin.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'umeng_analytics_plugin'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter plugin project.'
  s.description      = <<-DESC
A new Flutter plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '12.0'
  # 推荐使用友盟提供的集成库 (包含常用组件)
  s.dependency 'UMCommonLog'        # 日志库
  s.dependency 'UMCommon'           # 基础组件库
  s.dependency 'UMDevice'           # 设备信息库
  s.dependency 'UMAPM'              # 性能监控组件(可选)
  s.static_framework = true

  # 根据友盟最新文档添加必要的系统 Frameworks
  # s.frameworks = 'UIKit', 'Foundation', 'CoreTelephony', 'SystemConfiguration', 'CoreGraphics', 'Security', 'libz'


  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'

  # If your plugin requires a privacy manifest, for example if it uses any
  # required reason APIs, update the PrivacyInfo.xcprivacy file to describe your
  # plugin's privacy impact, and then uncomment this line. For more information,
  # see https://developer.apple.com/documentation/bundleresources/privacy_manifest_files
  # s.resource_bundles = {'umeng_analytics_plugin_privacy' => ['Resources/PrivacyInfo.xcprivacy']}
end
