// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:stayfinder_vendor/data/model/model_exports.dart';

class CurrentTier {
  int? tier;
  String? paid_amount;
  String? paid_date;
  String? paid_till;
  bool? is_active;
  String? error;
  CurrentTier(
      {this.tier,
      this.paid_amount,
      this.paid_date,
      this.paid_till,
      this.is_active,
      this.error});
  CurrentTier.withError({required String error}) {
    this.error = error;
  }
  CurrentTier copyWith({
    int? tier,
    String? paid_amount,
    String? paid_date,
    String? paid_till,
    bool? is_active,
    String? error,
  }) {
    return CurrentTier(
      tier: tier ?? this.tier,
      paid_amount: paid_amount ?? this.paid_amount,
      paid_date: paid_date ?? this.paid_date,
      paid_till: paid_till ?? this.paid_till,
      is_active: is_active ?? this.is_active,
      error: error ?? this.error,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tier': tier,
      'paid_amount': paid_amount,
      'paid_date': paid_date,
      'paid_till': paid_till,
      'is_active': is_active,
      'error': error,
    };
  }

  factory CurrentTier.fromMap(Map<String, dynamic> map) {
    return CurrentTier(
      tier: map['tier'] != null ? map['tier'] as int : null,
      paid_amount:
          map['paid_amount'] != null ? map['paid_amount'] as String : null,
      paid_date: map['paid_date'] != null ? map['paid_date'] as String : null,
      paid_till: map['paid_till'] != null ? map['paid_till'] as String : null,
      is_active: map['is_active'] != null ? map['is_active'] as bool : null,
      error: map['error'] != null ? map['error'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CurrentTier.fromJson(String source) =>
      CurrentTier.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CurrentTier(tier: $tier, paid_amount: $paid_amount, paid_date: $paid_date, paid_till: $paid_till, is_active: $is_active, error: $error)';
  }

  @override
  bool operator ==(covariant CurrentTier other) {
    if (identical(this, other)) return true;

    return other.tier == tier &&
        other.paid_amount == paid_amount &&
        other.paid_date == paid_date &&
        other.paid_till == paid_till &&
        other.is_active == is_active &&
        other.error == error;
  }

  @override
  int get hashCode {
    return tier.hashCode ^
        paid_amount.hashCode ^
        paid_date.hashCode ^
        paid_till.hashCode ^
        is_active.hashCode ^
        error.hashCode;
  }
}
