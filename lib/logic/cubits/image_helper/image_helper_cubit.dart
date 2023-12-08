import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../presentation/config/config_exports.dart';

part 'image_helper_state.dart';

class ImageHelperCubit extends Cubit<ImageHelperState> {
  ImageHelperCubit() : super(ImageHelperInitial());
  imageHelperAccess({required ImageHelper imageHelper}) =>
      emit(ImageHelperState(imageHelper: imageHelper));
  @override
  void onChange(Change<ImageHelperState> change) {
    print(
        "The current state is ${change.currentState} and the next state is ${change.nextState}");
    // TODO: implement onChange
    super.onChange(change);
  }
}
