// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NotificationModel {
  String? description;
  bool? isSeen;
  String? added_date;
  String? notification_type;
  String? error;
  NotificationModel({
    this.description,
    this.isSeen,
    this.added_date,
    this.notification_type,
    this.error,
  });

  NotificationModel.withError({required String error}) {
    this.error = error;
  }

  NotificationModel copyWith({
    String? description,
    bool? isSeen,
    String? added_date,
    String? notification_type,
    String? error,
  }) {
    return NotificationModel(
      description: description ?? this.description,
      isSeen: isSeen ?? this.isSeen,
      added_date: added_date ?? this.added_date,
      notification_type: notification_type ?? this.notification_type,
      error: error ?? this.error,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'description': description,
      'isSeen': isSeen,
      'added_date': added_date,
      'notification_type': notification_type,
      'error': error,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      description:
          map['description'] != null ? map['description'] as String : null,
      isSeen: map['isSeen'] != null ? map['isSeen'] as bool : null,
      added_date:
          map['added_date'] != null ? map['added_date'] as String : null,
      notification_type: map['notification_type'] != null
          ? map['notification_type'] as String
          : null,
      error: map['error'] != null ? map['error'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NotificationModel(description: $description, isSeen: $isSeen, added_date: $added_date, notification_type: $notification_type, error: $error)';
  }

  @override
  bool operator ==(covariant NotificationModel other) {
    if (identical(this, other)) return true;

    return other.description == description &&
        other.isSeen == isSeen &&
        other.added_date == added_date &&
        other.notification_type == notification_type &&
        other.error == error;
  }

  @override
  int get hashCode {
    return description.hashCode ^
        isSeen.hashCode ^
        added_date.hashCode ^
        notification_type.hashCode ^
        error.hashCode;
  }
}
