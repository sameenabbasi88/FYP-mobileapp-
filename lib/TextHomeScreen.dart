import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'MessagingScreen.dart';

class InboxScreen extends StatefulWidget {
  @override
  _InboxScreenState createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? currentUserEmail;

  @override
  void initState() {
    super.initState();
    _initializeUser();
  }

  void _initializeUser() async {
    final user = _auth.currentUser;
    if (user != null) {
      setState(() {
        currentUserEmail = user.email;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (currentUserEmail == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Inbox'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Inbox'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('chats')
            .where('participants', arrayContains: currentUserEmail)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final chats = snapshot.data!.docs;
          List<Widget> chatWidgets = [];
          for (var chat in chats) {
            final chatData = chat.data() as Map<String, dynamic>;
            final participants = List<String>.from(chatData['participants']);
            final otherParticipant = participants.firstWhere((email) => email != currentUserEmail);

            chatWidgets.add(ListTile(
              title: Text(otherParticipant),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MessagingScreen(receiverEmail: otherParticipant),
                  ),
                );
              },
            ));
          }

          return ListView(
            children: chatWidgets,
          );
        },
      ),
    );
  }
}
