// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:stayfinder_vendor/data/model/model_exports.dart';

class CurrentTier {
  final int id;
  final Tier tier_id;
  final bool paid;
  final int added_accomodations;

  CurrentTier(
      {required this.id,
      required this.tier_id,
      required this.paid,
      required this.added_accomodations});

  CurrentTier copyWith({
    int? id,
    Tier? tier_id,
    bool? paid,
    int? added_accomodations,
  }) {
    return CurrentTier(
      id: id ?? this.id,
      tier_id: tier_id ?? this.tier_id,
      paid: paid ?? this.paid,
      added_accomodations: added_accomodations ?? this.added_accomodations,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'tier_id': tier_id.toMap(),
      'paid': paid,
      'added_accomodations': added_accomodations,
    };
  }

  factory CurrentTier.fromMap(Map<String, dynamic> map) {
    return CurrentTier(
      id: map['id'] as int,
      tier_id: Tier.fromMap(map['tier_id'] as Map<String, dynamic>),
      paid: map['paid'] as bool,
      added_accomodations: map['added_accomodations'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CurrentTier.fromJson(String source) =>
      CurrentTier.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CurrentTier(id: $id, tier_id: $tier_id, paid: $paid, added_accomodations: $added_accomodations)';
  }

  @override
  bool operator ==(covariant CurrentTier other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.tier_id == tier_id &&
        other.paid == paid &&
        other.added_accomodations == added_accomodations;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        tier_id.hashCode ^
        paid.hashCode ^
        added_accomodations.hashCode;
  }
}
