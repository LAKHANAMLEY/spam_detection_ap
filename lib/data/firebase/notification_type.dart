enum NotificationType {
  profileUpdate,
  kycUnderReview,
  kycApproved,
  kycSuspended,
  kycUploaded,
  kycUpdated,
  kycRejected,
  transaction,
  requestToPay,
  paymentSent,
  paymentReceived,
  kycExpired,
  invoiceGenerated,
  invoiceUpdated,
  kycStatus,
  default1,
}

final notificationTypeValues = EnumValues({
  "profile_update": NotificationType.profileUpdate,
  "kyc_under_review": NotificationType.kycUnderReview,
  "kyc_approved": NotificationType.kycApproved,
  "kyc_suspended": NotificationType.kycSuspended,
  "kyc_uploaded": NotificationType.kycUploaded,
  "kyc_updated": NotificationType.kycUpdated,
  "kyc_rejected": NotificationType.kycRejected,
  "kyc_expired": NotificationType.kycExpired,
  "transaction": NotificationType.transaction,
  "request_to_pay": NotificationType.requestToPay,
  "payment_sent": NotificationType.paymentSent,
  "payment_received": NotificationType.paymentReceived,
  "Invoice generated": NotificationType.invoiceGenerated,
  "Invoice Updated": NotificationType.invoiceUpdated,
  "KYC Status": NotificationType.kycStatus,
  "default": NotificationType.default1,
});

extension NotificationExtension on NotificationType {
  static const Map<NotificationType, String> keys = {
    NotificationType.profileUpdate: 'profile_update',
    NotificationType.kycUnderReview: 'kyc_under_review',
    NotificationType.kycApproved: 'kyc_approved',
    NotificationType.kycSuspended: 'kyc_suspended',
    NotificationType.kycUploaded: 'kyc_uploaded',
    NotificationType.kycRejected: 'kyc_rejected',
    NotificationType.kycExpired: 'kyc_expired',
    NotificationType.transaction: 'transaction',
    NotificationType.requestToPay: 'request_to_pay',
    NotificationType.paymentSent: 'payment_sent',
    NotificationType.paymentReceived: 'payment_received',
    NotificationType.invoiceGenerated: 'Invoice generated',
    NotificationType.invoiceUpdated: 'Invoice Updated',
    NotificationType.kycStatus: 'KYC Status',
    NotificationType.default1: 'default',
  };

  static const Map<NotificationType, String> values = {
    NotificationType.profileUpdate: 'Profile update',
    NotificationType.kycUnderReview: 'KYC under review',
    NotificationType.kycApproved: 'KYC approved',
    NotificationType.kycSuspended: 'KYC suspended',
    NotificationType.kycUploaded: 'KYC uploaded',
    NotificationType.kycRejected: 'KYC rejected',
    NotificationType.kycExpired: 'KYC expired',
    NotificationType.transaction: 'Transaction',
    NotificationType.requestToPay: 'Request to pay',
    NotificationType.paymentSent: 'Payment sent',
    NotificationType.paymentReceived: 'Payment received',
    NotificationType.invoiceGenerated: 'Invoice generated',
    NotificationType.invoiceUpdated: 'Invoice updated',
    NotificationType.kycStatus: 'KYC Status',
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
