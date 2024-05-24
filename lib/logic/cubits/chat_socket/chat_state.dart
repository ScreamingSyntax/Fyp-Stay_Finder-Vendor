part of 'chat_cubit.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class ChatConnecting extends ChatState {}

class ChatConnected extends ChatState {}

class ChatMessageReceived extends ChatState {
  final ChatModel message;

  const ChatMessageReceived(this.message);
  ChatMessageReceived copyWith({
    ChatModel? message,
  }) {
    return ChatMessageReceived(
      message ?? this.message,
    );
  }

  @override
  List<Object> get props => [message];
}

class ChatError extends ChatState {
  final String error;

  const ChatError(this.error);

  @override
  List<Object> get props => [error];
}

class ChatDisconnected extends ChatState {}
