part of 'document_detail_dart_bloc.dart';

sealed class DocumentDetailDartEvent extends Equatable {
  const DocumentDetailDartEvent();

  @override
  List<Object> get props => [];
}

class ProfilePictureAddEvent extends DocumentDetailDartEvent {
  final File profilePicture;
  const ProfilePictureAddEvent({required this.profilePicture});

  @override
  List<Object> get props => [profilePicture];
}

class NagriktaFrontPictureAddEvent extends DocumentDetailDartEvent {
  final File nagriktaFront;
  const NagriktaFrontPictureAddEvent({required this.nagriktaFront});

  @override
  List<Object> get props => [nagriktaFront];
}

class NagriktaBackPictureAddEvent extends DocumentDetailDartEvent {
  final File nagriktaBack;
  const NagriktaBackPictureAddEvent({required this.nagriktaBack});

  @override
  List<Object> get props => [nagriktaBack];
}

class DocumentDataClearEvent extends DocumentDetailDartEvent {}
