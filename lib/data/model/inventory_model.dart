// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class InventoryItemModel {
  int? id;
  String? name;
  String? image;
  int? count;
  int? price;
  String? date_field;
  bool? is_deleted;
  InventoryItemModel({
    this.id,
    this.name,
    this.image,
    this.count,
    this.price,
    this.date_field,
    this.is_deleted,
  });

  InventoryItemModel copyWith({
    int? id,
    String? name,
    String? image,
    int? count,
    int? price,
    String? date_field,
    bool? is_deleted,
  }) {
    return InventoryItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      count: count ?? this.count,
      price: price ?? this.price,
      date_field: date_field ?? this.date_field,
      is_deleted: is_deleted ?? this.is_deleted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'count': count,
      'price': price,
      'date_field': date_field,
      'is_deleted': is_deleted,
    };
  }

  factory InventoryItemModel.fromMap(Map<String, dynamic> map) {
    return InventoryItemModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      count: map['count'] != null ? map['count'] as int : null,
      price: map['price'] != null ? map['price'] as int : null,
      date_field:
          map['date_field'] != null ? map['date_field'] as String : null,
      is_deleted: map['is_deleted'] != null ? map['is_deleted'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory InventoryItemModel.fromJson(String source) =>
      InventoryItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'InventoryItemModel(id: $id, name: $name, image: $image, count: $count, price: $price, date_field: $date_field, is_deleted: $is_deleted)';
  }

  @override
  bool operator ==(covariant InventoryItemModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.image == image &&
        other.count == count &&
        other.price == price &&
        other.date_field == date_field &&
        other.is_deleted == is_deleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        image.hashCode ^
        count.hashCode ^
        price.hashCode ^
        date_field.hashCode ^
        is_deleted.hashCode;
  }
}
