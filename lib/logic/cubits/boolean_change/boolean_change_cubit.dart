import '../../blocs/bloc_exports.dart';

part 'boolean_change_state.dart';

class BooleanChangeCubit extends Cubit<BooleanChangeState> {
  BooleanChangeCubit() : super(BooleanChangeState(value: false));
  void change() => emit(BooleanChangeState(value: !(state.value)));
}
