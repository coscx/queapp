package com.queqiaochina.app

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.app.FlutterApplication
import io.github.zileyuan.umeng_analytics_push.UmengAnalyticsPushFlutterAndroid


class MyFlutterApplication: FlutterApplication() {
    override fun onCreate() {
        super.onCreate();
        UmengAnalyticsPushFlutterAndroid.androidInit(this, "60499fa1777e961462b986d8", "default", false, "0ecfdb97b841ca0b091f4a3dbedec89e",)
        // Register Xiaomi Push (optional)
        UmengAnalyticsPushFlutterAndroid.registerXiaomi(this, "2882303761519543544", "5781954349544")
        // Register Huawei Push (optional, need add other infomation in AndroidManifest.xml)
        UmengAnalyticsPushFlutterAndroid.registerHuawei(this)
        // Register Oppo Push (optional)
        UmengAnalyticsPushFlutterAndroid.registerOppo(this, "oppo_app_key", "oppo_app_secret")
        // Register Vivo Push (optional, need add other infomation in AndroidManifest.xml)
        UmengAnalyticsPushFlutterAndroid.registerVivo(this)
        // Register Meizu Push (optional)
        UmengAnalyticsPushFlutterAndroid.registerMeizu(this, "meizu_app_id", "meizu_app_key")
    }
}