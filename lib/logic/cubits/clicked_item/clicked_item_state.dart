part of 'clicked_item_cubit.dart';

class ClickedItemState extends Equatable {
  final bool clicked;
  const ClickedItemState({required this.clicked});

  @override
  List<Object> get props => [clicked];
}
