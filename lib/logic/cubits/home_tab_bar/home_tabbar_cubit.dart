import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_tabbar_state.dart';

class HomeTabbarCubit extends Cubit<HomeTabbarState> {
  HomeTabbarCubit() : super(HomeTabbarState());
  void firstElementClicked() => emit(state.copyWith(item1: true, item2: false));
  void secondElementClicked() =>
      emit(state.copyWith(item2: true, item1: false));
  @override
  void onChange(Change<HomeTabbarState> change) {
    print(
        "The current state is ${change.currentState} and the next state is ${change.nextState}");
    super.onChange(change);
  }
}
