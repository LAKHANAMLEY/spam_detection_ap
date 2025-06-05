class CallData {
  final String avatar;
  final int normalHandle;
  final String id;
  final String uuid;
  final String appName;
  final int type;
  final Map<String, dynamic> extra;
  final String nameCaller;
  final Ios ios;
  final String handle;
  final int duration;

  CallData({
    required this.avatar,
    required this.normalHandle,
    required this.id,
    required this.uuid,
    required this.appName,
    required this.type,
    required this.extra,
    required this.nameCaller,
    required this.ios,
    required this.handle,
    required this.duration,
  });

  factory CallData.fromJson(Map<String, dynamic> json) {
    return CallData(
      avatar: json['avatar'] ?? '',
      normalHandle: json['normalHandle'] ?? 0,
      id: json['id'] ?? '',
      uuid: json['uuid'] ?? '',
      appName: json['appName'] ?? '',
      type: json['type'] ?? 0,
      extra: json['extra'] ?? {},
      nameCaller: json['nameCaller'] ?? '',
      ios: Ios.fromJson(json['ios'] ?? {}),
      handle: json['handle'] ?? '',
      duration: json['duration'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'avatar': avatar,
      'normalHandle': normalHandle,
      'id': id,
      'uuid': uuid,
      'appName': appName,
      'type': type,
      'extra': extra,
      'nameCaller': nameCaller,
      'ios': ios.toJson(),
      'handle': handle,
      'duration': duration,
    };
  }
}

class Ios {
  final String iconName;
  final bool supportsVideo;
  final double audioSessionPreferredIOBufferDuration;
  final bool audioSessionActive;
  final int maximumCallsPerCallGroup;
  final String audioSessionMode;
  final bool supportsGrouping;
  final int maximumCallGroups;
  final bool includesCallsInRecents;
  final double audioSessionPreferredSampleRate;
  final bool configureAudioSession;
  final String ringtonePath;
  final bool supportsUngrouping;
  final bool supportsHolding;
  final String handleType;
  final bool supportsDTMF;

  Ios({
    required this.iconName,
    required this.supportsVideo,
    required this.audioSessionPreferredIOBufferDuration,
    required this.audioSessionActive,
    required this.maximumCallsPerCallGroup,
    required this.audioSessionMode,
    required this.supportsGrouping,
    required this.maximumCallGroups,
    required this.includesCallsInRecents,
    required this.audioSessionPreferredSampleRate,
    required this.configureAudioSession,
    required this.ringtonePath,
    required this.supportsUngrouping,
    required this.supportsHolding,
    required this.handleType,
    required this.supportsDTMF,
  });

  factory Ios.fromJson(Map<String, dynamic> json) {
    return Ios(
      iconName: json['iconName'] ?? '',
      supportsVideo: json['supportsVideo'] ?? false,
      audioSessionPreferredIOBufferDuration:
          (json['audioSessionPreferredIOBufferDuration'] ?? 0.0).toDouble(),
      audioSessionActive: json['audioSessionActive'] ?? false,
      maximumCallsPerCallGroup: json['maximumCallsPerCallGroup'] ?? 0,
      audioSessionMode: json['audioSessionMode'] ?? '',
      supportsGrouping: json['supportsGrouping'] ?? false,
      maximumCallGroups: json['maximumCallGroups'] ?? 0,
      includesCallsInRecents: json['includesCallsInRecents'] ?? false,
      audioSessionPreferredSampleRate:
          (json['audioSessionPreferredSampleRate'] ?? 0.0).toDouble(),
      configureAudioSession: json['configureAudioSession'] ?? false,
      ringtonePath: json['ringtonePath'] ?? '',
      supportsUngrouping: json['supportsUngrouping'] ?? false,
      supportsHolding: json['supportsHolding'] ?? false,
      handleType: json['handleType'] ?? '',
      supportsDTMF: json['supportsDTMF'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'iconName': iconName,
      'supportsVideo': supportsVideo,
      'audioSessionPreferredIOBufferDuration':
          audioSessionPreferredIOBufferDuration,
      'audioSessionActive': audioSessionActive,
      'maximumCallsPerCallGroup': maximumCallsPerCallGroup,
      'audioSessionMode': audioSessionMode,
      'supportsGrouping': supportsGrouping,
      'maximumCallGroups': maximumCallGroups,
      'includesCallsInRecents': includesCallsInRecents,
      'audioSessionPreferredSampleRate': audioSessionPreferredSampleRate,
      'configureAudioSession': configureAudioSession,
      'ringtonePath': ringtonePath,
      'supportsUngrouping': supportsUngrouping,
      'supportsHolding': supportsHolding,
      'handleType': handleType,
      'supportsDTMF': supportsDTMF,
    };
  }
}
