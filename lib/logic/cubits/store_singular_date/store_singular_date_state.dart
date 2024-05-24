// ignore_for_file: must_be_immutable

part of 'store_singular_date_cubit.dart';

class StoreSingularDateState extends Equatable {
  String? date;
  StoreSingularDateState({this.date});

  @override
  List<Object> get props {
    if (this.date != null) {
      return [this.date!];
    }
    return [];
  }
}
