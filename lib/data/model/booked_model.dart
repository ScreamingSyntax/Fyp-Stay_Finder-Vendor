import 'package:stayfinder_vendor/data/model/model_exports.dart';

class Booked {
  int? id;
  RoomAccommodation? room;
  Vendor? user;
  String? check_in;
  String? check_out;
  String? booked_on;
  String? paid_amount;
  Booked({
    this.id,
    this.room,
    this.user,
    this.check_in,
    this.check_out,
    this.booked_on,
    this.paid_amount,
  });

  Booked copyWith({
    int? id,
    RoomAccommodation? room,
    Vendor? user,
    String? check_in,
    String? check_out,
    String? booked_on,
    String? paid_amount,
  }) {
    return Booked(
      id: id ?? this.id,
      room: room ?? this.room,
      user: user ?? this.user,
      check_in: check_in ?? this.check_in,
      check_out: check_out ?? this.check_out,
      booked_on: booked_on ?? this.booked_on,
      paid_amount: paid_amount ?? this.paid_amount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'room': room?.toMap(),
      'user': user?.toMap(),
      'check_in': check_in,
      'check_out': check_out,
      'booked_on': booked_on,
      'paid_amount': paid_amount,
    };
  }

  factory Booked.fromMap(Map<String, dynamic> map) {
    return Booked(
      id: map['id'] != null ? map['id'] as int : null,
      room: map['room'] != null
          ? RoomAccommodation.fromMap(map['room'] as Map<String, dynamic>)
          : null,
      user: map['user'] != null
          ? Vendor.fromMap(map['user'] as Map<String, dynamic>)
          : null,
      check_in: map['check_in'] != null ? map['check_in'] as String : null,
      check_out: map['check_out'] != null ? map['check_out'] as String : null,
      booked_on: map['booked_on'] != null ? map['booked_on'] as String : null,
      paid_amount:
          map['paid_amount'] != null ? map['paid_amount'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Booked.fromJson(String source) =>
      Booked.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Booked(id: $id, room: $room, user: $user, check_in: $check_in, check_out: $check_out, booked_on: $booked_on, paid_amount: $paid_amount)';
  }

  @override
  bool operator ==(covariant Booked other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.room == room &&
        other.user == user &&
        other.check_in == check_in &&
        other.check_out == check_out &&
        other.booked_on == booked_on &&
        other.paid_amount == paid_amount;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        room.hashCode ^
        user.hashCode ^
        check_in.hashCode ^
        check_out.hashCode ^
        booked_on.hashCode ^
        paid_amount.hashCode;
  }
}
