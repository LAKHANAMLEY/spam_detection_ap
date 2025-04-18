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
    private val CALL_CHANNEL = "com.broadlink.protect/call"; // New channel for calling
    var flutterResult: MethodChannel.Result? = null
    var flutterCallResult: MethodChannel.Result? = null // Result for call intent

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        if (requestCode == 12) {
            flutterResult!!.success(resultCode);
        } else if (requestCode == 13) { // Request code for default dialer
            flutterCallResult!!.success(resultCode);
        }
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            flutterResult = result;
            if (call.method == "setDefaultSms") {
                System.out.println("Setting default sms app...");

                try {
                    if (Build.VERSION.SDK_INT > Build.VERSION_CODES.P) {
                        val roleManager: RoleManager = getSystemService(RoleManager::class.java);
                        var intent = roleManager.createRequestRoleIntent(RoleManager.ROLE_SMS);
                        startActivityForResult(intent, 12);
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

        // Method channel for handling default calling app functionality
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CALL_CHANNEL).setMethodCallHandler { call, result ->
            flutterCallResult = result;
            if (call.method == "requestDefaultDialer") {
                System.out.println("Setting default calling app...");
                
                try {
            //             if (getSystemService(TelecomManager.class).getDefaultDialerPackage() != getPackageName()) {
            // Intent ChangeDialer = new Intent(TelecomManager.ACTION_CHANGE_DEFAULT_DIALER);
            // ChangeDialer.putExtra(TelecomManager.EXTRA_CHANGE_DEFAULT_DIALER_PACKAGE_NAME, getPackageName());
            // startActivity(ChangeDialer);
        // }
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                        val roleManager = getSystemService(RoleManager::class.java)
                        val intent = roleManager.createRequestRoleIntent(RoleManager.ROLE_DIALER)
                        startActivityForResult(intent, 13) // Use a different request code
                    } else {
                        // On older versions, we can only guide the user to settings
                        val intent = Intent(android.provider.Settings.ACTION_MANAGE_DEFAULT_APPS_SETTINGS)
                        // intent.putExtra(Telephony.call.Intents.EXTRA_PACKAGE_NAME, "com.broadlink.protect");
                        startActivity(intent)
                        result.success("OPEN_SETTINGS") // Indicate that settings were opened
                    }
                } catch (ex: Exception) {
                    result.error("UNAVAILABLE", "Requesting default dialer role failed.", null);
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