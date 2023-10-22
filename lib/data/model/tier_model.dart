import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class Tier {
  int? id;
  String? name;
  String? description;
  String? image;
  String? price;
  int? accomodationLimit;
  String? error;
  Tier(
      {required this.id,
      required this.name,
      required this.description,
      required this.image,
      required this.price,
      required this.accomodationLimit,
      this.error});
  Tier.withError({required String error}) {
    this.error = error;
  }
  Tier copyWith({
    int? id,
    String? name,
    String? description,
    String? image,
    String? price,
    int? accomodationLimit,
    String? error,
  }) {
    return Tier(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      price: price ?? this.price,
      accomodationLimit: accomodationLimit ?? this.accomodationLimit,
      error: error ?? this.error,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'price': price,
      'accomodationLimit': accomodationLimit,
      'error': error,
    };
  }

  factory Tier.fromMap(Map<String, dynamic> map) {
    return Tier(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      price: map['price'] != null ? map['price'] as String : null,
      accomodationLimit: map['accomodationLimit'] != null
          ? map['accomodationLimit'] as int
          : null,
      error: map['error'] != null ? map['error'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Tier.fromJson(String source) =>
      Tier.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Tier(id: $id, name: $name, description: $description, image: $image, price: $price, accomodationLimit: $accomodationLimit, error: $error)';
  }

  @override
  bool operator ==(covariant Tier other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        other.image == image &&
        other.price == price &&
        other.accomodationLimit == accomodationLimit &&
        other.error == error;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        image.hashCode ^
        price.hashCode ^
        accomodationLimit.hashCode ^
        error.hashCode;
  }
}
