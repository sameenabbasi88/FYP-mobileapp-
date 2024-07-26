class Message {
  final String senderEmail;
  final String receiverEmail;
  final String content;
  final DateTime timestamp;

  Message({
    required this.senderEmail,
    required this.receiverEmail,
    required this.content,
    required this.timestamp,
  });
}
