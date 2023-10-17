part of 'home_tabbar_cubit.dart';

class HomeTabbarState extends Equatable {
  final bool item1;
  final bool item2;
  const HomeTabbarState({this.item1 = true, this.item2 = false});

  HomeTabbarState copyWith({bool? item1, bool? item2}) {
    return HomeTabbarState(
        item1: item1 ?? this.item1, item2: item2 ?? this.item2);
  }

  @override
  List<Object> get props => [item1, item2];
}
