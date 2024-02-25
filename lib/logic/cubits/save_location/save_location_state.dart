// ignore_for_file: must_be_immutable

part of 'save_location_cubit.dart';

class SaveLocationState extends Equatable {
  String? longitude;
  String? latitude;
  SaveLocationState({this.latitude, this.longitude});

  @override
  List<Object> get props {
    if (this.latitude != null) {
      return [this.longitude!, this.latitude!];
    }
    return [];
  }
}
