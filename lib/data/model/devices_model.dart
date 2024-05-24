// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DevicesModel {
  String? device_id;
  String? device_model;
  String? error;
  DevicesModel({
    this.device_id,
    this.device_model,
    this.error,
  });

  DevicesModel.withError({required String error}) {
    this.error = error;
  }

  DevicesModel copyWith({
    String? device_id,
    String? device_model,
    String? error,
  }) {
    return DevicesModel(
      device_id: device_id ?? this.device_id,
      device_model: device_model ?? this.device_model,
      error: error ?? this.error,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'device_id': device_id,
      'device_model': device_model,
      'error': error,
    };
  }

  factory DevicesModel.fromMap(Map<String, dynamic> map) {
    return DevicesModel(
      device_id: map['device_id'] != null ? map['device_id'] as String : null,
      device_model:
          map['device_model'] != null ? map['device_model'] as String : null,
      error: map['error'] != null ? map['error'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DevicesModel.fromJson(String source) =>
      DevicesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'DevicesModel(device_id: $device_id, device_model: $device_model, error: $error)';

  @override
  bool operator ==(covariant DevicesModel other) {
    if (identical(this, other)) return true;

    return other.device_id == device_id &&
        other.device_model == device_model &&
        other.error == error;
  }

  @override
  int get hashCode =>
      device_id.hashCode ^ device_model.hashCode ^ error.hashCode;
}
