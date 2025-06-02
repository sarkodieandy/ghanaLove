import 'package:flutter/material.dart';
import '../../features/chat/presentation/chat_screen.dart';

class MessagesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> previousChats = [
    {
      'name': 'Ama',
      'photo': 'assets/images/home1.png',
      'chatId': 'chat_ama',
      'lastMessage': 'Hey, how are you?',
    },
    {
      'name': 'Kwame',
      'photo': 'assets/images/home2.png',
      'chatId': 'chat_kwame',
      'lastMessage': 'Can’t wait to see you again!',
    },
    {
      'name': 'Akosua',
      'photo': 'assets/images/home3.png',
      'chatId': 'chat_akosua',
      'lastMessage': 'I had fun chatting earlier!',
    },
  ];

  MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),

        title: const Text("Messages"),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: previousChats.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final chat = previousChats[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(chat['photo']),
              radius: 28,
            ),
            title: Text(
              chat['name'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              chat['lastMessage'],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: const Icon(Icons.chat_bubble_outline),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChatScreen(
                    userName: chat['name'],
                    chatId: chat['chatId'],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
