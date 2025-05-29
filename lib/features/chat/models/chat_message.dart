class ChatMessage {
  final String id;
  final String text;
  final bool isMe;
  final DateTime timestamp;
  final MessageStatus status;
  final String? imageUrl;

  ChatMessage({
    required this.id,
    required this.text,
    required this.isMe,
    required this.timestamp,
    this.status = MessageStatus.sent,
    this.imageUrl,
  });

  String get formattedTime {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}';
    } else {
      return '${timestamp.day}/${timestamp.month}';
    }
  }
}

enum MessageStatus { sending, sent, delivered, read, failed }
