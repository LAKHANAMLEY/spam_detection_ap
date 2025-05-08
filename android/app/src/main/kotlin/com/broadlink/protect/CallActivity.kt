package com.broadlink.protect

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.telecom.Call
import android.telecom.Call.Callback
import android.telecom.VideoProfile
import android.util.Log
import android.widget.ImageButton
import android.widget.TextView
import com.broadlink.protect.R

class CallActivity : Activity() {

    private var call: Call? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_call)

        val phoneNumberText = findViewById<TextView>(R.id.phoneNumber)
        val callerNameText = findViewById<TextView>(R.id.callerName)

        call = OngoingCall.call
        val number = call?.details?.handle?.schemeSpecificPart ?: intent.getStringExtra("number") ?: "Unknown"
        val callerName = getCallerNameFromNumber(number)

        phoneNumberText.text = number
        callerNameText.text = callerName

        // Handle call state change
        call?.registerCallback(object : Callback() {
            override fun onStateChanged(call: Call, state: Int) {
                if (state == Call.STATE_DISCONNECTED) {
                    finish()
                }
            }
        })

        // End call button
        findViewById<ImageButton>(R.id.endCallButton).setOnClickListener {
            try {
                call?.disconnect()
            } catch (e: SecurityException) {
                Log.e("CallActivity", "Failed to disconnect call: ${e.message}")
            }
        }

        // Answer call button
        findViewById<ImageButton>(R.id.answerCallButton).setOnClickListener {
            try {
                call?.answer(VideoProfile.STATE_AUDIO_ONLY)
            } catch (e: SecurityException) {
                Log.e("CallActivity", "Failed to answer call: ${e.message}")
            }
        }
    }

    private fun getCallerNameFromNumber(number: String): String {
        return when {
            number == "111" -> "Vodafone Help Menu"
            number.startsWith("1800") -> "Toll-Free"
            else -> "Unknown Caller"
        }
    }

    companion object {
        fun start(context: Context, call: Call) {
            val intent = Intent(context, CallActivity::class.java).apply {
                flags = Intent.FLAG_ACTIVITY_NEW_TASK
                putExtra("number", call.details.handle.schemeSpecificPart)
            }
            context.startActivity(intent)
        }
    }
}

// package com.broadlink.protect

// import android.os.Bundle
// import android.util.Log
// import android.content.Intent
// import io.flutter.embedding.android.FlutterActivity
// import io.flutter.embedding.android.FlutterFragmentActivity
// import io.flutter.embedding.engine.FlutterEngine
// import io.flutter.plugin.common.MethodChannel

// import android.app.Activity
// import android.content.Context
// // import android.content.Intent
// // import android.os.Bundle
// import android.telecom.Call
// import android.telecom.Call.Callback
// import android.widget.ImageButton
// import android.widget.ImageView
// import android.widget.TextView
// import com.broadlink.protect.R

// // class CallActivity : FlutterFragmentActivity() {

// //     private val CHANNEL = "com.broadlink.protect/callInfo"

// //     private val callerName = "Alice Smith"
// //     private val callerNumber = "+1234567890"

// //     override fun onCreate(savedInstanceState: Bundle?) {
// //         super.onCreate(savedInstanceState)

// //         val route = "/defaultCall"

// //         val intent = FlutterActivity
// //             .withNewEngine()
// //             .initialRoute(route)
// //             .build(this)
// //         startActivity(intent)

// //         // Optional: finish this activity if you don’t need it after starting Flutter
// //         // finish()
// //     }

// //     override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
// //         super.configureFlutterEngine(flutterEngine)

// //         MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
// //             when (call.method) {
// //                 "getCallerInfo" -> {
// //                     val callerInfo = mapOf(
// //                         "name" to callerName,
// //                         "number" to callerNumber
// //                     )
// //                     result.success(callerInfo)
// //                 }

// //                 "endCall" -> {
// //                     Log.d("CallActivity", "Call ended by user from Flutter")
// //                     finish() // or do any other cleanup
// //                     result.success(null)
// //                 }

// //                 else -> result.notImplemented()
// //             }
// //         }
// //     }

// //         companion object {
// //         fun start(context: Context, call: Call) {
// //             val intent = Intent(context, CallActivity::class.java).apply {
// //                 flags = Intent.FLAG_ACTIVITY_NEW_TASK
// //                 putExtra("number", call.details.handle.schemeSpecificPart)
// //             }
// //             context.startActivity(intent)
// //         }
// //     }
// // }



// // package com.broadlink.protect

// // import android.app.Activity
// // import android.content.Context
// // import android.content.Intent
// // import android.os.Bundle
// // import android.telecom.Call
// // import android.telecom.Call.Callback
// // import android.widget.ImageButton
// // import android.widget.ImageView
// // import android.widget.TextView
// // import com.broadlink.protect.R

// class CallActivity : Activity() {

//     private var call: Call? = null

//     override fun onCreate(savedInstanceState: Bundle?) {
//         super.onCreate(savedInstanceState)
//         setContentView(R.layout.activity_call)

//         val phoneNumberText = findViewById<TextView>(R.id.phoneNumber)
//         val callerNameText = findViewById<TextView>(R.id.callerName)

//         call = OngoingCall.call
//         val number = call?.details?.handle?.schemeSpecificPart ?: intent.getStringExtra("number") ?: "Unknown"
//         val callerName = getCallerNameFromNumber(number)

//         phoneNumberText.text = number
//         callerNameText.text = callerName

//         call?.registerCallback(object : Callback() {
//             override fun onStateChanged(call: Call, state: Int) {
//                 if (state == Call.STATE_DISCONNECTED) finish()
//             }
//         })

//         findViewById<ImageButton>(R.id.endCallButton).setOnClickListener {
//             call?.disconnect()
//         }
//     }

//     private fun getCallerNameFromNumber(number: String): String {
//         return when {
//             number == "111" -> "Vodafone Help Menu"
//             number.startsWith("1800") -> "Toll-Free"
//             else -> "Unknown Caller"
//         }
//     }

//     companion object {
//         fun start(context: Context, call: Call) {
//             val intent = Intent(context, CallActivity::class.java).apply {
//                 flags = Intent.FLAG_ACTIVITY_NEW_TASK
//                 putExtra("number", call.details.handle.schemeSpecificPart)
//             }
//             context.startActivity(intent)
//         }
//     }
// }