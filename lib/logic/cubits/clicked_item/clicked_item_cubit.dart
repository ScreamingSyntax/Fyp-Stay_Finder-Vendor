import '../cubit_exports.dart';

part 'clicked_item_state.dart';

class ClickedItemCubit extends Cubit<ClickedItemState> {
  ClickedItemCubit() : super(ClickedItemState(clicked: true));
  void clicked() => emit(ClickedItemState(clicked: false));
  void unclicked() => emit(ClickedItemState(clicked: true));
  void clickedUnique(bool clicked) => emit(ClickedItemState(clicked: clicked));
  @override
  void onChange(Change<ClickedItemState> change) {
    print(
        "Current State ${change.currentState.clicked} Next State ${change.nextState.clicked}");
    super.onChange(change);
  }
}
