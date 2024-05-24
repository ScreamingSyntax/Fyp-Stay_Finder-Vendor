import 'package:stayfinder_vendor/constants/constants_exports.dart';
import 'package:stayfinder_vendor/data/model/model_exports.dart';

import 'api_exports.dart';

class ChatSocketApi {
  late WebSocket _socket;
  late StreamController _controller;
  final String _baseUrl = 'ws://${justIp()}/ws/chat';
  ChatSocketApi() : _controller = StreamController.broadcast();

  Future<void> connect({
    required String senderId,
    required String receiverId,
  }) async {
    final String url = '$_baseUrl/$senderId/$receiverId';

    try {
      _socket = await WebSocket.connect(url);

      _socket.listen(
        (data) {
          _controller.add(jsonDecode(data));
        },
        onDone: () {
          _controller.close();
        },
        onError: (error) {
          print("WebSocket Error: $error");
          _controller.addError("WebSocket connection failed");
        },
        cancelOnError: true,
      );
    } catch (e) {
      print("WebSocket Connect Error: $e");
      _controller.addError("Failed to connect to WebSocket");
    }
  }

  void sendMessage(
      {required String sender,
      required String receiver,
      required String message}) {
    var messageData = {
      "sender": sender,
      "receiver": receiver,
      "message": message,
    };
    if (_socket != null && _socket.readyState == WebSocket.open) {
      _socket.add(json.encode(messageData));
    }
  }

  Stream get messages => _controller.stream;

  void disconnect() {
    if (_socket != null) {
      _socket.close();
    }
  }
}
