import 'package:flutter/material.dart';

class VoiceCallScreen extends StatelessWidget {
  final String userName;

  const VoiceCallScreen({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Voice Call", style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.call, size: 100, color: Colors.greenAccent),
            const SizedBox(height: 20),
            Text(
              userName,
              style: const TextStyle(fontSize: 28, color: Colors.white),
            ),
            const SizedBox(height: 10),
            const Text("Calling...", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 50),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.call_end),
              label: const Text("End Call"),
            ),
          ],
        ),
      ),
    );
  }
}
