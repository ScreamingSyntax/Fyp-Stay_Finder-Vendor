// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import './model_exports.dart';

class Success {
  int? success;
  String? message;
  String? token;
  String? error;
  Map? data;
  Success({
    this.success,
    this.message,
    this.token,
    this.error,
    this.data,
  });
  Success.withError(String error) {
    this.error = error;
  }
  Success copyWith({
    int? success,
    String? message,
    String? token,
    String? error,
    Map? data,
  }) {
    return Success(
      success: success ?? this.success,
      message: message ?? this.message,
      token: token ?? this.token,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'success': success,
      'message': message,
      'token': token,
      'error': error,
    };
  }

  factory Success.fromMap(Map<String, dynamic> map) {
    return Success(
      success: map['success'] != null ? map['success'] as int : null,
      message: map['message'] != null ? map['message'] as String : null,
      token: map['token'] != null ? map['token'] as String : null,
      error: map['error'] != null ? map['error'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Success.fromJson(String source) =>
      Success.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Success(success: $success, message: $message, token: $token, error: $error, data: $data)';
  }

  @override
  bool operator ==(covariant Success other) {
    if (identical(this, other)) return true;

    return other.success == success &&
        other.message == message &&
        other.token == token &&
        other.error == error &&
        other.data == data;
  }

  @override
  int get hashCode {
    return success.hashCode ^
        message.hashCode ^
        token.hashCode ^
        error.hashCode ^
        data.hashCode;
  }
}
