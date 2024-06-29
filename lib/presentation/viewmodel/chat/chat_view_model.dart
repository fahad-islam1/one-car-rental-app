import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_car_rental_app/data/model/chat_model.dart';

class ChatViewModel extends GetxController {
  var messages = <ChatMessage>[].obs;

  void sendMessage(String message, bool isUserMessage) {
    if (message.isNotEmpty) {
      messages.add(ChatMessage(
        message: message,
        timestamp: TimeOfDay.now().format(Get.context!),
        isUserMessage: isUserMessage,
      ));
    }
  }
}
