import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stayfinder_vendor/data/model/model_exports.dart';
import 'package:stayfinder_vendor/data/model/particular_chat_model.dart';
import 'package:stayfinder_vendor/data/repository/repository_exports.dart';

part 'view_particular_chat_state.dart';

class ViewParticularChatCubit extends Cubit<ViewParticularChatState> {
  ChatRepository _chatRepository = new ChatRepository();
  ViewParticularChatCubit() : super(ViewParticularChatInitial());
  void fetchParticularUserMessage(
      {required String token,
      required String senderId,
      required String recieverId}) async {
    Success success = await _chatRepository.viewPersonAllMessage(
        token: token, userId: senderId, recieverId: recieverId);
    print(success);
    if (success.success == 0) {
      return emit(ViewParticularChatErrror(message: success.message!));
    }
    return emit(ViewParticularChatSuccess(success.data!['reciever_image'],
        chats: List.from(success.data!["messages"])
            .map((e) => ChatModel.fromMap(e))
            .toList()));
  }

  void addMessage({required ChatModel chat}) {
    if (state is ViewParticularChatSuccess) {
      final currentState = state as ViewParticularChatSuccess;
      final updatedChats = List<ChatModel>.from(currentState.chats)..add(chat);
      emit(currentState.copyWith(chats: updatedChats));
    }
  }

  @override
  void onChange(Change<ViewParticularChatState> change) {
    print("Current: ${change.currentState} Next :${change.nextState}");
    super.onChange(change);
  }
}
