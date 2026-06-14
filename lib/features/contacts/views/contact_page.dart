import 'package:flutter/material.dart';
import 'package:true_connect/features/widgets/avatar_widget.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contacts')),
      body: ListView.separated(
        itemBuilder: (context, index) => ListTile(
          leading: AvatarWidget(),
          title: Text('Contact $index'),
          subtitle: const Text('Tap to start a chat'),
        ),
        separatorBuilder: (context, index) => const Divider(),
        itemCount: 15,
      ),
    );
  }
}
