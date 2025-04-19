import 'package:flutter/services.dart';

class CallController {
  static const callChannel = MethodChannel('com.broadlink.protect/call');

  static Future<void> setDefaultCallingApp() async {
    try {
      await callChannel.invokeMethod('requestDefaultDialer');
    } on PlatformException catch (e) {
      print("Error setting default Calling app: $e");
    }
  }

  static Future<void> endCall() async {
    try {
      final result = await callChannel.invokeMethod('endCall');
      print(result); // Handle the result
    } catch (e) {
      print("Error ending call: $e");
    }
  }

  static Future<void> addCall() async {
    try {
      final result = await callChannel.invokeMethod('addCall');
      print(result); // Handle the result
    } catch (e) {
      print("Error adding call: $e");
    }
  }

  static Future<void> mute() async {
    try {
      final result = await callChannel.invokeMethod('mute');
      print(result); // Handle the result
    } catch (e) {
      print("Error muting: $e");
    }
  }

  static Future<void> unmute() async {
    try {
      final result = await callChannel.invokeMethod('unmute');
      print(result); // Handle the result
    } catch (e) {
      print("Error unmuting: $e");
    }
  }
}
