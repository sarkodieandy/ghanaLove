import 'package:flutter/material.dart';

import '../../../core/widgets/chat_app_bar.dart';
import '../../../core/widgets/chat_input.dart';
import '../../../core/widgets/chat_message_list.dart';
import '../../../core/widgets/profile_modal.dart';
import '../models/chat_message.dart';

class ChatScreen extends StatefulWidget {
  final String chatId;
  final String userName;

  const ChatScreen({super.key, required this.chatId, required this.userName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  late List<ChatMessage> _messages;
  late AnimationController _sendButtonController;
  late AnimationController _messageEntryController;
  late AnimationController _typingIndicatorController;

  bool _isTyping = false;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _initializeMessages();
    _initializeAnimations();
    _simulateTyping();

    _messageController.addListener(_onTextChanged);
  }

  void _initializeMessages() {
    _messages = [
      ChatMessage(
        id: '1',
        text: 'Hello! How are you?',
        isMe: false,
        timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
      ),
      ChatMessage(
        id: '2',
        text: 'I\'m good, thanks for asking. How about you?',
        isMe: true,
        timestamp: DateTime.now().subtract(const Duration(minutes: 28)),
      ),
      ChatMessage(
        id: '3',
        text: 'I\'m doing well. Are you free this weekend?',
        isMe: false,
        timestamp: DateTime.now().subtract(const Duration(minutes: 27)),
      ),
      ChatMessage(
        id: '4',
        text: 'Would you like to grab coffee sometime?',
        isMe: false,
        timestamp: DateTime.now().subtract(const Duration(minutes: 25)),
      ),
    ];
  }

  void _initializeAnimations() {
    _sendButtonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _messageEntryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _typingIndicatorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  void _simulateTyping() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _isTyping = true);
        Future.delayed(const Duration(seconds: 3), () {
          if (mounted) setState(() => _isTyping = false);
        });
      }
    });
  }

  void _onTextChanged() {
    final hasText = _messageController.text.trim().isNotEmpty;
    if (hasText != _hasText) {
      setState(() => _hasText = hasText);
    }
  }

  @override
  void dispose() {
    _messageController.removeListener(_onTextChanged);
    _messageController.dispose();
    _scrollController.dispose();
    _sendButtonController.dispose();
    _messageEntryController.dispose();
    _typingIndicatorController.dispose();
    super.dispose();
  }

  // ✅ Using Navigator to go back instead of go_router
  void _goBackToHome() {
    Navigator.pop(context);
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    _sendButtonController.forward().then((_) {
      _sendButtonController.reverse();
    });

    final newMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text,
      isMe: true,
      timestamp: DateTime.now(),
    );

    setState(() {
      _messages.insert(0, newMessage);
    });

    _messageEntryController.forward(from: 0);
    _messageController.clear();

    // Simulate reply
    final randomDelay = 1 + (DateTime.now().millisecond % 3);
    Future.delayed(Duration(seconds: randomDelay), () {
      if (mounted) {
        final reply = ChatMessage(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: _generateReply(),
          isMe: false,
          timestamp: DateTime.now(),
        );

        setState(() {
          _messages.insert(0, reply);
        });
        _messageEntryController.forward(from: 0);
      }
    });
  }

  String _generateReply() {
    final replies = [
      "That's interesting! Tell me more.",
      "I'd love to!",
      "Sounds great!",
      "What time were you thinking?",
      "😊",
      "Let's do it!",
      "I'm busy this weekend, but maybe next week?",
    ];
    return replies[DateTime.now().millisecond % replies.length];
  }

  void _onQuickReply(String text) {
    _messageController.text = text;
    setState(() => _hasText = true);
  }

  void _showProfileModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ProfileModal(chatId: widget.chatId),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : Colors.grey[50],
      appBar: ChatAppBar(
        onBackPressed: _goBackToHome,
        onProfileTap: _showProfileModal,
        chatId: widget.chatId,
      ),
      body: Column(
        children: [
          Expanded(
            child: ChatMessageList(
              messages: _messages,
              isTyping: _isTyping,
              typingController: _typingIndicatorController,
              messageController: _messageEntryController,
              scrollController: _scrollController,
            ),
          ),
          ChatInput(
            controller: _messageController,
            hasText: _hasText,
            sendButtonController: _sendButtonController,
            onSendMessage: _sendMessage,
            onQuickReply: _onQuickReply,
          ),
        ],
      ),
    );
  }
}
