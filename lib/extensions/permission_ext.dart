import 'package:permission_handler/permission_handler.dart';

extension PermissionName on Permission {
  String get name {
    switch (this) {
      case Permission.calendarFullAccess:
        return 'Calendar';
      case Permission.camera:
        return 'Camera';
      case Permission.contacts:
        return 'Contacts';
      case Permission.location:
        return 'Location';
      case Permission.locationAlways:
        return 'Location Always';
      case Permission.locationWhenInUse:
        return 'Location When In Use';
      case Permission.mediaLibrary:
        return 'Media Library';
      case Permission.microphone:
        return 'Microphone';
      case Permission.nearbyWifiDevices:
        return 'Nearby Wifi Devices';
      case Permission.phone:
        return 'Phone';
      case Permission.photos:
        return 'Photos';
      case Permission.reminders:
        return 'Reminders';
      case Permission.sensors:
        return 'Sensors';
      case Permission.sms:
        return 'SMS';
      case Permission.speech:
        return 'Speech';
      case Permission.storage: // Deprecated in newer Android versions
        return 'Storage';
      case Permission.ignoreBatteryOptimizations:
        return 'Ignore Battery Optimizations';
      case Permission.notification:
        return 'Notifications';
      case Permission.bluetooth:
        return 'Bluetooth';
      case Permission.bluetoothConnect:
        return 'Bluetooth Connect';
      case Permission.bluetoothScan:
        return 'Bluetooth Scan';
      case Permission.bluetoothAdvertise:
        return 'Bluetooth Advertise';
      case Permission.manageExternalStorage:
        return 'Manage External Storage';
      case Permission.accessMediaLocation:
        return 'Access Media Location';
      case Permission.activityRecognition:
        return 'Activity Recognition';
      case Permission.unknown:
      default:
        return 'Unknown Permission';
    }
  }
}
