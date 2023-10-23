import '../cubit_exports.dart';

part 'nav_bar_index_state.dart';

class NavBarIndexCubit extends Cubit<NavBarIndexState> {
  NavBarIndexCubit() : super(NavBarIndexState(index: 0));
  void changeIndex(int index) => emit(NavBarIndexState(index: index));
}
