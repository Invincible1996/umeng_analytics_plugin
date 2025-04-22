package com.example.umeng_analytics_plugin_example

import android.app.Application
import com.umeng.commonsdk.UMConfigure

class MainApplication : Application() {

    override fun onCreate() {
        super.onCreate()

        // Initialize Umeng Analytics SDK
        UMConfigure.setLogEnabled(true)
        UMConfigure.preInit(this, "xxxxx", "umeng")
    }
}
