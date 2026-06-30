import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:true_connect/core/models/chat_models.dart';
import 'package:true_connect/core/models/user_model.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get currentUserId => _auth.currentUser?.uid;

  // Sync user from local contacts to Firestore
  Future<void> syncUser(UserModel user) async {
    await _firestore.collection('users').doc(user.id).set({
      'name': user.displayName,
      'phoneNumber': user.phoneNumber,
      'id': user.id,
      'photoUrl': user.photoUrl,
    }, SetOptions(merge: true));
  }

  // Get or Create a chat room between two users
  Future<String> getOrCreateChat(String otherUserId) async {
    final String myId = currentUserId ?? 'test_user_id'; // Placeholder for test
    
    // Create a deterministic ID for 1-on-1 chats
    final List<String> ids = [myId, otherUserId];
    ids.sort();
    final String chatId = ids.join('_');

    final doc = await _firestore.collection('chats').doc(chatId).get();
    if (!doc.exists) {
      await _firestore.collection('chats').doc(chatId).set({
        'participants': ids,
        'lastMessage': '',
        'lastMessageTime': FieldValue.serverTimestamp(),
      });
    }
    return chatId;
  }

  // Send a message
  Future<void> sendMessage(String chatId, String text) async {
    final String myId = currentUserId ?? 'test_user_id';
    
    final messageData = {
      'senderId': myId,
      'text': text,
      'timestamp': FieldValue.serverTimestamp(),
    };

    await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add(messageData);

    // Update chat room last message
    await _firestore.collection('chats').doc(chatId).update({
      'lastMessage': text,
      'lastMessageTime': FieldValue.serverTimestamp(),
    });
  }

  // Get message stream
  Stream<List<ChatMessage>> getMessages(String chatId) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => ChatMessage.fromFirestore(doc)).toList());
  }

  // Get conversations stream
  Stream<List<ChatRoom>> getConversations() {
    final String myId = currentUserId ?? 'test_user_id';
    return _firestore
        .collection('chats')
        .where('participants', arrayContains: myId)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => ChatRoom.fromFirestore(doc)).toList());
  }
}
