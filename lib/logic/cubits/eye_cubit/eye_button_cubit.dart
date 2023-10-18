import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'eye_button_state.dart';

class EyeButtonCubit extends Cubit<EyeButtonState> {
  EyeButtonCubit() : super(EyeButtonState(clickedEye: true));
  void pressedEyeButton(bool value) => emit(EyeButtonState(clickedEye: value));
}
