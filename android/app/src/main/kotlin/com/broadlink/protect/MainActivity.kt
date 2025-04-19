package com.broadlink.protect

import android.app.role.RoleManager
import android.content.Context
import android.content.Intent
import android.media.AudioManager
import android.os.Build
import android.provider.Telephony
import android.telecom.TelecomManager
import android.widget.Toast
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterFragmentActivity() {
    private val CHANNEL = "com.broadlink.protect/chat"
    private val CALL_CHANNEL = "com.broadlink.protect/call" // Channel for call-related methods
    private var flutterResult: MethodChannel.Result? = null
    private var flutterCallResult: MethodChannel.Result? = null // Result for call actions

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        if (requestCode == 12) {
            flutterResult!!.success(resultCode)
        } else if (requestCode == 13) {
            flutterCallResult!!.success(resultCode)
        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // SMS Default App Setting
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            flutterResult = result
            if (call.method == "setDefaultSms") {
                try {
                    if (Build.VERSION.SDK_INT > Build.VERSION_CODES.P) {
                        val roleManager: RoleManager = getSystemService(RoleManager::class.java)
                        val intent = roleManager.createRequestRoleIntent(RoleManager.ROLE_SMS)
                        startActivityForResult(intent, 12)
                    } else {
                        val intent = Intent(Telephony.Sms.Intents.ACTION_CHANGE_DEFAULT)
                        intent.putExtra(Telephony.Sms.Intents.EXTRA_PACKAGE_NAME, "com.broadlink.protect")
                        startActivity(intent)
                    }
                } catch (ex: Exception) {
                    result.error("UNAVAILABLE", "Setting default sms.", null)
                }
            } else {
                result.notImplemented()
            }
        }

        // Calling App Logic (End Call, Add Call, Mute, Unmute)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CALL_CHANNEL).setMethodCallHandler { call, result ->
            flutterCallResult = result

            when (call.method) {
                // Requesting Default Dialer
                "requestDefaultDialer" -> {
                    try {
                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                            val roleManager = getSystemService(RoleManager::class.java)
                            val intent = roleManager.createRequestRoleIntent(RoleManager.ROLE_DIALER)
                            startActivityForResult(intent, 13)
                        } else {
                            val intent = Intent(android.provider.Settings.ACTION_MANAGE_DEFAULT_APPS_SETTINGS)
                            startActivity(intent)
                            result.success("OPEN_SETTINGS")
                        }
                    } catch (ex: Exception) {
                        result.error("UNAVAILABLE", "Requesting default dialer role failed.", null)
                    }
                }

                // End the Call
                "endCall" -> {
                    try {
                        // This will work only if your app is the default dialer
                        val telecomManager = getSystemService(Context.TELECOM_SERVICE) as TelecomManager
                        telecomManager.endCall() // Ends the ongoing call
                        result.success("Call ended")
                    } catch (e: Exception) {
                        result.error("UNAVAILABLE", "Failed to end call", null)
                    }
                }

                // Add a Call (Launch dialer)
                "addCall" -> {
                    try {
                        val intent = Intent(Intent.ACTION_DIAL) // Launch dialer for new call
                        startActivity(intent)
                        result.success("Dialer opened")
                    } catch (e: Exception) {
                        result.error("UNAVAILABLE", "Failed to add call", null)
                    }
                }

                // Mute the Call (mute microphone)
                "mute" -> {
                    try {
                        val audioManager = getSystemService(Context.AUDIO_SERVICE) as AudioManager
                        audioManager.isMicrophoneMute = true // Mute the microphone
                        result.success("Muted")
                    } catch (e: Exception) {
                        result.error("UNAVAILABLE", "Failed to mute", null)
                    }
                }

                // Unmute the Call (unmute microphone)
                "unmute" -> {
                    try {
                        val audioManager = getSystemService(Context.AUDIO_SERVICE) as AudioManager
                        audioManager.isMicrophoneMute = false // Unmute the microphone
                        result.success("Unmuted")
                    } catch (e: Exception) {
                        result.error("UNAVAILABLE", "Failed to unmute", null)
                    }
                }

                else -> result.notImplemented()
            }
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        // Unregister any receivers if needed
    }
}
