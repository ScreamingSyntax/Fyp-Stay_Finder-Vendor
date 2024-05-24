part of 'seen_all_messages_cubit.dart';

sealed class SeenAllMessagesState extends Equatable {
  const SeenAllMessagesState();

  @override
  List<Object> get props => [];
}

class SeenAllMessagesInitial extends SeenAllMessagesState {}

class SeenAllMessagesLoading extends SeenAllMessagesState {}

class SeenAllMessagesSuccess extends SeenAllMessagesState {}

class SeenAllMessagesError extends SeenAllMessagesState {
  final String message;

  SeenAllMessagesError({required this.message});
}
