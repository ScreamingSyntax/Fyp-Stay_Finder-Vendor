// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Room {
  int? id;
  int? accommodation;
  int? seater_beds;
  bool? ac_availability;
  bool? water_bottle_availability;
  bool? steam_iron_availability;
  double? per_day_rent;
  bool? fan_availability;
  bool? bed_availability;
  bool? sofa_availability;
  int? monthly_rate;
  bool? mat_availability;
  bool? carpet_availability;
  String? washroom_status;
  bool? dustbin_availability;
  bool? kettle_availability;
  bool? coffee_powder_availability;
  bool? milk_powder_availability;
  bool? tea_powder_availability;
  bool? hair_dryer_availability;
  bool? tv_availability;
  String? error;
  Room({
    this.id,
    this.accommodation,
    this.seater_beds,
    this.ac_availability,
    this.water_bottle_availability,
    this.steam_iron_availability,
    this.per_day_rent,
    this.fan_availability,
    this.bed_availability,
    this.sofa_availability,
    this.monthly_rate,
    this.mat_availability,
    this.carpet_availability,
    this.washroom_status,
    this.dustbin_availability,
    this.kettle_availability,
    this.coffee_powder_availability,
    this.milk_powder_availability,
    this.tea_powder_availability,
    this.hair_dryer_availability,
    this.tv_availability,
    this.error,
  });

  Room copyWith({
    int? id,
    int? accommodation,
    int? seater_beds,
    bool? ac_availability,
    bool? water_bottle_availability,
    bool? steam_iron_availability,
    double? per_day_rent,
    bool? fan_availability,
    bool? bed_availability,
    bool? sofa_availability,
    int? monthly_rate,
    bool? mat_availability,
    bool? carpet_availability,
    String? washroom_status,
    bool? dustbin_availability,
    bool? kettle_availability,
    bool? coffee_powder_availability,
    bool? milk_powder_availability,
    bool? tea_powder_availability,
    bool? hair_dryer_availability,
    bool? tv_availability,
    String? error,
  }) {
    return Room(
      id: id ?? this.id,
      accommodation: accommodation ?? this.accommodation,
      seater_beds: seater_beds ?? this.seater_beds,
      ac_availability: ac_availability ?? this.ac_availability,
      water_bottle_availability:
          water_bottle_availability ?? this.water_bottle_availability,
      steam_iron_availability:
          steam_iron_availability ?? this.steam_iron_availability,
      per_day_rent: per_day_rent ?? this.per_day_rent,
      fan_availability: fan_availability ?? this.fan_availability,
      bed_availability: bed_availability ?? this.bed_availability,
      sofa_availability: sofa_availability ?? this.sofa_availability,
      monthly_rate: monthly_rate ?? this.monthly_rate,
      mat_availability: mat_availability ?? this.mat_availability,
      carpet_availability: carpet_availability ?? this.carpet_availability,
      washroom_status: washroom_status ?? this.washroom_status,
      dustbin_availability: dustbin_availability ?? this.dustbin_availability,
      kettle_availability: kettle_availability ?? this.kettle_availability,
      coffee_powder_availability:
          coffee_powder_availability ?? this.coffee_powder_availability,
      milk_powder_availability:
          milk_powder_availability ?? this.milk_powder_availability,
      tea_powder_availability:
          tea_powder_availability ?? this.tea_powder_availability,
      hair_dryer_availability:
          hair_dryer_availability ?? this.hair_dryer_availability,
      tv_availability: tv_availability ?? this.tv_availability,
      error: error ?? this.error,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'accommodation': accommodation,
      'seater_beds': seater_beds,
      'ac_availability': ac_availability,
      'water_bottle_availability': water_bottle_availability,
      'steam_iron_availability': steam_iron_availability,
      'per_day_rent': per_day_rent,
      'fan_availability': fan_availability,
      'bed_availability': bed_availability,
      'sofa_availability': sofa_availability,
      'monthly_rate': monthly_rate,
      'mat_availability': mat_availability,
      'carpet_availability': carpet_availability,
      'washroom_status': washroom_status,
      'dustbin_availability': dustbin_availability,
      'kettle_availability': kettle_availability,
      'coffee_powder_availability': coffee_powder_availability,
      'milk_powder_availability': milk_powder_availability,
      'tea_powder_availability': tea_powder_availability,
      'hair_dryer_availability': hair_dryer_availability,
      'tv_availability': tv_availability,
      'error': error,
    };
  }

  factory Room.fromMap(Map<String, dynamic> map) {
    return Room(
      id: map['id'] != null ? map['id'] as int : null,
      accommodation:
          map['accommodation'] != null ? map['accommodation'] as int : null,
      seater_beds:
          map['seater_beds'] != null ? map['seater_beds'] as int : null,
      ac_availability: map['ac_availability'] != null
          ? map['ac_availability'] as bool
          : null,
      water_bottle_availability: map['water_bottle_availability'] != null
          ? map['water_bottle_availability'] as bool
          : null,
      steam_iron_availability: map['steam_iron_availability'] != null
          ? map['steam_iron_availability'] as bool
          : null,
      per_day_rent:
          map['per_day_rent'] != null ? map['per_day_rent'] as double : null,
      fan_availability: map['fan_availability'] != null
          ? map['fan_availability'] as bool
          : null,
      bed_availability: map['bed_availability'] != null
          ? map['bed_availability'] as bool
          : null,
      sofa_availability: map['sofa_availability'] != null
          ? map['sofa_availability'] as bool
          : null,
      monthly_rate:
          map['monthly_rate'] != null ? map['monthly_rate'] as int : null,
      mat_availability: map['mat_availability'] != null
          ? map['mat_availability'] as bool
          : null,
      carpet_availability: map['carpet_availability'] != null
          ? map['carpet_availability'] as bool
          : null,
      washroom_status: map['washroom_status'] != null
          ? map['washroom_status'] as String
          : null,
      dustbin_availability: map['dustbin_availability'] != null
          ? map['dustbin_availability'] as bool
          : null,
      kettle_availability: map['kettle_availability'] != null
          ? map['kettle_availability'] as bool
          : null,
      coffee_powder_availability: map['coffee_powder_availability'] != null
          ? map['coffee_powder_availability'] as bool
          : null,
      milk_powder_availability: map['milk_powder_availability'] != null
          ? map['milk_powder_availability'] as bool
          : null,
      tea_powder_availability: map['tea_powder_availability'] != null
          ? map['tea_powder_availability'] as bool
          : null,
      hair_dryer_availability: map['hair_dryer_availability'] != null
          ? map['hair_dryer_availability'] as bool
          : null,
      tv_availability: map['tv_availability'] != null
          ? map['tv_availability'] as bool
          : null,
      error: map['error'] != null ? map['error'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Room.fromJson(String source) =>
      Room.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Room(id: $id, accommodation: $accommodation, seater_beds: $seater_beds, ac_availability: $ac_availability, water_bottle_availability: $water_bottle_availability, steam_iron_availability: $steam_iron_availability, per_day_rent: $per_day_rent, fan_availability: $fan_availability, bed_availability: $bed_availability, sofa_availability: $sofa_availability, monthly_rate: $monthly_rate, mat_availability: $mat_availability, carpet_availability: $carpet_availability, washroom_status: $washroom_status, dustbin_availability: $dustbin_availability, kettle_availability: $kettle_availability, coffee_powder_availability: $coffee_powder_availability, milk_powder_availability: $milk_powder_availability, tea_powder_availability: $tea_powder_availability, hair_dryer_availability: $hair_dryer_availability, tv_availability: $tv_availability, error: $error)';
  }

  @override
  bool operator ==(covariant Room other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.accommodation == accommodation &&
        other.seater_beds == seater_beds &&
        other.ac_availability == ac_availability &&
        other.water_bottle_availability == water_bottle_availability &&
        other.steam_iron_availability == steam_iron_availability &&
        other.per_day_rent == per_day_rent &&
        other.fan_availability == fan_availability &&
        other.bed_availability == bed_availability &&
        other.sofa_availability == sofa_availability &&
        other.monthly_rate == monthly_rate &&
        other.mat_availability == mat_availability &&
        other.carpet_availability == carpet_availability &&
        other.washroom_status == washroom_status &&
        other.dustbin_availability == dustbin_availability &&
        other.kettle_availability == kettle_availability &&
        other.coffee_powder_availability == coffee_powder_availability &&
        other.milk_powder_availability == milk_powder_availability &&
        other.tea_powder_availability == tea_powder_availability &&
        other.hair_dryer_availability == hair_dryer_availability &&
        other.tv_availability == tv_availability &&
        other.error == error;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        accommodation.hashCode ^
        seater_beds.hashCode ^
        ac_availability.hashCode ^
        water_bottle_availability.hashCode ^
        steam_iron_availability.hashCode ^
        per_day_rent.hashCode ^
        fan_availability.hashCode ^
        bed_availability.hashCode ^
        sofa_availability.hashCode ^
        monthly_rate.hashCode ^
        mat_availability.hashCode ^
        carpet_availability.hashCode ^
        washroom_status.hashCode ^
        dustbin_availability.hashCode ^
        kettle_availability.hashCode ^
        coffee_powder_availability.hashCode ^
        milk_powder_availability.hashCode ^
        tea_powder_availability.hashCode ^
        hair_dryer_availability.hashCode ^
        tv_availability.hashCode ^
        error.hashCode;
  }
}
