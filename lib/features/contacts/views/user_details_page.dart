import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:true_connect/core/models/user_model.dart';
import 'package:true_connect/features/widgets/avatar_widget.dart';
import 'package:true_connect/core/services/chat_service.dart';
import 'package:true_connect/features/chat/views/chat_view.dart';

class UserDetailsPage extends StatelessWidget {
  final UserModel user;

  const UserDetailsPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Details'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 100),
            Center(
              child: Hero(
                tag: user.id,
                child: const AvatarWidget(), // Scale up if needed
              ),
            ),
            const SizedBox(height: 20),
            Text(
              user.displayName,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 10),
            Text(
              user.phoneNumber,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _ActionButton(
                    icon: Icons.message,
                    label: 'Message',
                    onTap: () async {
                      final chatService = ChatService();
                      // Sync user to Firestore first
                      await chatService.syncUser(user);
                      // Get or create chat room
                      final chatId = await chatService.getOrCreateChat(user.id);
                      // Navigate to chat
                      Get.to(() => ChatView(chatId: chatId, receiver: user));
                    },
                  ),
                  _ActionButton(icon: Icons.call, label: 'Call', onTap: () {}),
                  _ActionButton(icon: Icons.videocam, label: 'Video', onTap: () {}),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Divider(),
            _InfoTile(
              icon: Icons.info_outline,
              title: 'About',
              subtitle: 'Digital Nomad | Flutter Developer',
            ),
            _InfoTile(
              icon: Icons.notifications_none,
              title: 'Mute Notifications',
              trailing: Switch(value: false, onChanged: (v) {}),
            ),
            _InfoTile(
              icon: Icons.block,
              title: 'Block Contact',
              textColor: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Column(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
            child: Icon(icon, color: Theme.of(context).primaryColor),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final Color? textColor;

  const _InfoTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: textColor ?? Colors.black54),
      title: Text(
        title,
        style: TextStyle(color: textColor, fontWeight: FontWeight.w500),
      ),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: trailing,
    );
  }
}
