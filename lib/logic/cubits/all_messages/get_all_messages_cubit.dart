import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stayfinder_vendor/data/model/chat_model.dart';
import 'package:stayfinder_vendor/data/model/model_exports.dart';
import 'package:stayfinder_vendor/data/repository/repository_exports.dart';

part 'get_all_messages_state.dart';

class GetAllMessagesCubit extends Cubit<GetAllMessagesState> {
  ChatRepository _repository = new ChatRepository();
  GetAllMessagesCubit() : super(GetAllMessagesInitial());
  void getAllMessages({required String token, required String userId}) async {
    emit(GetAllMessagesLoading());
    Success success =
        await _repository.getAllMessages(token: token, userId: userId);
    if (success.success == 0) {
      return emit(GetAllMessagesError(message: success.message!));
    }
    List<ChatModel> chats = List.from(success.data!['messages'])
        .map((e) => ChatModel.fromMap(e))
        .toList();
    return emit(GetAllMessagesSuccess(messages: chats));
  }

  @override
  void onChange(Change<GetAllMessagesState> change) {
    print("C : ${change.currentState} N : ${change.nextState}");
    super.onChange(change);
  }
}
