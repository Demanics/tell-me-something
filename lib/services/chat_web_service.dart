import 'dart:convert';

import 'package:web_socket_client/web_socket_client.dart';

class ChatWebService {
  static final _instance = ChatWebService._internal();
  WebSocket? _socket;
  ChatWebService._internal();
  factory ChatWebService() => _instance;


  
  void connect() {
    _socket = WebSocket(Uri.parse("ws://localhost:8000/ws/chat"));
    _socket!.messages.listen((message) {
      final data = jsonDecode(message);
      print(data['type']);
    });
  }

  void chat(String query) {
    _socket!.send(jsonEncode({'query': query}));
  }
}
