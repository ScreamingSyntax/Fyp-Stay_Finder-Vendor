import './model_exports.dart';

class VendorProfile {
  DateTime? date_joined;
  String? profile_picture;
  String? citizenship_back;
  String? citizenship_front;
  String? digital_signature;
  String? rejected_message;
  String? address;
  bool? is_rejected;
  bool? is_verified;
  String? error;
  VendorProfile(
      {required this.date_joined,
      this.profile_picture,
      required this.citizenship_back,
      required this.citizenship_front,
      required this.digital_signature,
      required this.rejected_message,
      required this.address,
      required this.is_rejected,
      required this.is_verified,
      required this.error});

  VendorProfile.withError({required String error}) {
    this.error = error;
  }

  VendorProfile copyWith({
    DateTime? date_joined,
    String? profile_picture,
    String? citizenship_back,
    String? citizenship_front,
    String? digital_signature,
    String? rejected_message,
    String? address,
    bool? is_rejected,
    bool? is_verified,
    String? error,
  }) {
    return VendorProfile(
      date_joined: date_joined ?? this.date_joined,
      profile_picture: profile_picture ?? this.profile_picture,
      citizenship_back: citizenship_back ?? this.citizenship_back,
      citizenship_front: citizenship_front ?? this.citizenship_front,
      digital_signature: digital_signature ?? this.digital_signature,
      rejected_message: rejected_message ?? this.rejected_message,
      address: address ?? this.address,
      is_rejected: is_rejected ?? this.is_rejected,
      is_verified: is_verified ?? this.is_verified,
      error: error ?? this.error,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date_joined': date_joined?.millisecondsSinceEpoch,
      'profile_picture': profile_picture,
      'citizenship_back': citizenship_back,
      'citizenship_front': citizenship_front,
      'digital_signature': digital_signature,
      'rejected_message': rejected_message,
      'address': address,
      'is_rejected': is_rejected,
      'is_verified': is_verified,
      'error': error,
    };
  }

  factory VendorProfile.fromMap(Map<String, dynamic> map) {
    return VendorProfile(
      date_joined: map['date_joined'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['date_joined'] as int)
          : null,
      profile_picture: map['profile_picture'] != null
          ? map['profile_picture'] as String
          : null,
      citizenship_back: map['citizenship_back'] != null
          ? map['citizenship_back'] as String
          : null,
      citizenship_front: map['citizenship_front'] != null
          ? map['citizenship_front'] as String
          : null,
      digital_signature: map['digital_signature'] != null
          ? map['digital_signature'] as String
          : null,
      rejected_message: map['rejected_message'] != null
          ? map['rejected_message'] as String
          : null,
      address: map['address'] != null ? map['address'] as String : null,
      is_rejected:
          map['is_rejected'] != null ? map['is_rejected'] as bool : null,
      is_verified:
          map['is_verified'] != null ? map['is_verified'] as bool : null,
      error: map['error'] != null ? map['error'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory VendorProfile.fromJson(String source) =>
      VendorProfile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VendorProfile(date_joined: $date_joined, profile_picture: $profile_picture, citizenship_back: $citizenship_back, citizenship_front: $citizenship_front, digital_signature: $digital_signature, rejected_message: $rejected_message, address: $address, is_rejected: $is_rejected, is_verified: $is_verified, error: $error)';
  }

  @override
  bool operator ==(covariant VendorProfile other) {
    if (identical(this, other)) return true;

    return other.date_joined == date_joined &&
        other.profile_picture == profile_picture &&
        other.citizenship_back == citizenship_back &&
        other.citizenship_front == citizenship_front &&
        other.digital_signature == digital_signature &&
        other.rejected_message == rejected_message &&
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
        digital_signature.hashCode ^
        rejected_message.hashCode ^
        address.hashCode ^
        is_rejected.hashCode ^
        is_verified.hashCode ^
        error.hashCode;
  }
}
