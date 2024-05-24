// ignore_for_file: must_be_immutable

part of 'store_filter_cubit.dart';

class StoreFilterState extends Equatable {
  List<Accommodation>? accommodationList;
  Accommodation? accommodation;
  String? startDate;
  String? endDate;
  String? date;
  String? type;
  StoreFilterState(
      {this.accommodationList,
      this.accommodation,
      this.startDate,
      this.endDate,
      this.date,
      this.type});
  StoreFilterState copyWith({
    Accommodation? accommodation,
    List<Accommodation>? accommodationList,
    String? startDate,
    String? endDate,
    String? date,
    String? type,
  }) {
    return StoreFilterState(
        accommodationList: accommodationList ?? this.accommodationList,
        accommodation: accommodation ?? this.accommodation,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        date: date ?? this.date,
        type: type ?? type);
  }

  @override
  List<Object> get props {
    var items = [
      this.accommodationList,
      this.accommodation,
      this.startDate,
      this.endDate,
      this.date,
      this.type
    ];

    List<Object> toReturn = [];
    items.forEach((element) {
      if (element != null) {
        toReturn.add(element);
      }
    });
    return toReturn;
  }
}
