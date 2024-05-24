import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_map/flutter_map.dart';

part 'store_singular_date_state.dart';

class StoreSingularDateCubit extends Cubit<StoreSingularDateState> {
  StoreSingularDateCubit() : super(StoreSingularDateState());
  void storeSingularDate({required String date}) =>
      emit(StoreSingularDateState(date: date));
  void clearDate() => emit(StoreSingularDateState());
}
