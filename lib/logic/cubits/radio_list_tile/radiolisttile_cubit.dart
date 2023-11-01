import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/model/model_exports.dart';

part 'radiolisttile_state.dart';

class RadioListTileCubit extends Cubit<RadioListTileState> {
  RadioListTileCubit() : super(RadioListTileState());
  void changeCurrentOption(
          {required Tier option, required List<Tier> optionList}) =>
      emit(RadioListTileState()
          .copyWith(newCurrentValue: option, newGroupValue: optionList));
  void instantiateOptionList({required List<Tier> option}) =>
      emit(RadioListTileState(currentValue: option[1], groupValue: option));
  @override
  void onChange(Change<RadioListTileState> change) {
    print(
        "Current State ${change.currentState}, next state ${change.nextState}");
    super.onChange(change);
  }
}
