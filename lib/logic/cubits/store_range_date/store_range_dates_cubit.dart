import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'store_range_dates_state.dart';

class StoreRangeDatesCubit extends Cubit<StoreRangeDatesState> {
  StoreRangeDatesCubit() : super(StoreRangeDatesState());
  void addStartDate({required String startDate}) =>
      emit(state.copyWith(startDate: startDate));
  void addEndDate({required String endDate}) =>
      emit(state.copyWith(startDate: state.startDate, endDate: endDate));
  void clearDates() => emit(StoreRangeDatesState());
}
