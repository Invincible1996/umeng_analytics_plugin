package com.example.umeng_analytics_plugin

import android.content.Context
import com.umeng.analytics.MobclickAgent
import com.umeng.commonsdk.UMConfigure
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** UmengAnalyticsPlugin */
class UmengAnalyticsPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "umeng_analytics_plugin")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "initialize" -> {
                val androidAppKey: String? = call.argument("androidAppKey")
                val channelName: String? = call.argument("channel")
                val logEnabled: Boolean = call.argument("logEnabled") ?: false
                val encryptEnabled: Boolean = call.argument("encryptEnabled") ?: true

                if (androidAppKey.isNullOrEmpty() || channelName.isNullOrEmpty()) {
                    result.error(
                        "INVALID_ARGUMENT", "androidAppKey or channel cannot be null or empty", null
                    )
                    return
                }

                // 在初始化前设置合规同意状态（如果需要）
                // UMConfigure.submitPolicyGrantResult(context, true); // true 表示用户同意隐私协议

                // 初始化友盟SDK
                // 第一个参数是Context
                // 第二个参数是Appkey
                // 第三个参数是渠道名称
                // 第四个参数是设备类型，UMConfigure.DEVICE_TYPE_PHONE 或 UMConfigure.DEVICE_TYPE_BOX
                // 第五个参数是推送Push Secret（如果没有使用U-Push，可以为空）
                UMConfigure.init(
                    context, androidAppKey, channelName, UMConfigure.DEVICE_TYPE_PHONE, null
                )

                // 设置日志开关
                UMConfigure.setLogEnabled(logEnabled)

                // 设置加密传输
                UMConfigure.setEncryptEnabled(encryptEnabled)

                // 设置页面采集模式为自动（推荐 Flutter 使用手动模式）
                // MobclickAgent.setPageCollectionMode(MobclickAgent.PageMode.AUTO)
                // Flutter 建议使用手动模式，由 Dart 层控制 pageStart/pageEnd
                MobclickAgent.setPageCollectionMode(MobclickAgent.PageMode.MANUAL)

                result.success(null)
            }

            "pageStart" -> {
                val pageName: String? = call.argument("pageName")
                if (pageName != null) {
                    MobclickAgent.onPageStart(pageName)
                    result.success(null)
                } else {
                    result.error("INVALID_ARGUMENT", "pageName cannot be null", null)
                }
            }

            "pageEnd" -> {
                val pageName: String? = call.argument("pageName")
                if (pageName != null) {
                    MobclickAgent.onPageEnd(pageName)
                    result.success(null)
                } else {
                    result.error("INVALID_ARGUMENT", "pageName cannot be null", null)
                }
            }

            "logEvent" -> {
                val eventId: String? = call.argument("eventId")
                // Flutter 传过来的是 Map<String, Any?>?, 需要转成 Map<String, String>?
                val propertiesRaw: Map<String, Any?>? = call.argument("properties")
                val properties: Map<String, String>? = propertiesRaw?.mapNotNull { (k, v) ->
                    v?.let { k to it.toString() } // 确保 value 不为 null 并转为 String
                }?.toMap()


                if (eventId != null) {
                    if (properties.isNullOrEmpty()) {
                        MobclickAgent.onEvent(context, eventId)
                    } else {
                        MobclickAgent.onEventObject(
                            context, eventId, properties
                        ) // 使用 onEventObject 支持 Map
                    }
                    result.success(null)
                } else {
                    result.error("INVALID_ARGUMENT", "eventId cannot be null", null)
                }
            }

            "signIn" -> {
                val userId: String? = call.argument("userId")
                val provider: String? = call.argument("provider") // 可以为 null
                if (userId != null) {
                    if (provider != null) {
                        MobclickAgent.onProfileSignIn(provider, userId)
                    } else {
                        MobclickAgent.onProfileSignIn(userId)
                    }
                    result.success(null)
                } else {
                    result.error("INVALID_ARGUMENT", "userId cannot be null", null)
                }
            }

            "signOut" -> {
                MobclickAgent.onProfileSignOff()
                result.success(null)
            }

            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
