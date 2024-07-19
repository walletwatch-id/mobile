class ChatMessage {
  final String id;
  final String sender;
  final String message;
  final String hash;
  final String status;

  ChatMessage({
    required this.id,
    required this.sender,
    required this.message,
    required this.hash,
    required this.status,
  });
}
