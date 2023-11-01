// ignore_for_file: must_be_immutable

part of 'radiolisttile_cubit.dart';

class RadioListTileState {
  List<Tier>? groupValue;
  Tier? currentValue;
  RadioListTileState({this.groupValue, this.currentValue}) {
    this.groupValue = groupValue ?? this.groupValue;
    this.currentValue = currentValue ?? this.currentValue;
  }

  RadioListTileState copyWith(
      {List<Tier>? newGroupValue, Tier? newCurrentValue}) {
    return RadioListTileState(
      groupValue: newGroupValue ?? this.groupValue,
      currentValue: newCurrentValue ?? this.currentValue,
    );
  }

  @override
  List<Object> get props {
    if (this.groupValue != null && this.currentValue != null) {
      return [groupValue!, currentValue!];
    }
    return [];
  }
}
