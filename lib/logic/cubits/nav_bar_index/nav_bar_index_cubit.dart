import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'nav_bar_index_state.dart';

class NavBarIndexCubit extends Cubit<NavBarIndexState> {
  NavBarIndexCubit() : super(NavBarIndexState(index: 0));
  void changeIndex(int index) => emit(NavBarIndexState(index: index));
}
