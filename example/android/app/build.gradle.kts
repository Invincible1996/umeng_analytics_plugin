plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// 从 keystore.properties 文件读取签名信息
import java.util.Properties
import java.io.FileInputStream

val keystorePropertiesFile = rootProject.file("keystore.properties")
val keystoreProperties = Properties()
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    namespace = "com.example.umeng_analytics_plugin_example"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973" // 设置为插件所需的NDK版本

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    signingConfigs {
        create("release") {
            if (keystorePropertiesFile.exists()) {
                keyAlias = keystoreProperties["keyAlias"] as String
                keyPassword = keystoreProperties["keyPassword"] as String
                // 确保去掉可能的空格
                val storeFilePath = (keystoreProperties["storeFile"] as String).trim()
                storeFile = file(storeFilePath)
                storePassword = keystoreProperties["storePassword"] as String
            } else {
                // 如果 keystore.properties 不存在，可以提供默认值或报错
                println("警告: keystore.properties 文件不存在！请创建此文件配置签名信息。")
            }
        }
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.umeng_analytics_plugin_example"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        
        // Enable multidex if needed
        multiDexEnabled = true
        
        // Configure NDK ABIs if needed
        ndk {
            abiFilters.add("armeabi-v7a")
            abiFilters.add("arm64-v8a")
            abiFilters.add("x86_64")
        }
    }

    buildTypes {
        debug {
            isMinifyEnabled = false
            isShrinkResources = false
            isDebuggable = true
        }
        
        release {
            signingConfig = signingConfigs.getByName("release")
            
            // 由于缺少依赖包导致的问题，暂时禁用代码混淆
            isMinifyEnabled = false
            isShrinkResources = false
            
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
    
    // Configure split APKs to reduce app size
    splits {
        abi {
            isEnable = true
            reset()
            include("armeabi-v7a", "arm64-v8a", "x86_64")
            isUniversalApk = true
        }
    }
    
    // Disable unused resources
    lint {
        checkReleaseBuilds = true
        abortOnError = false
    }
    
    // Configure packaging options
    packagingOptions {
        resources.excludes.add("META-INF/LICENSE")
        resources.excludes.add("META-INF/LICENSE.txt")
        resources.excludes.add("META-INF/NOTICE")
        resources.excludes.add("META-INF/NOTICE.txt")
        resources.excludes.add("META-INF/*.kotlin_module")
    }
}

// 添加缺少的依赖
dependencies { 
    // Multidex 支持
    implementation("androidx.multidex:multidex:2.0.1")
}

flutter {
    source = "../.."
}
