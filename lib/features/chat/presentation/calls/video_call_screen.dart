import 'package:flutter/material.dart';

class VideoCallScreen extends StatelessWidget {
  final String userName;

  const VideoCallScreen({super.key, required this.userName});

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
        title: const Text("Video Call", style: TextStyle(color: Colors.white)),
      ),
      body: Stack(
        children: [
          Center(child: Icon(Icons.videocam, size: 120, color: Colors.white24)),
          Positioned(
            top: 60,
            right: 20,
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey.shade800,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton.icon(
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
            ),
          ),
        ],
      ),
    );
  }
}
