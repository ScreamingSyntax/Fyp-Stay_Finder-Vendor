import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stayfinder_vendor/data/model/model_exports.dart';

import '../../../data/repository/repository_exports.dart';

part 'fetch_current_tier_event.dart';
part 'fetch_current_tier_state.dart';

class FetchCurrentTierBloc
    extends Bloc<FetchCurrentTierEvent, FetchCurrentTierState> {
  FetchCurrentTierBloc({required CurrentTierApiRepository repository})
      : super(FetchCurrentTierInitial()) {
    on<FetchCurrentTierHitEvent>((event, emit) async {
      await fetchCurrentTier(event: event, emit: emit, repository: repository);
    });
  }
  Future<void> fetchCurrentTier(
      {required FetchCurrentTierHitEvent event,
      required Emitter<FetchCurrentTierState> emit,
      required CurrentTierApiRepository repository}) async {
    emit(FetchCurrentTierLoading());
    try {
      CurrentTier tier = await repository.getCurrentTier(token: event.token);
      if (tier.error != null) {
        return emit(FetchCurrentTierError(message: tier.error!));
      }
      // if(tier.)
      return emit(FetchCurrentTierLoaded(currentTier: tier));
    } catch (err) {
      return emit(FetchCurrentTierError(message: "Connect to internet please"));
    }
  }

  @override
  void onChange(Change<FetchCurrentTierState> change) {
    print(
        "Current State ${change.currentState}, next state ${change.nextState}");
    super.onChange(change);
  }
}
