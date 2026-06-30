import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  final String id;
  final String senderId;
  final String text;
  final Timestamp timestamp;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.text,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'text': text,
      'timestamp': timestamp,
    };
  }

  factory ChatMessage.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;
    return ChatMessage(
      id: doc.id,
      senderId: data?['senderId'] ?? '',
      text: data?['text'] ?? '',
      timestamp: data?['timestamp'] is Timestamp 
          ? data!['timestamp'] as Timestamp 
          : Timestamp.now(),
    );
  }
}

class ChatRoom {
  final String id;
  final List<String> participants;
  final String lastMessage;
  final Timestamp lastMessageTime;

  ChatRoom({
    required this.id,
    required this.participants,
    required this.lastMessage,
    required this.lastMessageTime,
  });

  factory ChatRoom.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;
    return ChatRoom(
      id: doc.id,
      participants: List<String>.from(data?['participants'] ?? []),
      lastMessage: data?['lastMessage'] ?? '',
      lastMessageTime: data?['lastMessageTime'] is Timestamp 
          ? data!['lastMessageTime'] as Timestamp 
          : Timestamp.now(),
    );
  }
}
