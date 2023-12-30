// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RoomImage {
  int? id;
  String? images;
  int? room;
  RoomImage({
    this.id,
    this.images,
    this.room,
  });

  RoomImage copyWith({
    int? id,
    String? images,
    int? room,
  }) {
    return RoomImage(
      id: id ?? this.id,
      images: images ?? this.images,
      room: room ?? this.room,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'images': images,
      'room': room,
    };
  }

  factory RoomImage.fromMap(Map<String, dynamic> map) {
    return RoomImage(
      id: map['id'] != null ? map['id'] as int : null,
      images: map['images'] != null ? map['images'] as String : null,
      room: map['room'] != null ? map['room'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomImage.fromJson(String source) =>
      RoomImage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'RoomImage(id: $id, images: $images, room: $room)';

  @override
  bool operator ==(covariant RoomImage other) {
    if (identical(this, other)) return true;

    return other.id == id && other.images == images && other.room == room;
  }

  @override
  int get hashCode => id.hashCode ^ images.hashCode ^ room.hashCode;
}
