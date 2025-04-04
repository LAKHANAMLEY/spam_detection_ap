package com.broadlink.protect

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Build
import android.provider.Settings.Secure
import android.provider.Telephony
import android.widget.Toast
import androidx.core.content.ContextCompat.getSystemService
import com.google.gson.JsonObject

class SmsReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context?, intent: Intent?) {
        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
                for (sms in Telephony.Sms.Intents.getMessagesFromIntent(intent)) {
                    System.out.println("SMS from Receiver:" + sms.displayMessageBody);

                    Toast.makeText(context, "${sms.displayMessageBody}", Toast.LENGTH_SHORT).show()
                }
            }
        } catch (e: Exception) {
            
        }
    }
}