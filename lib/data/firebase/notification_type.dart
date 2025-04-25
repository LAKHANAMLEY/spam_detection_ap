enum NotificationType {
  membership,
  profileVisitor,
  default1,
}

final notificationTypeValues = EnumValues({
  "membership": NotificationType.membership,
  "profile-visitor": NotificationType.profileVisitor,
  "default": NotificationType.default1,
});

extension NotificationExtension on NotificationType {
  static const Map<NotificationType, String> keys = {
    NotificationType.membership: 'membership',
    NotificationType.profileVisitor: 'profile-visitor',
    NotificationType.default1: 'default',
  };
  static const Map<NotificationType, String> values = {
    NotificationType.membership: 'membership',
    NotificationType.profileVisitor: 'profile-visitor',
    NotificationType.default1: 'default',
  };

  String? get key => keys[this];

  String? get value => values[this];

  // NEW
  static NotificationType? fromRaw(String raw) => keys.entries
      .firstWhere((e) => e.value == raw,
          orElse: () => {NotificationType.default1: "default"}.entries.first)
      .key;
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
