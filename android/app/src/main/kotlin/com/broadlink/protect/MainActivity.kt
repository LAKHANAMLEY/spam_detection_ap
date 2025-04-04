package com.broadlink.protect

import io.flutter.embedding.android.FlutterFragmentActivity

import android.app.role.RoleManager
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Build
import android.provider.Telephony
import androidx.annotation.NonNull
import com.google.gson.JsonObject
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import android.widget.Toast


class MainActivity : FlutterFragmentActivity() {
    private val CHANNEL = "com.broadlink.protect/chat";
    var flutterResult: MethodChannel.Result? = null

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
      if (requestCode == 12) {
        flutterResult!!.success(resultCode);
      }
    }
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
          flutterResult = result;
          if (call.method == "setDefaultSms") {
            try {
              if (Build.VERSION.SDK_INT > Build.VERSION_CODES.P) {
                val roleManager: RoleManager = getSystemService(RoleManager::class.java);
                var intent = roleManager.createRequestRoleIntent (RoleManager.ROLE_SMS);
                var res = startActivityForResult(intent, 12);
              } else {
                var intent = Intent(Telephony.Sms.Intents.ACTION_CHANGE_DEFAULT);
                intent.putExtra(Telephony.Sms.Intents.EXTRA_PACKAGE_NAME, "com.broadlink.protect");
                startActivity(intent);
              }
            } catch (ex: Exception) {
              result.error("UNAVAILABLE", "Setting default sms.", null);
            }
          } else {
            result.notImplemented();
          }

        }
        
    }

    override fun onDestroy() {
      super.onDestroy()
      // Make sure to unregister the receiver to avoid leaks
      // unregisterReceiver(smsReceiver)
    }
}
