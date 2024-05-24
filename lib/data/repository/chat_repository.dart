import 'package:stayfinder_vendor/data/api/api_exports.dart';

import '../model/model_exports.dart';

class ChatRepository {
  ChatApiProvider _apiProvider = new ChatApiProvider();
  final ChatSocketApi _chatSocketApi = new ChatSocketApi();
  Future<Success> getAllMessages(
      {required String token, required String userId}) async {
    return await _apiProvider.getAllMessages(token: token, userId: userId);
  }

  Future<void> connectWebSocket(
      {required String senderId, required String receiverId}) async {
    await _chatSocketApi.connect(senderId: senderId, receiverId: receiverId);
  }

  void sendMessage(
      {required String sender,
      required String receiver,
      required String message}) async {
    _chatSocketApi.sendMessage(
        sender: sender, receiver: receiver, message: message);
  }

  Stream get messages => _chatSocketApi.messages;

  Future<Success> seenAllMessages(
      {required String token,
      required String userId,
      required String recieverId}) async {
    return await _apiProvider.seenAllMessages(
        token: token, userId: userId, recieverId: recieverId);
  }

  Future viewPersonAllMessage(
      {required String token,
      required String userId,
      required String recieverId}) async {
    return await _apiProvider.viewPersonAllMessage(
        token: token, userId: userId, recieverId: recieverId);
  }

  void disconnectWebSocket() {
    _chatSocketApi.disconnect();
  }
}
