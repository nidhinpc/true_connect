import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactService {
  static Future<List<Contact>> fetchContacts() async {
    // Request permission using permission_handler for more robust control
    final PermissionStatus status = await Permission.contacts.request();

    if (status.isGranted) {
      // Fetch contacts with properties (phones, emails, etc.)
      return await FlutterContacts.getContacts(
          withProperties: true, withPhoto: true);
    } else {
      // Handle the case where permission is denied
      print('Contact permission denied');
      return [];
    }
  }
}
