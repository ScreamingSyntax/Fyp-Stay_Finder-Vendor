import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stayfinder_vendor/data/model/model_exports.dart';
import 'package:stayfinder_vendor/data/repository/repository_exports.dart';

part 'seen_all_messages_state.dart';

class SeenAllMessagesCubit extends Cubit<SeenAllMessagesState> {
  ChatRepository _chatRepository = new ChatRepository();
  SeenAllMessagesCubit() : super(SeenAllMessagesInitial());

  void viewAllMessages(
      {required String token,
      required String userId,
      required String recieverId}) async {
    emit(SeenAllMessagesLoading());
    Success success = await _chatRepository.seenAllMessages(
        token: token, userId: userId, recieverId: recieverId);
    if (success.success == 0) {
      return emit(SeenAllMessagesError(message: success.message!));
    }
    emit(SeenAllMessagesSuccess());
  }
}
