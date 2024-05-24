part of 'get_all_messages_cubit.dart';

sealed class GetAllMessagesState extends Equatable {
  const GetAllMessagesState();

  @override
  List<Object> get props => [];
}

class GetAllMessagesInitial extends GetAllMessagesState {}

class GetAllMessagesLoading extends GetAllMessagesState {}

class GetAllMessagesSuccess extends GetAllMessagesState {
  final List<ChatModel> messages;

  GetAllMessagesSuccess({required this.messages});

  @override
  List<Object> get props => [messages];
}

class GetAllMessagesError extends GetAllMessagesState {
  final String message;

  GetAllMessagesError({required this.message});
  @override
  List<Object> get props => [message];
}
