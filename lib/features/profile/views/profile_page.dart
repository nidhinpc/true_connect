import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircleAvatar(backgroundColor: Colors.blue, radius: 50),
            SizedBox(height: 10),
            Text('John Doe', style: TextStyle(fontSize: 24)),
            SizedBox(height: 5),
            Text('john.doe@example.com'),
          ],
        ),
      ),
    );
  }
}
