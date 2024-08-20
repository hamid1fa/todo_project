import 'package:flutter/material.dart';
import 'package:flutter_proj/chat_controller.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chatController = Get.put(ChatController());

    return Scaffold(
      appBar: AppBar(
        title: Text('chat Screen'),
      ),
      body: Column(
        children: [
          Expanded(child: Obx(() {
            return ListView.builder(
                itemCount: chatController.messages.length,
                itemBuilder: (context, index) {
                  final message = chatController.messages[index];
                  return Align(
                      alignment: message.isUserMessage
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: (Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          decoration: BoxDecoration(
                              color: message.isUserMessage
                                  ? Colors.blueAccent
                                  : Colors.grey,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            message.text,
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                      ));
                });
          })),
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: chatController.textController,
                  decoration: InputDecoration(
                      hintText: 'Type Message',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                )),
                IconButton(
                    onPressed: chatController.sendMessage,
                    icon: Icon(Icons.send))
              ],
            ),
          )
        ],
      ),
    );
  }
}
