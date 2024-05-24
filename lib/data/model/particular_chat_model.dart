import 'dart:convert';

class ParticualrChatModel {
  int? sender;
  int? reciever;
  String? message;
  String? image;
  ParticualrChatModel({
    this.sender,
    this.reciever,
    this.message,
    this.image,
  });

  ParticualrChatModel copyWith({
    int? sender,
    int? reciever,
    String? message,
    String? image,
  }) {
    return ParticualrChatModel(
      sender: sender ?? this.sender,
      reciever: reciever ?? this.reciever,
      message: message ?? this.message,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sender': sender,
      'reciever': reciever,
      'message': message,
      'image': image,
    };
  }

  factory ParticualrChatModel.fromMap(Map<String, dynamic> map) {
    return ParticualrChatModel(
      sender: map['sender'] != null ? map['sender'] as int : null,
      reciever: map['reciever'] != null ? map['reciever'] as int : null,
      message: map['message'] != null ? map['message'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ParticualrChatModel.fromJson(String source) =>
      ParticualrChatModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ParticualrChatModel(sender: $sender, reciever: $reciever, message: $message, image: $image)';
  }

  @override
  bool operator ==(covariant ParticualrChatModel other) {
    if (identical(this, other)) return true;

    return other.sender == sender &&
        other.reciever == reciever &&
        other.message == message &&
        other.image == image;
  }

  @override
  int get hashCode {
    return sender.hashCode ^
        reciever.hashCode ^
        message.hashCode ^
        image.hashCode;
  }
}
