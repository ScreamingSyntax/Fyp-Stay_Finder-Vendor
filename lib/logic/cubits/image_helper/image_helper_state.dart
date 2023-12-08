// ignore_for_file: must_be_immutable

part of 'image_helper_cubit.dart';

class ImageHelperState extends Equatable {
  ImageHelper? imageHelper;

  ImageHelperState({this.imageHelper});
  @override
  List<Object> get props {
    if (this.imageHelper != null) {
      return [this.imageHelper!];
    }
    return [];
  }
}

class ImageHelperInitial extends ImageHelperState {}
