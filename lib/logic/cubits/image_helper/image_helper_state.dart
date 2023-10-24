// ignore_for_file: must_be_immutable

part of 'image_helper_cubit.dart';

class ImageHelperState extends Equatable {
  ImageHelper? imageHelper;

  ImageHelperState({this.imageHelper});
  @override
  List<Object> get props => [imageHelper!];
}

class ImageHelperInitial extends ImageHelperState {}
