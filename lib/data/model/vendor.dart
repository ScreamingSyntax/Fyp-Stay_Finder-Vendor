// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import './model_exports.dart';

class Vendor {
  int? id;
  String? email;
  String? phoneNumber;
  bool? isVerified;
  String? fullName;
  String? full_name;

  String? error;
  String? password;
  String? otp;
  String? image;
  Vendor({
    this.id,
    this.email,
    this.phoneNumber,
    this.isVerified,
    this.fullName,
    this.full_name,
    this.error,
    this.password,
    this.otp,
    this.image,
  });
  Vendor.withError({required error}) {
    this.error = error;
  }
  Vendor copyWith({
    int? id,
    String? email,
    String? phoneNumber,
    bool? isVerified,
    String? fullName,
    String? full_name,
    String? error,
    String? password,
    String? otp,
    String? image,
  }) {
    return Vendor(
      id: id ?? this.id,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isVerified: isVerified ?? this.isVerified,
      fullName: fullName ?? this.fullName,
      full_name: full_name ?? this.full_name,
      error: error ?? this.error,
      password: password ?? this.password,
      otp: otp ?? this.otp,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'phoneNumber': phoneNumber,
      'isVerified': isVerified,
      'fullName': fullName,
      'full_name': full_name,
      'error': error,
      'password': password,
      'otp': otp,
      'image': image,
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
      full_name: map['full_name'] != null ? map['full_name'] as String : null,
      error: map['error'] != null ? map['error'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      otp: map['otp'] != null ? map['otp'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Vendor.fromJson(String source) =>
      Vendor.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Vendor(id: $id, email: $email, phoneNumber: $phoneNumber, isVerified: $isVerified, fullName: $fullName, full_name: $full_name, error: $error, password: $password, otp: $otp, image: $image)';
  }

  @override
  bool operator ==(covariant Vendor other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.isVerified == isVerified &&
        other.fullName == fullName &&
        other.full_name == full_name &&
        other.error == error &&
        other.password == password &&
        other.otp == otp &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        isVerified.hashCode ^
        fullName.hashCode ^
        full_name.hashCode ^
        error.hashCode ^
        password.hashCode ^
        otp.hashCode ^
        image.hashCode;
  }
}
