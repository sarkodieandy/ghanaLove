import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/constants/app_colors.dart';

class ChatScreen extends StatefulWidget {
  final String chatId;

  const ChatScreen({super.key, required this.chatId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {'text': 'Hello! How are you?', 'isMe': false, 'time': '10:30 AM'},
    {
      'text': 'I\'m good, thanks for asking. How about you?',
      'isMe': true,
      'time': '10:32 AM',
    },
    {
      'text': 'I\'m doing well. Are you free this weekend?',
      'isMe': false,
      'time': '10:33 AM',
    },
  ];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _goBackToHome() {
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _goBackToHome,
        ),
        title: Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile.png'),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ama', style: Theme.of(context).textTheme.bodyLarge),
                Text(
                  'Online',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: AppColors.onlineGreen),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.videocam),
            onPressed: () {
              // Start video call
            },
          ),
          PopupMenuButton(
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'report', child: Text('Report')),
              PopupMenuItem(value: 'block', child: Text('Block')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Align(
                  alignment: message['isMe']
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: message['isMe']
                          ? AppColors.chatBubbleMe
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          message['text'],
                          style: const TextStyle(color: Colors.black),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          message['time'],
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.emoji_emotions),
                  onPressed: () {
                    // Show emoji picker
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: AppStrings.typeMessage,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.attach_file),
                  onPressed: () {
                    // Attach file
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (_messageController.text.isNotEmpty) {
                      setState(() {
                        _messages.insert(0, {
                          'text': _messageController.text,
                          'isMe': true,
                          'time': 'Now',
                        });
                        _messageController.clear();
                      });
                    }
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.grey[100],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButton(
                  text: AppStrings.virtualGift,
                  onPressed: () {
                    // Send virtual gift
                  },
                  isPrimary: false,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                ),
                CustomButton(
                  text: AppStrings.videoCall,
                  onPressed: () {
                    // Start video call
                  },
                  isPrimary: false,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
