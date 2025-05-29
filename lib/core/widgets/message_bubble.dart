import 'package:flutter/material.dart';
import '../../features/chat/models/chat_message.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final bool isLastFromUser;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isLastFromUser,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLastFromUser ? 12.0 : 4.0),
      child: Align(
        alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
          ),
          child: Column(
            crossAxisAlignment: message.isMe
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              _buildMessageContainer(context),
              if (message.isMe && isLastFromUser) _buildMessageStatus(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageContainer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: message.isMe
            ? Theme.of(context).primaryColor.withOpacity(0.9)
            : Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20),
          topRight: const Radius.circular(20),
          bottomLeft: Radius.circular(message.isMe ? 20 : 4),
          bottomRight: Radius.circular(message.isMe ? 4 : 20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (message.imageUrl != null) _buildImageContent(),
          if (message.text.isNotEmpty) _buildTextContent(context),
          const SizedBox(height: 4),
          _buildTimestamp(context),
        ],
      ),
    );
  }

  Widget _buildImageContent() {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          message.imageUrl!,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: 150,
              color: Colors.grey[300],
              child: const Icon(Icons.error),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTextContent(BuildContext context) {
    return Text(
      message.text,
      style: TextStyle(
        color: message.isMe ? Colors.white : Colors.black,
        fontSize: 16,
        height: 1.3,
      ),
    );
  }

  Widget _buildTimestamp(BuildContext context) {
    return Text(
      message.formattedTime,
      style: TextStyle(
        color: message.isMe ? Colors.white.withOpacity(0.7) : Colors.grey[600],
        fontSize: 10,
      ),
    );
  }

  Widget _buildMessageStatus(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_getStatusIcon(), size: 16, color: _getStatusColor(context)),
          const SizedBox(width: 4),
          Text(
            _getStatusText(),
            style: TextStyle(color: Colors.grey[600], fontSize: 10),
          ),
        ],
      ),
    );
  }

  IconData _getStatusIcon() {
    switch (message.status) {
      case MessageStatus.sending:
        return Icons.access_time;
      case MessageStatus.sent:
        return Icons.done;
      case MessageStatus.delivered:
        return Icons.done_all;
      case MessageStatus.read:
        return Icons.done_all;
      case MessageStatus.failed:
        return Icons.error_outline;
    }
  }

  Color _getStatusColor(BuildContext context) {
    switch (message.status) {
      case MessageStatus.sending:
        return Colors.grey;
      case MessageStatus.sent:
        return Colors.grey;
      case MessageStatus.delivered:
        return Colors.grey;
      case MessageStatus.read:
        return Theme.of(context).primaryColor;
      case MessageStatus.failed:
        return Colors.red;
    }
  }

  String _getStatusText() {
    switch (message.status) {
      case MessageStatus.sending:
        return 'Sending';
      case MessageStatus.sent:
        return 'Sent';
      case MessageStatus.delivered:
        return 'Delivered';
      case MessageStatus.read:
        return 'Read';
      case MessageStatus.failed:
        return 'Failed';
    }
  }
}
