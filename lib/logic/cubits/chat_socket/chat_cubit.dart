import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stayfinder_vendor/data/repository/chat_repository.dart';
import 'package:stayfinder_vendor/data/model/chat_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatRepository _chatRepository;

  ChatCubit(this._chatRepository) : super(ChatInitial());

  Future<void> connectWebSocket({
    required String senderId,
    required String receiverId,
  }) async {
    try {
      if (state is ChatDisconnected) {
        _chatRepository = new ChatRepository();
      }
      emit(ChatConnecting());
      await _chatRepository.connectWebSocket(
          senderId: senderId, receiverId: receiverId);
      _chatRepository.messages.listen(_onMessageReceived);
      emit(ChatConnected());
    } catch (e) {
      emit(ChatError("Failed to connect to WebSocket: ${e.toString()}"));
    }
  }

  void sendMessage({
    required String sender,
    required String receiver,
    required String message,
  }) {
    _chatRepository.sendMessage(
        sender: sender, receiver: receiver, message: message);
  }

  void _onMessageReceived(dynamic messageData) {
    ChatModel message = ChatModel.fromMap(messageData);
    if (state is ChatMessageReceived) {
      final currentState = state as ChatMessageReceived;
      return emit(currentState.copyWith(message: message));
    }
    return emit(ChatMessageReceived(message));
  }

  void disconnectWebSocket() {
    _chatRepository.disconnectWebSocket();
    emit(ChatDisconnected());
  }

  @override
  Future<void> close() {
    disconnectWebSocket();
    return super.close();
  }

  @override
  void onChange(Change<ChatState> change) {
    print("C ${change.currentState} N ${change.nextState}");
    super.onChange(change);
  }
}
