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
        mainAxisSize: MainAxisSize.min,
        children: [_buildQuickReplies(), _buildInputField(context)],
      ),
    );
  }

  Widget _buildQuickReplies() {
    final quickReplies = ["Hi there!", "What's up?", "Let's meet!", "😊", "👍"];

    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: quickReplies.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: InkWell(
              onTap: () => onQuickReply(quickReplies[index]),
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Text(
                  quickReplies[index],
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInputField(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            color: Colors.blue,
            onPressed: () => _showAttachmentOptions(context),
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
                      maxLines: null,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        hintText: AppStrings.typeMessage,
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                  ),
                  if (!hasText)
                    IconButton(
                      icon: const Icon(Icons.emoji_emotions),
                      color: Colors.blue,
                      onPressed: () => _showEmojiPicker(context),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 6),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            transitionBuilder: (child, animation) =>
                ScaleTransition(scale: animation, child: child),
            child: hasText
                ? IconButton(
                    key: const ValueKey('send'),
                    icon: const Icon(Icons.send),
                    color: Colors.blue,
                    onPressed: onSendMessage,
                  )
                : IconButton(
                    key: const ValueKey('mic'),
                    icon: const Icon(Icons.mic),
                    color: Colors.blue,
                    onPressed: () => _startVoiceRecording(context),
                  ),
          ),
        ],
      ),
    );
  }

  void _showAttachmentOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Container(
        height: 150,
        padding: const EdgeInsets.all(16),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Attachment Options",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.photo, color: Colors.blue),
                SizedBox(width: 8),
                Text("Send Photo"),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.location_pin, color: Colors.red),
                SizedBox(width: 8),
                Text("Share Location"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showEmojiPicker(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Emoji picker feature coming soon!')),
    );
  }

  void _startVoiceRecording(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Voice recording feature coming soon!')),
    );
  }
}
