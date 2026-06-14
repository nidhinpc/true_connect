import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        animateColor: true,

        title: const Text('Chat'),
        actions: [
          IconButton(
            icon: const Icon(Icons.video_call),
            onPressed: () {
              // Handle video call action
            },
          ),
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () {
              // Handle voice call action
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Handle more options action
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircleAvatar(backgroundColor: Colors.blue, radius: 50),
                  SizedBox(height: 10),
                  Text('Chat with User', style: TextStyle(fontSize: 24)),
                  SizedBox(height: 5),
                  Text('Last message from user'),
                ],
              ),
            ),
            Spacer(),
            // user chat message and time on left side
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text('Hello! How are you?'),
                  ),
                  const Text(
                    '10:30 AM',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),

            // my chat message and time on right side
            Align(
              alignment: Alignment.centerRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.blue[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text('I am good, thank you!'),
                  ),
                  const Text(
                    '10:30 AM',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            TextField(
              minLines: 1,
              maxLines: 5,
              decoration: InputDecoration(
                fillColor: Colors.grey[200],
                filled: true,
                // border: OutlineInputBorder(gapPadding: 1),
                hintText: 'Type a message',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    // Handle send message action
                  },
                ),
                prefixIcon: IconButton(
                  icon: const Icon(
                    Icons.emoji_emotions,
                    color: Color.fromARGB(255, 249, 224, 2),
                  ),
                  onPressed: () {
                    // Handle emoji picker action
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
