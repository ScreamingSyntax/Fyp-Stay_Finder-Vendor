import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stayfinder_vendor/data/model/model_exports.dart';

part 'store_filter_state.dart';

class StoreFilterCubit extends Cubit<StoreFilterState> {
  StoreFilterCubit() : super(StoreFilterState());

  void initializeAccommodationList(
          {required List<Accommodation> accommodations}) async =>
      emit(StoreFilterState(accommodationList: accommodations));
  void storeAccommodation({required Accommodation accommodation}) async {
    emit(state.copyWith(accommodation: accommodation));
  }

  void storeFilters(
      {required String? type,
      String? startDate,
      String? endDate,
      String? date}) async {
    emit(state.copyWith(
        startDate: startDate, endDate: endDate, date: date, type: type));
  }

  @override
  void onChange(Change<StoreFilterState> change) {
    print("CC :${change.currentState} NN: ${change.nextState}");
    super.onChange(change);
  }
}
