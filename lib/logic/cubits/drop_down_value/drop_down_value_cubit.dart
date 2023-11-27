import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'drop_down_value_state.dart';

class DropDownValueCubit extends Cubit<DropDownValueState> {
  DropDownValueCubit() : super(DropDownValueState());
  instantiateDropDownValue({required List<String> items}) {
    emit(DropDownValueState(items: items));
  }

  changeDropDownValue(String value) =>
      emit(DropDownValueState(items: state.items, value: value));
  clearDropDownValue() => emit(DropDownValueState(items: null, value: null));
  @override
  void onChange(Change<DropDownValueState> change) {
    print(
        "Current State ${change.currentState}, Next State ${change.nextState}");
    super.onChange(change);
  }
}
