// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Tier {
  final int id;
  final String name;
  final String description;
  final String image;
  final String price;
  final bool isCurrent;
  final int accomodationLimit;
  Tier({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.isCurrent,
    required this.accomodationLimit,
  });

  Tier copyWith({
    int? id,
    String? name,
    String? description,
    String? image,
    String? price,
    bool? isCurrent,
    int? accomodationLimit,
  }) {
    return Tier(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      price: price ?? this.price,
      isCurrent: isCurrent ?? this.isCurrent,
      accomodationLimit: accomodationLimit ?? this.accomodationLimit,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'price': price,
      'isCurrent': isCurrent,
      'accomodationLimit': accomodationLimit,
    };
  }

  factory Tier.fromMap(Map<String, dynamic> map) {
    return Tier(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      image: map['image'] as String,
      price: map['price'] as String,
      isCurrent: map['isCurrent'] as bool,
      accomodationLimit: map['accomodationLimit'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Tier.fromJson(String source) =>
      Tier.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Tier(id: $id, name: $name, description: $description, image: $image, price: $price, isCurrent: $isCurrent, accomodationLimit: $accomodationLimit)';
  }

  @override
  bool operator ==(covariant Tier other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        other.image == image &&
        other.price == price &&
        other.isCurrent == isCurrent &&
        other.accomodationLimit == accomodationLimit;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        image.hashCode ^
        price.hashCode ^
        isCurrent.hashCode ^
        accomodationLimit.hashCode;
  }
}
