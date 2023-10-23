import './model_exports.dart';

class Success {
  int? success;
  String? message;
  String? token;
  String? error;
  Success({
    required this.success,
    required this.message,
    required this.token,
    required this.error,
  });
  Success.withError(String errorMessage) {
    error = errorMessage;
  }

  Success copyWith({
    int? success,
    String? message,
    String? token,
    String? error,
  }) {
    return Success(
      success: success ?? this.success,
      message: message ?? this.message,
      token: token ?? this.token,
      error: error ?? this.error,
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
    return 'Success(success: $success, message: $message, token: $token, error: $error)';
  }

  @override
  bool operator ==(covariant Success other) {
    if (identical(this, other)) return true;

    return other.success == success &&
        other.message == message &&
        other.token == token &&
        other.error == error;
  }

  @override
  int get hashCode {
    return success.hashCode ^
        message.hashCode ^
        token.hashCode ^
        error.hashCode;
  }
}
