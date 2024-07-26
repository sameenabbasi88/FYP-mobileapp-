import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NewFoundPostListener {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  void startListening() {
    _firestore.collection('posts').snapshots().listen((snapshot) {
      for (var docChange in snapshot.docChanges) {
        if (docChange.type == DocumentChangeType.added) {
          _checkForMatchingPosts(docChange.doc);
        }
      }
    });
  }

  void _checkForMatchingPosts(DocumentSnapshot postDoc) async {
    final post = postDoc.data() as Map<String, dynamic>;
    if (post['status'] == 'found') return;

    final city = post['city'];

    final matchingPostsQuery = await _firestore.collection('posts')
        .where('status', isEqualTo: 'found')
        .where('city', isEqualTo: city)
        .get();

    if (matchingPostsQuery.docs.isNotEmpty) {
      final userTokens = <String>{};
      for (var doc in matchingPostsQuery.docs) {
        if (doc.data()['userToken'] != null) {
          userTokens.add(doc.data()['userToken']);
        }
      }

      if (userTokens.isNotEmpty) {
        await _sendNotification(userTokens.toList());
      }
    }
  }

  Future<void> _sendNotification(List<String> tokens) async {
    for (String token in tokens) {
      await _messaging.sendMessage(
        to: token,
        data: {
          'title': 'Matching Found Posts Available',
          'body': '/',
        },
      );
    }
  }
}
