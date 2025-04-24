import 'package:spam_delection_app/lib.dart';

extension CopyWith on SmsMessage {
  SmsMessage copyWith(
      {int? id,
      String? address,
      String? body,
      int? threadId,
      int? sim,
      bool? read,
      DateTime? date,
      DateTime? dateSent,
      SmsMessageKind? kind}) {
    return SmsMessage(
      address ?? this.address,
      body ?? this.body,
      id: id ?? this.id,
      threadId: threadId ?? this.threadId,
      sim: sim ?? this.sim,
      read: read ?? isRead,
      date: date ?? this.date,
      dateSent: dateSent ?? this.dateSent,
      kind: kind ?? this.kind,
    );
  }
}
