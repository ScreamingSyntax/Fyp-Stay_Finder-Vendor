import 'package:stayfinder_vendor/data/model/model_exports.dart';

class BookingRequest {
  int? id;
  RoomAccommodation? room;
  Vendor? user;
  String? status;
  String? requested_on;
  BookingRequest({
    this.id,
    this.room,
    this.user,
    this.status,
    this.requested_on,
  });

  BookingRequest copyWith({
    int? id,
    RoomAccommodation? room,
    Vendor? user,
    String? status,
    String? requested_on,
  }) {
    return BookingRequest(
      id: id ?? this.id,
      room: room ?? this.room,
      user: user ?? this.user,
      status: status ?? this.status,
      requested_on: requested_on ?? this.requested_on,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'room': room?.toMap(),
      'user': user?.toMap(),
      'status': status,
      'requested_on': requested_on,
    };
  }

  factory BookingRequest.fromMap(Map<String, dynamic> map) {
    return BookingRequest(
      id: map['id'] != null ? map['id'] as int : null,
      room: map['room'] != null
          ? RoomAccommodation.fromMap(map['room'] as Map<String, dynamic>)
          : null,
      user: map['user'] != null
          ? Vendor.fromMap(map['user'] as Map<String, dynamic>)
          : null,
      status: map['status'] != null ? map['status'] as String : null,
      requested_on:
          map['requested_on'] != null ? map['requested_on'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookingRequest.fromJson(String source) =>
      BookingRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Booking(id: $id, room: $room, user: $user, status: $status, requested_on: $requested_on)';
  }

  @override
  bool operator ==(covariant BookingRequest other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.room == room &&
        other.user == user &&
        other.status == status &&
        other.requested_on == requested_on;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        room.hashCode ^
        user.hashCode ^
        status.hashCode ^
        requested_on.hashCode;
  }
}
