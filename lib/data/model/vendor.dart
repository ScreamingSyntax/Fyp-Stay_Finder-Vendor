// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Vendor {
  int? id;
  String? email;
  String? phoneNumber;
  bool? isVerified;
  String? fullName;
  String? error;
  String? password;
  String? otp;
  Vendor(
      {required this.id,
      required this.email,
      required this.phoneNumber,
      required this.isVerified,
      required this.fullName,
      this.error,
      this.password,
      this.otp});
  Vendor.withError({required error}) {
    this.error = error;
  }
  Vendor copyWith({
    int? id,
    String? email,
    String? phoneNumber,
    bool? isVerified,
    String? fullName,
    String? error,
    String? password,
    String? otp,
  }) {
    return Vendor(
      id: id ?? this.id,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isVerified: isVerified ?? this.isVerified,
      fullName: fullName ?? this.fullName,
      error: error ?? this.error,
      password: password ?? this.password,
      otp: otp ?? this.otp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'phoneNumber': phoneNumber,
      'isVerified': isVerified,
      'fullName': fullName,
      'error': error,
      'password': password,
      'otp': otp,
    };
  }

  factory Vendor.fromMap(Map<String, dynamic> map) {
    return Vendor(
      id: map['id'] != null ? map['id'] as int : null,
      email: map['email'] != null ? map['email'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      isVerified: map['isVerified'] != null ? map['isVerified'] as bool : null,
      fullName: map['fullName'] != null ? map['fullName'] as String : null,
      error: map['error'] != null ? map['error'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      otp: map['otp'] != null ? map['otp'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Vendor.fromJson(String source) =>
      Vendor.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Vendor(id: $id, email: $email, phoneNumber: $phoneNumber, isVerified: $isVerified, fullName: $fullName, error: $error, password: $password, otp: $otp)';
  }

  @override
  bool operator ==(covariant Vendor other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.isVerified == isVerified &&
        other.fullName == fullName &&
        other.error == error &&
        other.password == password &&
        other.otp == otp;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        isVerified.hashCode ^
        fullName.hashCode ^
        error.hashCode ^
        password.hashCode ^
        otp.hashCode;
  }
}
