import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:true_connect/core/models/chat_models.dart';
import 'package:true_connect/core/models/user_model.dart';
import 'package:true_connect/core/services/chat_service.dart';
import 'package:true_connect/features/chat/views/chat_view.dart';
import 'package:true_connect/features/widgets/avatar_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final chatService = ChatService();

    return Scaffold(
      body: Column(
        children: [
          // Story section (can be updated later with real data)
          Container(
            margin: const EdgeInsets.all(10),
            height: 70,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => const AvatarWidget(),
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemCount: 7,
            ),
          ),

          // Real-time Chat list
          Expanded(
            child: StreamBuilder<List<ChatRoom>>(
              stream: chatService.getConversations(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                
                final rooms = snapshot.data ?? [];
                if (rooms.isEmpty) {
                  return const Center(child: Text('No conversations yet'));
                }

                return ListView.separated(
                  itemCount: rooms.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    final room = rooms[index];
                    // Find the other participant
                    final otherId = room.participants.firstWhere(
                      (id) => id != chatService.currentUserId,
                      orElse: () => room.participants.first,
                    );

                    return ListTile(
                      leading: const AvatarWidget(),
                      title: Text('User $otherId'), // Ideally fetch name from Firestore
                      subtitle: Text(
                        room.lastMessage.isEmpty 
                            ? 'No messages yet' 
                            : room.lastMessage,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () {
                        // Create a dummy UserModel for the view
                        final receiver = UserModel(
                          id: otherId,
                          displayName: 'User $otherId',
                          phoneNumber: '',
                        );
                        Get.to(() => ChatView(chatId: room.id, receiver: receiver));
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
