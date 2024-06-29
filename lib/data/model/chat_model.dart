
class ChatMessage {
  final String message;
  final String timestamp;
  final bool isUserMessage;

  ChatMessage({required this.message, required this.timestamp, required this.isUserMessage});
}