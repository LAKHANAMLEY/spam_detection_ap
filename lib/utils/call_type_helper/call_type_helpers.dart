import 'package:call_e_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:phone_state_background/phone_state_background.dart';
import 'package:spam_delection_app/constants/icons_constants.dart';
import 'package:spam_delection_app/constants/svg_icons.dart';
import 'package:spam_delection_app/data/models/call_logs/call_logs_model.dart';

class CallTypeHelper {
  static String getCallTypeImage(CallLogData callLog) {
    var callType = getCallLogType(callLog.callType);
    if (callLog.isSpam == 1) {
      return IconConstants.icSpamCircle;
    } else {
      switch (callType) {
        case null:
          return IconConstants.icCallRegular;
        case CallType.incoming:
          return IconConstants.icIncoming;
        case CallType.outgoing:
          return IconConstants.icOutgoing;
        case CallType.missed:
          return IconConstants.icMissCall1;
        case CallType.voiceMail:
          return IconConstants.icFluentMail;
        case CallType.rejected:
          return IconConstants.icMissCall1;
        case CallType.blocked:
          return IconConstants.icBlockCall;
        case CallType.answeredExternally:
          return IconConstants.icCallRegular;
        case CallType.unknown:
          return IconConstants.icCallRegular;
        case CallType.wifiIncoming:
          return IconConstants.icIncoming;
        case CallType.wifiOutgoing:
          return IconConstants.icOutgoing;
      }
    }
  }

  static String getSvgImageByCallType(CallLogData callLog) {
    var callType = getCallLogType(callLog.callType);
    if (callLog.isSpam == 1) {
      return SvgIcons.spam;
    } else {
      switch (callType) {
        case null:
          return SvgIcons.callIncoming;
        case CallType.incoming:
          return SvgIcons.callIncoming;
        case CallType.outgoing:
          return SvgIcons.callOutgoing;
        case CallType.missed:
          return SvgIcons.callMissed;
        case CallType.voiceMail:
          return SvgIcons.callIncoming;
        case CallType.rejected:
          return SvgIcons.callMissed;
        case CallType.blocked:
          return SvgIcons.callBlocked;
        case CallType.answeredExternally:
          return SvgIcons.callIncoming;
        case CallType.unknown:
          return SvgIcons.callIncoming;
        case CallType.wifiIncoming:
          return SvgIcons.callIncoming;
        case CallType.wifiOutgoing:
          return SvgIcons.callIncoming;
      }
    }
  }

  static Color getCallTypeTextColor(String? callLogType) {
    var callType = getCallLogType(callLogType);
    switch (callType) {
      case CallType.incoming:
        return Colors.grey;
      case CallType.outgoing:
        return Colors.grey;
      case CallType.missed:
        return Colors.red;
      case CallType.voiceMail:
        return Colors.grey;
      case CallType.rejected:
        return Colors.red;
      case CallType.blocked:
        return Colors.red;
      case CallType.answeredExternally:
        return Colors.grey;
      case CallType.unknown:
        return Colors.grey;
      case CallType.wifiIncoming:
        return Colors.grey;
      case CallType.wifiOutgoing:
        return Colors.grey;
      case null:
        return Colors.grey;
    }
  }

  static Color getCallTypeIconColor(String? callLogType) {
    var callType = getCallLogType(callLogType);
    switch (callType) {
      case CallType.incoming:
        return Colors.green;
      case CallType.outgoing:
        return Colors.blue;
      case CallType.missed:
        return Colors.red;
      case CallType.voiceMail:
        return Colors.grey;
      case CallType.rejected:
        return Colors.red;
      case CallType.blocked:
        return Colors.red;
      case CallType.answeredExternally:
        return Colors.green;
      case CallType.unknown:
        return Colors.grey;
      case CallType.wifiIncoming:
        return Colors.green;
      case CallType.wifiOutgoing:
        return Colors.blue;
      case null:
        return Colors.grey;
    }
  }

  static IconData getCallTypeIcon(String? callLogType) {
    var callType = getCallLogType(callLogType);
    switch (callType) {
      case CallType.incoming:
        return Icons.call_received;
      case CallType.outgoing:
        return Icons.call_made;
      case CallType.missed:
        return Icons.call_missed;
      case CallType.voiceMail:
        return Icons.voicemail_sharp;
      case CallType.rejected:
        return Icons.call_end;
      case CallType.blocked:
        return Icons.block;
      case CallType.answeredExternally:
        return Icons.call_received;
      case CallType.unknown:
        return Icons.device_unknown;
      case CallType.wifiIncoming:
        return Icons.wifi_calling;
      case CallType.wifiOutgoing:
        return Icons.wifi_calling_3;
      case null:
        return Icons.call_received;
    }
  }

  static CallType? getCallLogType(String? callLogType) {
    switch (callLogType) {
      case null:
        return null;
      case "incoming":
        return CallType.incoming;
      case "outgoing":
        return CallType.outgoing;
      case "missed":
        return CallType.missed;
      case "voiceMail":
        return CallType.voiceMail;
      case "rejected":
        return CallType.rejected;
      case "blocked":
        return CallType.blocked;
      case "answeredExternally":
        return CallType.answeredExternally;
      case "unknown":
        return CallType.unknown;
      case "wifiIncoming":
        return CallType.wifiIncoming;
      case "wifiOutgoing":
        return CallType.wifiOutgoing;
//Phone state background cases
      case "incomingstart":
        return CallType.incoming;
      case "incomingmissed":
        return CallType.missed;
      case "incomingreceived":
        return CallType.incoming;
      case "incomingend":
        return CallType.incoming;
      case "outgoingend":
        return CallType.outgoing;
      case "outgoingstart":
        return CallType.outgoing;

      case "NOTHING":
        return CallType.unknown;
      case "CALL_INCOMING":
        return CallType.incoming;
      case "CALL_STARTED":
        return CallType.incoming;
      case "CALL_ENDED":
        return CallType.rejected;
      default:
        return null;
    }
  }

  static String getCallTypeStringFromBGPhoneState(
      PhoneStateBackgroundEvent phoneState) {
    switch (phoneState) {
      case PhoneStateBackgroundEvent.incomingstart:
        return "Incoming call";
      case PhoneStateBackgroundEvent.incomingmissed:
        return "Missed call";
      case PhoneStateBackgroundEvent.incomingreceived:
        return "Ongoing call";
      case PhoneStateBackgroundEvent.incomingend:
        return "Call end";
      case PhoneStateBackgroundEvent.outgoingend:
        return "Call end";
      case PhoneStateBackgroundEvent.outgoingstart:
        return "Ongoing call";
    }
  }

// String getCallTypeByPhoneState(PhoneState phoneState) {
//   switch (phoneState.status) {
//     case PhoneStateStatus.NOTHING:
//       return "Unknown";
//     case PhoneStateStatus.CALL_INCOMING:
//       return "Incoming call";
//     case PhoneStateStatus.CALL_STARTED:
//       return "Ongoing call";
//     case PhoneStateStatus.CALL_ENDED:
//       return "Call end";
//   }
// }
}
