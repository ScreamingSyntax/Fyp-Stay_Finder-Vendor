// ignore_for_file: must_be_immutable

part of 'document_detail_dart_bloc.dart';

class DocumentDetailDartState extends Equatable {
  File? profilePicture;
  File? nagriktaFront;
  File? nagriktaBack;
  DocumentDetailDartState({
    this.profilePicture,
    this.nagriktaBack,
    this.nagriktaFront,
  });
  DocumentDetailDartState copyWith({
    File? profilePicture,
    File? nagriktaFront,
    File? nagriktaBack,
  }) {
    return DocumentDetailDartState(
      profilePicture: profilePicture ?? this.profilePicture,
      nagriktaFront: nagriktaFront ?? this.nagriktaFront,
      nagriktaBack: nagriktaBack ?? this.nagriktaBack,
    );
  }

  @override
  List<File?> get props => [profilePicture, nagriktaFront, nagriktaBack];
}

class DocumentDetailDartInitial extends DocumentDetailDartState {}

class DocumentDetailFailedState extends DocumentDetailDartState {
  final DocumentDetailFailedState message;

  DocumentDetailFailedState(this.message);
}
// final class DocumentDetailDartInitial extends DocumentDetailDartState {}
