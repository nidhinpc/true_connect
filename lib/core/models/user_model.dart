class UserModel {
  final String id;
  final String displayName;
  final String phoneNumber;
  final String? photoUrl;

  UserModel({
    required this.id,
    required this.displayName,
    required this.phoneNumber,
    this.photoUrl,
  });

  factory UserModel.fromFlutterContact(dynamic contact) {
    return UserModel(
      id: contact.id ?? '',
      displayName: contact.displayName ?? '',
      phoneNumber: (contact.phones as List).isNotEmpty
          ? contact.phones.first.number
          : 'No phone number',
      photoUrl: null, // Placeholder for now
    );
  }
}
