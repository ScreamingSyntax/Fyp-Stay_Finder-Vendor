part of 'form_bloc.dart';

sealed class FormEvent extends Equatable {
  const FormEvent();

  @override
  List<Object> get props => [];
}

class InitEvent extends FormEvent {
  const InitEvent();
}

class NameChangedEvent extends FormEvent {
  final BlocFormItem name;
  const NameChangedEvent({required this.name});
  List<Object> get props => [name];
}

class EmailChangedEvent extends FormEvent {
  final BlocFormItem email;
  const EmailChangedEvent({required this.email});
  List<Object> get props => [email];
}

class PhoneChangedEvent extends FormEvent {
  final BlocFormItem mobile;
  const PhoneChangedEvent({required this.mobile});
  List<Object> get props => [mobile];
}

class FormSubmitEvent extends FormEvent {
  const FormSubmitEvent();
}

class Password1ChangedEvent extends FormEvent {
  final BlocFormItem password;

  Password1ChangedEvent({required this.password});
}

class Password2ChangedEvent extends FormEvent {
  final BlocFormItem password2;

  Password2ChangedEvent({required this.password2});
}

class CityChangedEvent extends FormEvent {
  final BlocFormItem city;

  CityChangedEvent({required this.city});
}

class AddressChangedEvent extends FormEvent {
  final BlocFormItem address;

  AddressChangedEvent({required this.address});
}

class RateChangedEvent extends FormEvent {
  final BlocFormItem rate;

  RateChangedEvent({required this.rate});
}

class WashRoomCountChangedEvent extends FormEvent {
  final BlocFormItem washRoomCount;

  WashRoomCountChangedEvent({required this.washRoomCount});
}

class MealsPerDayChangedEvent extends FormEvent {
  final BlocFormItem mealsPerDay;

  MealsPerDayChangedEvent({required this.mealsPerDay});
}

class NonMealsPerDayChangedEvent extends FormEvent {
  final BlocFormItem nonVegMealsPerDay;

  NonMealsPerDayChangedEvent({required this.nonVegMealsPerDay});
}

class WeeklyLaundaryCyclesChangedEvent extends FormEvent {
  final BlocFormItem weeklyLaundaryCycles;

  WeeklyLaundaryCyclesChangedEvent({required this.weeklyLaundaryCycles});
}

class BedChangedEvent extends FormEvent {
  final BlocFormItem bedChanged;

  BedChangedEvent({required this.bedChanged});
}
