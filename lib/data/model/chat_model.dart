// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:stayfinder_vendor/data/model/model_exports.dart';

class ChatModel {
  int? id;
  Vendor? sender;
  Vendor? receiver;
  String? image;
  bool? is_read;
  String? message;
  String? date;
  ChatModel({
    this.id,
    this.sender,
    this.receiver,
    this.image,
    this.is_read,
    this.message,
    this.date,
  });

  ChatModel copyWith({
    int? id,
    Vendor? sender,
    Vendor? receiver,
    String? image,
    bool? is_read,
    String? message,
    String? date,
  }) {
    return ChatModel(
      id: id ?? this.id,
      sender: sender ?? this.sender,
      receiver: receiver ?? this.receiver,
      image: image ?? this.image,
      is_read: is_read ?? this.is_read,
      message: message ?? this.message,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'sender': sender?.toMap(),
      'receiver': receiver?.toMap(),
      'image': image,
      'is_read': is_read,
      'message': message,
      'date': date,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['id'] != null ? map['id'] as int : null,
      sender: map['sender'] != null
          ? Vendor.fromMap(map['sender'] as Map<String, dynamic>)
          : null,
      receiver: map['receiver'] != null
          ? Vendor.fromMap(map['receiver'] as Map<String, dynamic>)
          : null,
      image: map['image'] != null ? map['image'] as String : null,
      is_read: map['is_read'] != null ? map['is_read'] as bool : null,
      message: map['message'] != null ? map['message'] as String : null,
      date: map['date'] != null ? map['date'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatModel(id: $id, sender: $sender, receiver: $receiver, image: $image, is_read: $is_read, message: $message, date: $date)';
  }

  @override
  bool operator ==(covariant ChatModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.sender == sender &&
        other.receiver == receiver &&
        other.image == image &&
        other.is_read == is_read &&
        other.message == message &&
        other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        sender.hashCode ^
        receiver.hashCode ^
        image.hashCode ^
        is_read.hashCode ^
        message.hashCode ^
        date.hashCode;
  }
}
