part of 'form_bloc.dart';

class FormsState extends Equatable {
  final BlocFormItem name;
  final BlocFormItem email;
  final BlocFormItem phone;
  final GlobalKey<FormState>? formKey;
  final BlocFormItem password1;
  final BlocFormItem password2;
  // const FormsState(this.name, this.email, this.phone);
  const FormsState({
    this.email = const BlocFormItem(error: 'Enter Email '),
    this.name = const BlocFormItem(error: 'Enter Name '),
    this.phone = const BlocFormItem(error: 'Enter Phone '),
    this.formKey,
    this.password1 = const BlocFormItem(error: 'Enter Password 1'),
    this.password2 = const BlocFormItem(error: 'Enter Password 2'),
  });

  FormsState copyWith({
    BlocFormItem? name,
    BlocFormItem? email,
    BlocFormItem? phone,
    GlobalKey<FormState>? formKey,
    BlocFormItem? password1,
    BlocFormItem? password2,
  }) {
    return FormsState(
        email: email ?? this.email,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        formKey: formKey ?? this.formKey,
        password1: password1 ?? this.password1,
        password2: password2 ?? this.password2);
  }

  @override
  List<Object> get props =>
      [name, phone, email, formKey!, password1, password2];
}
