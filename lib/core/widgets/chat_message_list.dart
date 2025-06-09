import 'package:flutter/material.dart';
import '../../features/chat/models/chat_message.dart';
import 'message_bubble.dart';
import 'typing_indicator.dart';

class ChatMessageList extends StatelessWidget {
  final List<ChatMessage> messages;
  final bool isTyping;
  final AnimationController typingController;
  final AnimationController messageController;
  final ScrollController scrollController;

  const ChatMessageList({
    super.key,
    required this.messages,
    required this.isTyping,
    required this.typingController,
    required this.messageController,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Chat background
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/chat_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Messages list
        ListView.builder(
          controller: scrollController,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
          reverse: true,
          itemCount: messages.length + (isTyping ? 1 : 0),
          itemBuilder: (context, index) {
            if (isTyping && index == 0) {
              return TypingIndicator(controller: typingController);
            }

            final messageIndex = index - (isTyping ? 1 : 0);
            final message = messages[messageIndex];
            final isLastFromUser = _isLastFromUser(messageIndex);

            return AnimatedBuilder(
              animation: messageController,
              builder: (context, child) {
                // Only animate new messages (first in the list)
                final shouldAnimate = messageIndex == 0;
                final scale = shouldAnimate ? messageController.value : 1.0;

                return Transform.scale(
                  scale: scale,
                  alignment: message.isMe
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: child,
                );
              },
              child: MessageBubble(
                message: message,
                isLastFromUser: isLastFromUser,
              ),
            );
          },
        ),
      ],
    );
  }

  bool _isLastFromUser(int index) {
    if (index == messages.length - 1) return true;
    return messages[index + 1].isMe != messages[index].isMe;
  }
}
