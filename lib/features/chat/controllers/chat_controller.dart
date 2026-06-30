import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:true_connect/core/models/chat_models.dart';
import 'package:true_connect/core/services/chat_service.dart';

class ChatController extends GetxController {
  final ChatService _chatService = ChatService();
  final String chatId;

  ChatController({required this.chatId});

  final TextEditingController messageController = TextEditingController();
  var messages = <ChatMessage>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    messages.bindStream(_chatService.getMessages(chatId));
    ever(messages, (_) => isLoading(false));
  }

  Future<void> sendMessage() async {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    // Clear textfield immediately as requested
    messageController.clear();

    try {
      await _chatService.sendMessage(chatId, text);
    } catch (e) {
      Get.snackbar('Error', 'Failed to send message: $e');
    }
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }
}
