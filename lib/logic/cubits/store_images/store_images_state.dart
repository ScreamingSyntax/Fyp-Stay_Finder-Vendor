part of 'store_images_cubit.dart';

class StoreImagesState extends Equatable {
  final List<File> images;
  StoreImagesState({required this.images});

  @override
  List<Object> get props => [this.images];
}
