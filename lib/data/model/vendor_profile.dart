// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import './model_exports.dart';

class VendorProfile {
  String? date_joined;
  String? profile_picture;
  String? citizenship_back;
  String? citizenship_front;
  String? rejected_message;
  String? is_under_verification_process;
  String? address;
  String? is_rejected;
  String? is_verified;
  String? error;
  VendorProfile(
      {required this.date_joined,
      this.profile_picture,
      required this.citizenship_back,
      required this.citizenship_front,
      required this.rejected_message,
      required this.is_under_verification_process,
      required this.address,
      required this.is_rejected,
      required this.is_verified,
      required this.error});
  VendorProfile.withError({required String error}) {
    this.error = error;
  }

  VendorProfile copyWith({
    String? date_joined,
    String? profile_picture,
    String? citizenship_back,
    String? citizenship_front,
    String? rejected_message,
    String? is_under_verification_process,
    String? address,
    String? is_rejected,
    String? is_verified,
    String? error,
  }) {
    return VendorProfile(
      date_joined: date_joined ?? this.date_joined,
      profile_picture: profile_picture ?? this.profile_picture,
      citizenship_back: citizenship_back ?? this.citizenship_back,
      citizenship_front: citizenship_front ?? this.citizenship_front,
      rejected_message: rejected_message ?? this.rejected_message,
      is_under_verification_process:
          is_under_verification_process ?? this.is_under_verification_process,
      address: address ?? this.address,
      is_rejected: is_rejected ?? this.is_rejected,
      is_verified: is_verified ?? this.is_verified,
      error: error ?? this.error,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date_joined': date_joined,
      'profile_picture': profile_picture,
      'citizenship_back': citizenship_back,
      'citizenship_front': citizenship_front,
      'rejected_message': rejected_message,
      'is_under_verification_process': is_under_verification_process,
      'address': address,
      'is_rejected': is_rejected,
      'is_verified': is_verified,
      'error': error,
    };
  }

  factory VendorProfile.fromMap(Map<String, dynamic> map) {
    return VendorProfile(
      date_joined:
          map['date_joined'] != null ? map['date_joined'] as String : null,
      profile_picture: map['profile_picture'] != null
          ? map['profile_picture'] as String
          : null,
      citizenship_back: map['citizenship_back'] != null
          ? map['citizenship_back'] as String
          : null,
      citizenship_front: map['citizenship_front'] != null
          ? map['citizenship_front'] as String
          : null,
      rejected_message: map['rejected_message'] != null
          ? map['rejected_message'] as String
          : null,
      is_under_verification_process:
          map['is_under_verification_process'] != null
              ? map['is_under_verification_process'] as String
              : null,
      address: map['address'] != null ? map['address'] as String : null,
      is_rejected:
          map['is_rejected'] != null ? map['is_rejected'] as String : null,
      is_verified:
          map['is_verified'] != null ? map['is_verified'] as String : null,
      error: map['error'] != null ? map['error'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory VendorProfile.fromJson(String source) =>
      VendorProfile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VendorProfile(date_joined: $date_joined, profile_picture: $profile_picture, citizenship_back: $citizenship_back, citizenship_front: $citizenship_front, rejected_message: $rejected_message, is_under_verification_process: $is_under_verification_process, address: $address, is_rejected: $is_rejected, is_verified: $is_verified, error: $error)';
  }

  @override
  bool operator ==(covariant VendorProfile other) {
    if (identical(this, other)) return true;

    return other.date_joined == date_joined &&
        other.profile_picture == profile_picture &&
        other.citizenship_back == citizenship_back &&
        other.citizenship_front == citizenship_front &&
        other.rejected_message == rejected_message &&
        other.is_under_verification_process == is_under_verification_process &&
        other.address == address &&
        other.is_rejected == is_rejected &&
        other.is_verified == is_verified &&
        other.error == error;
  }

  @override
  int get hashCode {
    return date_joined.hashCode ^
        profile_picture.hashCode ^
        citizenship_back.hashCode ^
        citizenship_front.hashCode ^
        rejected_message.hashCode ^
        is_under_verification_process.hashCode ^
        address.hashCode ^
        is_rejected.hashCode ^
        is_verified.hashCode ^
        error.hashCode;
  }
}
