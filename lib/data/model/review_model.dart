// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:stayfinder_vendor/data/model/model_exports.dart';

class ReviewModel {
  int? id;
  String? title;
  String? description;
  String? image;
  Accommodation? accommodation;
  Vendor? customer;
  bool? is_deleted;
  String? added_time;
  String? error;
  ReviewModel.withError(String error) {
    this.error = error;
  }

  ReviewModel({
    this.id,
    this.title,
    this.description,
    this.image,
    this.accommodation,
    this.customer,
    this.is_deleted,
    this.added_time,
    this.error,
  });

  ReviewModel copyWith({
    int? id,
    String? title,
    String? description,
    String? image,
    Accommodation? accommodation,
    Vendor? customer,
    bool? is_deleted,
    String? added_time,
    String? error,
  }) {
    return ReviewModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      image: image ?? this.image,
      accommodation: accommodation ?? this.accommodation,
      customer: customer ?? this.customer,
      is_deleted: is_deleted ?? this.is_deleted,
      added_time: added_time ?? this.added_time,
      error: error ?? this.error,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'accommodation': accommodation?.toMap(),
      'customer': customer?.toMap(),
      'is_deleted': is_deleted,
      'added_time': added_time,
      'error': error,
    };
  }

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      accommodation: map['accommodation'] != null
          ? Accommodation.fromMap(map['accommodation'] as Map<String, dynamic>)
          : null,
      customer: map['customer'] != null
          ? Vendor.fromMap(map['customer'] as Map<String, dynamic>)
          : null,
      is_deleted: map['is_deleted'] != null ? map['is_deleted'] as bool : null,
      added_time:
          map['added_time'] != null ? map['added_time'] as String : null,
      error: map['error'] != null ? map['error'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReviewModel.fromJson(String source) =>
      ReviewModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ReviewModel(id: $id, title: $title, description: $description, image: $image, accommodation: $accommodation, customer: $customer, is_deleted: $is_deleted, added_time: $added_time, error: $error)';
  }

  @override
  bool operator ==(covariant ReviewModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.image == image &&
        other.accommodation == accommodation &&
        other.customer == customer &&
        other.is_deleted == is_deleted &&
        other.added_time == added_time &&
        other.error == error;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        image.hashCode ^
        accommodation.hashCode ^
        customer.hashCode ^
        is_deleted.hashCode ^
        added_time.hashCode ^
        error.hashCode;
  }
}
