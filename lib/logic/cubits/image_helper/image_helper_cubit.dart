import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../presentation/config/config_exports.dart';

part 'image_helper_state.dart';

class ImageHelperCubit extends Cubit<ImageHelperState> {
  ImageHelperCubit() : super(ImageHelperInitial());
  imageHelperAccess({required ImageHelper imageHelper}) =>
      emit(ImageHelperState(imageHelper: imageHelper));
}
