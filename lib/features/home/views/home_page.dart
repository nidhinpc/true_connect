import 'package:flutter/material.dart';
import 'package:true_connect/features/chat/views/chat_page.dart';
import 'package:true_connect/features/widgets/avatar_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Story section
          Container(
            margin: const EdgeInsets.all(10),
            height: 70,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => AvatarWidget(),
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemCount: 7,
            ),
          ),

          // Chat list
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => ListTile(
                leading: AvatarWidget(),
                title: Text('User $index'),
                subtitle: Text('Last message from user $index'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChatPage()),
                ),
              ),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
