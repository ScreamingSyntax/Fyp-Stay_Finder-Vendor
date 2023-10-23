import '../../../data/model/model_exports.dart';
import '../../../data/repository/repository_exports.dart';
import '../bloc_exports.dart';

part 'fetch_tier_event.dart';
part 'fetch_tier_state.dart';

class FetchTierBloc extends Bloc<FetchTierEvent, FetchTierState> {
  FetchTierBloc({required TierRepository tier})
      : super(FetchTierInitialState()) {
    on<FetchTierHitEvent>((event, emit) async {
      await fetchTier(emit: emit, event: event, tier: tier);
    });
  }

  Future<void> fetchTier(
      {required FetchTierHitEvent event,
      required Emitter<FetchTierState> emit,
      required TierRepository tier}) async {
    try {
      emit(FetchTierLoadingState());
      final List<Tier> tierList = await tier.fetchTierData(token: event.token);
      // print(tierList);
      if (tierList[0].error != null) {
        emit(TierErrorState(errorMessage: tierList[0].error!));
        return;
      }

      emit(TierLoadedState(tierList: tierList));
      return;
    } catch (err) {
      emit(TierErrorState(errorMessage: "Connection Errrror"));
      return;
    }
  }

  @override
  void onChange(Change<FetchTierState> change) {
    print(
        "Current State ${change.currentState}, next state ${change.nextState}");
    super.onChange(change);
  }
}
