import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:true_connect/features/contacts/controllers/contact_controller.dart';
import 'package:true_connect/features/widgets/avatar_widget.dart';
import 'package:true_connect/features/contacts/views/user_details_page.dart';

class ContactPage extends GetView<ContactController> {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Put the controller if not already present; normally handled by Bindings
    Get.put(ContactController());

    return Scaffold(
      appBar: AppBar(title: const Text('Contacts')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.contacts.isEmpty) {
          return const Center(child: Text('No contacts found'));
        }

        return ListView.separated(
          itemCount: controller.contacts.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            final user = controller.contacts[index];
            return ListTile(
              leading: Hero(
                tag: user.id,
                child: const AvatarWidget(),
              ),
              title: Text(user.displayName),
              subtitle: Text(user.phoneNumber),
              onTap: () {
                Get.to(() => UserDetailsPage(user: user));
              },
            );
          },
        );
      }),
    );
  }
}
