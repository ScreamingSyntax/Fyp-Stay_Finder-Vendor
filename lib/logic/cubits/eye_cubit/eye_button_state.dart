part of 'eye_button_cubit.dart';

class EyeButtonState extends Equatable {
  final bool clickedEye;

  const EyeButtonState({required this.clickedEye});
  @override
  List<Object> get props => [clickedEye];
}
