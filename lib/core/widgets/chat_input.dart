import 'package:flutter/material.dart';
import '../../../../core/constants/app_strings.dart';

class ChatInput extends StatelessWidget {
  final TextEditingController controller;
  final bool hasText;
  final AnimationController sendButtonController;
  final VoidCallback onSendMessage;
  final Function(String) onQuickReply;

  const ChatInput({
    super.key,
    required this.controller,
    required this.hasText,
    required this.sendButtonController,
    required this.onSendMessage,
    required this.onQuickReply,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // Quick reply options
          _buildQuickReplies(),

          // Input field
          _buildInputField(context),
        ],
      ),
    );
  }

  Widget _buildQuickReplies() {
    final quickReplies = ["Hi there!", "What's up?", "Let's meet!", "😊", "👍"];

    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: quickReplies.length,
        itemBuilder: (context, index) {
          return _buildQuickReply(quickReplies[index]);
        },
      ),
    );
  }

  Widget _buildQuickReply(String text) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: InkWell(
        onTap: () => onQuickReply(text),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Text(text, style: const TextStyle(color: Colors.black)),
        ),
      ),
    );
  }

  Widget _buildInputField(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      color: Colors.white,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            color: Colors.blue,
            onPressed: _showAttachmentOptions,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: AppStrings.typeMessage,
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey[600]),
                      ),
                      maxLines: null,
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ),
                  if (!hasText)
                    IconButton(
                      icon: const Icon(Icons.emoji_emotions),
                      color: Colors.blue,
                      onPressed: _showEmojiPicker,
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: hasText
                ? ScaleTransition(
                    scale: Tween(begin: 0.8, end: 1.0).animate(
                      CurvedAnimation(
                        parent: sendButtonController,
                        curve: Curves.easeOut,
                      ),
                    ),
                    child: IconButton(
                      key: const ValueKey('send'),
                      icon: const Icon(Icons.send),
                      color: Colors.blue,
                      onPressed: onSendMessage,
                    ),
                  )
                : IconButton(
                    key: const ValueKey('mic'),
                    icon: const Icon(Icons.mic),
                    color: Colors.blue,
                    onPressed: _startVoiceRecording,
                  ),
          ),
        ],
      ),
    );
  }

  void _showAttachmentOptions() {
    // TODO: Implement attachment options
  }

  void _showEmojiPicker() {
    // TODO: Implement emoji picker
  }

  void _startVoiceRecording() {
    // TODO: Implement voice recording
  }
}
