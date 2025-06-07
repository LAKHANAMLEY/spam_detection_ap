// Install with: npm install apn

const apn = require('apn');

// Use your VoIP certificate and key (in .p8 or .pem format)
const options = {
    token: {
        key: "/Volumes/RK TOSHIBA EXT/Flutter Projects/new/spam_detection_ap/IOS_certificates/AuthKey_55CXHAQ795.p8", // Path to your .p8 key file
        keyId: "55CXHAQ795",         // Your Key ID from Apple Developer portal
        teamId: "GJ5QF3WRZP",       // Your Apple Developer Team ID
    },
    production: false, // false for sandbox, true for production
};

const apnProvider = new apn.Provider(options);

// The VoIP device token you want to send to
// const deviceToken = "C4ABD8C071077B1F33B3BFE2C1FAB9D05B19769449167F857929BFB3A3B05BD3";
const deviceToken = "80B8F04CB2B50A6C1DB358CD57279FD88A571FAA35662CD140949AD11C0AA0E5A5B3AA8D508952A690BBB547813EFE8F87A3860B999B58311DE7D26ED949425F4C7897014E103E876DEED884FA623E24";

// Create the VoIP notification payload
const notification = new apn.Notification();
notification.topic = "com.broadlink.protect.voip"; // Your app's bundle id + '.voip'
notification.pushType = "voip";
notification.payload = {
    'session_id': "1234567890", // Unique session ID for the call
    'callerName': "John Doe", // Name of the caller
    'callerId': "1234567890", // Caller ID (phone number)
    'callerAvatar': "https://example.com/avatar.jpg", // URL to caller's avatar image
    'callType': "audio", // Type of call (audio/video)
    'callDuration': 0, // Duration of the call in seconds (0 for incoming call)
    'callUUID': "uuid-1234-5678-9012-345678901234", // Unique UUID for the call
    'appName': "Protect", // Name of the app

    'avatar': "avatar",
    'normalHandle': "normalHandle",
    'id': "id",
    'uuid': "uuid",
    'appName': "appName",
    'type': "type",
    'extra': "extra",
    'nameCaller': "nameCaller",
    'ios': "ios.toJson()",
    'handle': "handle",
    'duration': "duration",


    // Custom data for your app
    // "callerName": "Test User",
    // "uuid": "some-unique-uuid",
    // "title": "Incoming Call",
    // "body": "John is calling you...",
    // "mode": "live",
    // "receiver_no": "9977699665",
    // "payload": {
    //     "aps": {
    //         "content-available": 1,
    //         "alert": {
    //             "title": "Incoming Call",
    //             "body": "John is calling you..."
    //         },
    //         "sound": "default"
    //     },
    //     "caller_name": "John",
    //     "call_id": "123456",
    //     "type": "voip"
    // }

};

apnProvider.send(notification, deviceToken).then(result => {
    console.log("Result:", result);
    console.log("Sent:", result.sent.length);
    console.log("Failed:", result.failed.length, result.failed);
    apnProvider.shutdown();
}).catch(err => {
    console.error("Error sending VoIP push:", err);
});