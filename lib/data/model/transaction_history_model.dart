// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TransactionHistory {
  int? tier;
  String? paid_amount;
  String? paid_date;
  String? error;
  TransactionHistory({
    this.tier,
    this.paid_amount,
    this.paid_date,
    this.error,
  });

  TransactionHistory.withError({required String error}) {
    this.error = error;
  }

  TransactionHistory copyWith({
    int? tier,
    String? paid_amount,
    String? paid_date,
    String? error,
  }) {
    return TransactionHistory(
      tier: tier ?? this.tier,
      paid_amount: paid_amount ?? this.paid_amount,
      paid_date: paid_date ?? this.paid_date,
      error: error ?? this.error,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tier': tier,
      'paid_amount': paid_amount,
      'paid_date': paid_date,
      'error': error,
    };
  }

  factory TransactionHistory.fromMap(Map<String, dynamic> map) {
    return TransactionHistory(
      tier: map['tier'] != null ? map['tier'] as int : null,
      paid_amount:
          map['paid_amount'] != null ? map['paid_amount'] as String : null,
      paid_date: map['paid_date'] != null ? map['paid_date'] as String : null,
      error: map['error'] != null ? map['error'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionHistory.fromJson(String source) =>
      TransactionHistory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TransactionHistory(tier: $tier, paid_amount: $paid_amount, paid_date: $paid_date, error: $error)';
  }

  @override
  bool operator ==(covariant TransactionHistory other) {
    if (identical(this, other)) return true;

    return other.tier == tier &&
        other.paid_amount == paid_amount &&
        other.paid_date == paid_date &&
        other.error == error;
  }

  @override
  int get hashCode {
    return tier.hashCode ^
        paid_amount.hashCode ^
        paid_date.hashCode ^
        error.hashCode;
  }
}
