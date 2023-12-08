import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stayfinder_vendor/data/model/model_exports.dart';

import '../../../data/repository/repository_exports.dart';

part 'fetch_added_accommodations_event.dart';
part 'fetch_added_accommodations_state.dart';

class FetchAddedAccommodationsBloc
    extends Bloc<FetchAddedAccommodationsEvent, FetchAddedAccommodationsState> {
  FetchAddedAccommodationsBloc({required AccommodationAdditionRepository repo})
      : super(FetchAddedAccommodationsInitial()) {
    on<FetchAddedAccommodationHitEvent>((event, emit) async {
      try {
        emit(FetchAddedAccommodationsLoading());
        List<Accommodation> accommodations =
            await repo.getAccommodation(token: event.token);
        if (accommodations[0].error == null) {
          return emit(
              FetchAddedAccommodationsLoaded(accommodation: accommodations));
        }
        if (accommodations[0].error != null) {
          return emit(
              FetchAddedAccommodationsError(error: accommodations[0].error!));
        }
        return emit(
            FetchAddedAccommodationsError(error: "Something wen't wrong"));
      } catch (Exception) {
        return emit(
            FetchAddedAccommodationsError(error: "Check internet connection"));
      }
    });
  }
  @override
  void onChange(Change<FetchAddedAccommodationsState> change) {
    print(
        "The current state is ${change.currentState} and the next state is ${change.nextState}");
    super.onChange(change);
  }
}
