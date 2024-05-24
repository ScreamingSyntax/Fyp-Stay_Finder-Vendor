// ignore_for_file: must_be_immutable

part of 'store_range_dates_cubit.dart';

class StoreRangeDatesState extends Equatable {
  String? startDate;
  String? endDate;
  StoreRangeDatesState({this.startDate, this.endDate});
  StoreRangeDatesState copyWith({String? startDate, String? endDate}) {
    return StoreRangeDatesState(
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate);
  }

  @override
  List<Object> get props {
    List<String?> items = [this.startDate, this.endDate];
    List<Object> toReturn = [];
    items.forEach((element) {
      if (element != null) {
        toReturn.add(element);
      }
    });
    return toReturn;
  }
}
