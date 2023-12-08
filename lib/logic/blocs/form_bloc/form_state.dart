part of 'form_bloc.dart';

class FormsState extends Equatable {
  final BlocFormItem name;
  final BlocFormItem email;
  final BlocFormItem phone;
  final GlobalKey<FormState>? formKey;
  final BlocFormItem password1;
  final BlocFormItem password2;
  final BlocFormItem city;
  final BlocFormItem address;
  final BlocFormItem rate;
  final BlocFormItem washRoomCount;
  final BlocFormItem mealsPerDay;
  final BlocFormItem nonVegMealsPerDay;
  final BlocFormItem weeklyLaundaryCycles;

  // const FormsState(this.name, this.email, this.phone);
  const FormsState({
    this.mealsPerDay = const BlocFormItem(error: 'Enter Meals Per Day'),
    this.nonVegMealsPerDay =
        const BlocFormItem(error: 'Enter Non Veg Meals Per Day'),
    this.weeklyLaundaryCycles =
        const BlocFormItem(error: 'Enter Weekly Laundary Cycles'),
    this.email = const BlocFormItem(error: 'Enter Email '),
    this.name = const BlocFormItem(error: 'Enter Name '),
    this.phone = const BlocFormItem(error: 'Enter Phone '),
    this.formKey,
    this.password1 = const BlocFormItem(error: 'Enter Password 1'),
    this.password2 = const BlocFormItem(error: 'Enter Password 2'),
    this.address = const BlocFormItem(error: 'Enter Address'),
    this.city = const BlocFormItem(error: 'Enter City'),
    this.washRoomCount = const BlocFormItem(error: 'Enter WashRoom Count'),
    this.rate = const BlocFormItem(error: 'Enter Rate'),
  });

  FormsState copyWith({
    BlocFormItem? name,
    BlocFormItem? mealsPerDay,
    BlocFormItem? nonVegMealsPerDay,
    BlocFormItem? weeklyLaundaryCycles,
    BlocFormItem? email,
    BlocFormItem? phone,
    GlobalKey<FormState>? formKey,
    BlocFormItem? password1,
    BlocFormItem? password2,
    BlocFormItem? city,
    BlocFormItem? address,
    BlocFormItem? rate,
    BlocFormItem? washRoomCount,
  }) {
    return FormsState(
        mealsPerDay: mealsPerDay ?? this.mealsPerDay,
        nonVegMealsPerDay: nonVegMealsPerDay ?? this.nonVegMealsPerDay,
        weeklyLaundaryCycles: weeklyLaundaryCycles ?? this.weeklyLaundaryCycles,
        rate: rate ?? this.rate,
        washRoomCount: washRoomCount ?? this.washRoomCount,
        email: email ?? this.email,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        formKey: formKey ?? this.formKey,
        password1: password1 ?? this.password1,
        password2: password2 ?? this.password2,
        address: address ?? this.address,
        city: city ?? this.city);
  }

  @override
  List<Object> get props => [
        name,
        phone,
        email,
        formKey!,
        password1,
        password2,
        address,
        city,
        rate,
        washRoomCount,
        weeklyLaundaryCycles,
        nonVegMealsPerDay,
        mealsPerDay
      ];
}
