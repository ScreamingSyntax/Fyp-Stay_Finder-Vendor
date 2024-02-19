import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'store_temp_user_details_state.dart';

class StoreTempUserDetailsCubit extends Cubit<StoreTempUserDetailsState> {
  StoreTempUserDetailsCubit() : super(StoreTempUserDetailsState());
  void storeTempData(
      {required File image,
      required String name,
      required String email,
      required String password}) {
    return emit(StoreTempUserDetailsState(
        email: email, image: image, name: name, password: password));
  }

  void clearData() => emit(StoreTempUserDetailsState(
      email: null, image: null, name: null, password: null));
  @override
  void onChange(Change<StoreTempUserDetailsState> change) {
    print("Current state ${change.currentState} NextState ${change.nextState}");
    // TODO: implement onChange
    super.onChange(change);
  }
}
