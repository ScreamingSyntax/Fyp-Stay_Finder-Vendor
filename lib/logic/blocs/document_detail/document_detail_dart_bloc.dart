import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'document_detail_dart_event.dart';
part 'document_detail_dart_state.dart';

class DocumentDetailDartBloc
    extends Bloc<DocumentDetailDartEvent, DocumentDetailDartState> {
  DocumentDetailDartBloc() : super(DocumentDetailDartInitial()) {
    on<ProfilePictureAddEvent>(profilePicture);
    on<NagriktaFrontPictureAddEvent>(nagriktaFront);
    on<NagriktaBackPictureAddEvent>(nagriktaBack);
    on<DocumentDataClearEvent>(clearData);
  }

  Future<void> profilePicture(ProfilePictureAddEvent event,
      Emitter<DocumentDetailDartState> emit) async {
    emit(DocumentDetailDartState().copyWith(
        profilePicture: event.profilePicture,
        nagriktaBack: state.nagriktaBack,
        nagriktaFront: state.nagriktaFront));
  }

  Future<void> nagriktaFront(NagriktaFrontPictureAddEvent event,
      Emitter<DocumentDetailDartState> emit) async {
    emit(DocumentDetailDartState().copyWith(
        nagriktaFront: event.nagriktaFront,
        nagriktaBack: state.nagriktaBack,
        profilePicture: state.profilePicture));
  }

  Future<void> nagriktaBack(NagriktaBackPictureAddEvent event,
      Emitter<DocumentDetailDartState> emit) async {
    emit(DocumentDetailDartState().copyWith(
        nagriktaBack: event.nagriktaBack,
        nagriktaFront: state.nagriktaFront,
        profilePicture: state.profilePicture));
  }

  Future<void> clearData(DocumentDataClearEvent event,
      Emitter<DocumentDetailDartState> emit) async {
    emit(DocumentDetailDartState().copyWith(
        nagriktaBack: null, nagriktaFront: null, profilePicture: null));
  }

  @override
  void onChange(Change<DocumentDetailDartState> change) {
    print(
        "Current State ${change.currentState}, next state ${change.nextState}");
    super.onChange(change);
  }
}
