part of 'boolean_change_cubit.dart';

class BooleanChangeState extends Equatable {
  final bool value;
  BooleanChangeState({required this.value});

  @override
  List<Object> get props => [value];
}
