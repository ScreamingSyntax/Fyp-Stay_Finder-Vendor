import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'store_images_state.dart';

class StoreImagesCubit extends Cubit<StoreImagesState> {
  StoreImagesCubit() : super(StoreImagesState(images: []));
  addImages(List<File> images) => emit(StoreImagesState(images: images));
  addImage(File file) {
    emit(StoreImagesState(images: List.from([file])));
  }

  clearImages() => emit(StoreImagesState(images: []));
  @override
  void onChange(Change<StoreImagesState> change) {
    print(
        "The current state is ${change.currentState} and the next state is ${change.nextState}");
    super.onChange(change);
  }
}
