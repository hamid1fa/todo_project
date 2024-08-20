import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_proj/Message.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatController extends GetxController {
  var messages = <Message>[].obs;
  var textController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _loadMessages();
    messages.clear();
  }

  Future<void> _loadMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final savedMessages = prefs.getStringList('messages') ?? [];
    messages
        .addAll(savedMessages.map((msg) => Message.fromJson(json.decode(msg))));
  }

  Future<void> _saveMessages() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('messages',
        messages.map((element) => json.encode(element.toJson())).toList());
  }

  void sendMessage() {
    final message = textController.text;
    if (message.isNotEmpty) {
      messages.add(Message(message, true));
      textController.clear();
      _saveMessages(); // Save messages without recursion
      _addMessages(); // Add messages after saving
    }
  }

  void _addMessages() {
    messages.add(Message('hello sender', false));
  }
}
