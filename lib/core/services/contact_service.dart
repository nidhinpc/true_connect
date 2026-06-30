import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:true_connect/core/models/user_model.dart';

class ContactService {
  static Future<List<UserModel>> fetchContacts() async {
    // Request permission using permission_handler for more robust control
    final PermissionStatus status = await Permission.contacts.request();

    if (status.isGranted) {
      // Fetch contacts with properties (phones, emails, etc.)
      final List<Contact> contacts =
          await FlutterContacts.getContacts(withProperties: true);

      return contacts.map((c) => UserModel.fromFlutterContact(c)).toList();
    } else {
      // Handle the case where permission is denied
      print('Contact permission denied');
      return [];
    }
  }
}
