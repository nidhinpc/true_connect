import 'package:get/get.dart';
import 'package:true_connect/core/models/user_model.dart';
import 'package:true_connect/core/services/contact_service.dart';

class ContactController extends GetxController {
  var contacts = <UserModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchContacts();
  }

  Future<void> fetchContacts() async {
    try {
      isLoading(true);
      var fetchedContacts = await ContactService.fetchContacts();
      contacts.assignAll(fetchedContacts);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch contacts: $e');
    } finally {
      isLoading(false);
    }
  }
}
