// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Accommodation {
  String? name;
  String? image;
  String? city;
  String? address;
  String? longitude;
  String? latitude;
  String? type;
  String? monthly_rate;
  int? number_of_washroom;
  bool? gym_availability;
  bool? swimming_pool_availability;
  bool? has_tier;
  String? date_added;
  bool? is_verified;
  bool? is_active;
  bool? is_pending;

  int? meals_per_day;
  int? weekly_non_veg_meals;
  int? weekly_laundry_cycles;
  bool? parking_availability;
  int? admission_rate;
  String? error;
  bool? trash_dispose_availability;
  Accommodation({
    this.name,
    this.image,
    this.city,
    this.address,
    this.longitude,
    this.latitude,
    this.type,
    this.monthly_rate,
    this.number_of_washroom,
    this.gym_availability,
    this.swimming_pool_availability,
    this.has_tier,
    this.date_added,
    this.is_verified,
    this.is_active,
    this.is_pending,
    this.meals_per_day,
    this.weekly_non_veg_meals,
    this.weekly_laundry_cycles,
    this.parking_availability,
    this.admission_rate,
    this.error,
    this.trash_dispose_availability,
  });

  Accommodation copyWith({
    String? name,
    String? image,
    String? city,
    String? address,
    String? longitude,
    String? latitude,
    String? type,
    String? monthly_rate,
    int? number_of_washroom,
    bool? gym_availability,
    bool? swimming_pool_availability,
    bool? has_tier,
    String? date_added,
    bool? is_verified,
    bool? is_active,
    bool? is_pending,
    int? meals_per_day,
    int? weekly_non_veg_meals,
    int? weekly_laundry_cycles,
    bool? parking_availability,
    int? admission_rate,
    String? error,
    bool? trash_dispose_availability,
  }) {
    return Accommodation(
      name: name ?? this.name,
      image: image ?? this.image,
      city: city ?? this.city,
      address: address ?? this.address,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      type: type ?? this.type,
      monthly_rate: monthly_rate ?? this.monthly_rate,
      number_of_washroom: number_of_washroom ?? this.number_of_washroom,
      gym_availability: gym_availability ?? this.gym_availability,
      swimming_pool_availability:
          swimming_pool_availability ?? this.swimming_pool_availability,
      has_tier: has_tier ?? this.has_tier,
      date_added: date_added ?? this.date_added,
      is_verified: is_verified ?? this.is_verified,
      is_active: is_active ?? this.is_active,
      is_pending: is_pending ?? this.is_pending,
      meals_per_day: meals_per_day ?? this.meals_per_day,
      weekly_non_veg_meals: weekly_non_veg_meals ?? this.weekly_non_veg_meals,
      weekly_laundry_cycles:
          weekly_laundry_cycles ?? this.weekly_laundry_cycles,
      parking_availability: parking_availability ?? this.parking_availability,
      admission_rate: admission_rate ?? this.admission_rate,
      error: error ?? this.error,
      trash_dispose_availability:
          trash_dispose_availability ?? this.trash_dispose_availability,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'image': image,
      'city': city,
      'address': address,
      'longitude': longitude,
      'latitude': latitude,
      'type': type,
      'monthly_rate': monthly_rate,
      'number_of_washroom': number_of_washroom,
      'gym_availability': gym_availability,
      'swimming_pool_availability': swimming_pool_availability,
      'has_tier': has_tier,
      'date_added': date_added,
      'is_verified': is_verified,
      'is_active': is_active,
      'is_pending': is_pending,
      'meals_per_day': meals_per_day,
      'weekly_non_veg_meals': weekly_non_veg_meals,
      'weekly_laundry_cycles': weekly_laundry_cycles,
      'parking_availability': parking_availability,
      'admission_rate': admission_rate,
      'error': error,
      'trash_dispose_availability': trash_dispose_availability,
    };
  }

  factory Accommodation.fromMap(Map<String, dynamic> map) {
    return Accommodation(
      name: map['name'] != null ? map['name'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      city: map['city'] != null ? map['city'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      longitude: map['longitude'] != null ? map['longitude'] as String : null,
      latitude: map['latitude'] != null ? map['latitude'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      monthly_rate:
          map['monthly_rate'] != null ? map['monthly_rate'] as String : null,
      number_of_washroom: map['number_of_washroom'] != null
          ? map['number_of_washroom'] as int
          : null,
      gym_availability: map['gym_availability'] != null
          ? map['gym_availability'] as bool
          : null,
      swimming_pool_availability: map['swimming_pool_availability'] != null
          ? map['swimming_pool_availability'] as bool
          : null,
      has_tier: map['has_tier'] != null ? map['has_tier'] as bool : null,
      date_added:
          map['date_added'] != null ? map['date_added'] as String : null,
      is_verified:
          map['is_verified'] != null ? map['is_verified'] as bool : null,
      is_active: map['is_active'] != null ? map['is_active'] as bool : null,
      is_pending: map['is_pending'] != null ? map['is_pending'] as bool : null,
      meals_per_day:
          map['meals_per_day'] != null ? map['meals_per_day'] as int : null,
      weekly_non_veg_meals: map['weekly_non_veg_meals'] != null
          ? map['weekly_non_veg_meals'] as int
          : null,
      weekly_laundry_cycles: map['weekly_laundry_cycles'] != null
          ? map['weekly_laundry_cycles'] as int
          : null,
      parking_availability: map['parking_availability'] != null
          ? map['parking_availability'] as bool
          : null,
      admission_rate:
          map['admission_rate'] != null ? map['admission_rate'] as int : null,
      error: map['error'] != null ? map['error'] as String : null,
      trash_dispose_availability: map['trash_dispose_availability'] != null
          ? map['trash_dispose_availability'] as bool
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Accommodation.fromJson(String source) =>
      Accommodation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Accommodation(name: $name, image: $image, city: $city, address: $address, longitude: $longitude, latitude: $latitude, type: $type, monthly_rate: $monthly_rate, number_of_washroom: $number_of_washroom, gym_availability: $gym_availability, swimming_pool_availability: $swimming_pool_availability, has_tier: $has_tier, date_added: $date_added, is_verified: $is_verified, is_active: $is_active, is_pending: $is_pending, meals_per_day: $meals_per_day, weekly_non_veg_meals: $weekly_non_veg_meals, weekly_laundry_cycles: $weekly_laundry_cycles, parking_availability: $parking_availability, admission_rate: $admission_rate, error: $error, trash_dispose_availability: $trash_dispose_availability)';
  }

  @override
  bool operator ==(covariant Accommodation other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.image == image &&
        other.city == city &&
        other.address == address &&
        other.longitude == longitude &&
        other.latitude == latitude &&
        other.type == type &&
        other.monthly_rate == monthly_rate &&
        other.number_of_washroom == number_of_washroom &&
        other.gym_availability == gym_availability &&
        other.swimming_pool_availability == swimming_pool_availability &&
        other.has_tier == has_tier &&
        other.date_added == date_added &&
        other.is_verified == is_verified &&
        other.is_active == is_active &&
        other.is_pending == is_pending &&
        other.meals_per_day == meals_per_day &&
        other.weekly_non_veg_meals == weekly_non_veg_meals &&
        other.weekly_laundry_cycles == weekly_laundry_cycles &&
        other.parking_availability == parking_availability &&
        other.admission_rate == admission_rate &&
        other.error == error &&
        other.trash_dispose_availability == trash_dispose_availability;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        image.hashCode ^
        city.hashCode ^
        address.hashCode ^
        longitude.hashCode ^
        latitude.hashCode ^
        type.hashCode ^
        monthly_rate.hashCode ^
        number_of_washroom.hashCode ^
        gym_availability.hashCode ^
        swimming_pool_availability.hashCode ^
        has_tier.hashCode ^
        date_added.hashCode ^
        is_verified.hashCode ^
        is_active.hashCode ^
        is_pending.hashCode ^
        meals_per_day.hashCode ^
        weekly_non_veg_meals.hashCode ^
        weekly_laundry_cycles.hashCode ^
        parking_availability.hashCode ^
        admission_rate.hashCode ^
        error.hashCode ^
        trash_dispose_availability.hashCode;
  }
}
