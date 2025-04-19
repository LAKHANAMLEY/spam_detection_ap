package com.broadlink.protect

import android.content.Intent
import android.telecom.Call
import android.telecom.InCallService

class CallService : InCallService() {

    override fun onCallAdded(call: Call) {
        OngoingCall.call = call
        CallActivity.start(this, call)
    }

    override fun onCallRemoved(call: Call) {
        if (OngoingCall.call == call) {
            OngoingCall.call = null
        }
    }
}
