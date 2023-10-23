import 'package:flutter/material.dart';

import '../../../constants/constants_exports.dart';
import '../bloc_exports.dart';
import '../../../data/model/model_exports.dart';
part 'form_event.dart';
part 'form_state.dart';

class FormBloc extends Bloc<FormEvent, FormsState> {
  late GlobalKey<FormState> _formKey;
  FormBloc() : super(FormsState(formKey: GlobalKey<FormState>())) {
    _formKey = state.formKey!;
    on<InitEvent>(initFormState);
    on<NameChangedEvent>(onNameChanged);
    on<EmailChangedEvent>(onEmailChanged);
    on<PhoneChangedEvent>(onPhoneChanged);
    on<Password1ChangedEvent>(onPassword1Changed);
    on<Password2ChangedEvent>(onPassword2Changed);
  }

  Future<void> initFormState(InitEvent event, Emitter<FormsState> emit) async {
    emit(state.copyWith(formKey: _formKey));
    // emit(FormsState(formKey: _formKey))
  }

  Future<void> onNameChanged(
      NameChangedEvent event, Emitter<FormsState> emit) async {
    emit(state.copyWith(
        formKey: _formKey,
        name: BlocFormItem(
            value: event.name.value,
            error: event.name.value.isValidName ? null : 'Enter Name')));
  }

  Future<void> onPhoneChanged(
      PhoneChangedEvent event, Emitter<FormsState> emit) async {
    emit(state.copyWith(
        formKey: _formKey,
        phone: BlocFormItem(
            value: event.mobile.value,
            error: event.mobile.value.isValidPhone ? null : 'Enter Mobile')));
  }

  Future<void> onEmailChanged(
      EmailChangedEvent event, Emitter<FormsState> emit) async {
    emit(state.copyWith(
        formKey: _formKey,
        email: BlocFormItem(
            value: event.email.value,
            error: event.email.value.isValidEmail ? null : 'Enter Email')));
  }

  Future<void> onPassword1Changed(
      Password1ChangedEvent event, Emitter<FormsState> emit) async {
    emit(state.copyWith(
      formKey: _formKey,
      password1: BlocFormItem(
          value: event.password.value,
          error: event.password.value.isValidEmail ? null : 'Enter Password'),
    ));
  }

  Future<void> onPassword2Changed(
      Password2ChangedEvent event, Emitter<FormsState> emit) async {
    emit(state.copyWith(
      formKey: _formKey,
      password2: BlocFormItem(
          value: event.password2.value,
          error: event.password2.value.isValidEmail ? null : 'Enter Password'),
    ));
  }
}
