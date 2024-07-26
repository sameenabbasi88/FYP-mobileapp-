import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MessagingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> _getOrCreateChatId(String receiverEmail) async {
    final currentUserEmail = _auth.currentUser!.email!;
    List<String> participants = [currentUserEmail, receiverEmail];
    participants.sort(); // Ensure a unique chat ID

    final chatId = participants.join('_');

    final chatRef = _firestore.collection('chats').doc(chatId);
    final chatSnapshot = await chatRef.get();

    if (!chatSnapshot.exists) {
      await chatRef.set({
        'participants': participants,
      });
    }

    return chatId;
  }

  Future<void> sendMessage(String receiverEmail, String content) async {
    final currentUserEmail = _auth.currentUser!.email!;
    final chatId = await _getOrCreateChatId(receiverEmail);

    await _firestore.collection('chats').doc(chatId).collection('messages').add({
      'content': content,
      'senderEmail': currentUserEmail,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<Stream<QuerySnapshot>> getMessagesStream(String receiverEmail) async {
    final chatId = await _getOrCreateChatId(receiverEmail);
    return _firestore.collection('chats').doc(chatId).collection('messages').orderBy('timestamp', descending: true).snapshots();
  }
}
