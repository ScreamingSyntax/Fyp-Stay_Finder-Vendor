import 'model_exports.dart';

class InventoryLogs {
  InventoryItemModel? item;
  String? date_time;
  String? status;
  int? count;
  InventoryLogs({
    this.item,
    this.date_time,
    this.status,
    this.count,
  });

  InventoryLogs copyWith({
    InventoryItemModel? item,
    String? date_time,
    String? status,
    int? count,
  }) {
    return InventoryLogs(
      item: item ?? this.item,
      date_time: date_time ?? this.date_time,
      status: status ?? this.status,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'item': item?.toMap(),
      'date_time': date_time,
      'status': status,
      'count': count,
    };
  }

  factory InventoryLogs.fromMap(Map<String, dynamic> map) {
    return InventoryLogs(
      item: map['item'] != null
          ? InventoryItemModel.fromMap(map['item'] as Map<String, dynamic>)
          : null,
      date_time: map['date_time'] != null ? map['date_time'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      count: map['count'] != null ? map['count'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory InventoryLogs.fromJson(String source) =>
      InventoryLogs.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'InventoryLogs(item: $item, date_time: $date_time, status: $status, count: $count)';
  }

  @override
  bool operator ==(covariant InventoryLogs other) {
    if (identical(this, other)) return true;

    return other.item == item &&
        other.date_time == date_time &&
        other.status == status &&
        other.count == count;
  }

  @override
  int get hashCode {
    return item.hashCode ^
        date_time.hashCode ^
        status.hashCode ^
        count.hashCode;
  }
}
