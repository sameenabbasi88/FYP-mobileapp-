import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'MessagingService.dart';

class MessagingScreen extends StatefulWidget {
  final String receiverEmail;

  MessagingScreen({required this.receiverEmail});

  @override
  _MessagingScreenState createState() => _MessagingScreenState();
}

class _MessagingScreenState extends State<MessagingScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final MessagingService _messagingService = MessagingService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? currentUserEmail;
  String? chatId;
  late Stream<QuerySnapshot> messageStream;

  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  void _initializeChat() async {
    final user = _auth.currentUser;
    if (user != null) {
      currentUserEmail = user.email;
      messageStream = await _messagingService.getMessagesStream(widget.receiverEmail);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (currentUserEmail == null) {
      return Scaffold(
        backgroundColor: Color(0xffFFC55A),
        appBar: AppBar(
          backgroundColor: Color(0xff5DEBD7),
          title: Text('Chat'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Color(0xffFFC55A),
      appBar: AppBar(
        backgroundColor: Color(0xff5DEBD7),
        title: Text('Chat'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          StreamBuilder<QuerySnapshot>(
            stream: messageStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.orange,
                    backgroundColor: Colors.grey,
                  ),
                );
              }
              final messages = snapshot.data!.docs;
              List<Widget> messageWidgets = [];
              for (var message in messages) {
                final messageText = message['content'];
                final messageSender = message['senderEmail'];
                final messageWidget = Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: messageSender == currentUserEmail ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$messageSender',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.black54,
                        ),
                      ),
                      Material(
                        elevation: 8.0,
                        borderRadius: messageSender == currentUserEmail
                            ? BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            bottomLeft: Radius.circular(30.0),
                            bottomRight: Radius.circular(30.0))
                            : BorderRadius.only(
                            topRight: Radius.circular(30.0),
                            bottomLeft: Radius.circular(30.0),
                            bottomRight: Radius.circular(30.0)),
                        color: messageSender == currentUserEmail ? Colors.grey.shade600 : Colors.teal,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
                          child: Text(
                            '$messageText',
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
                messageWidgets.add(messageWidget);
              }
              return Expanded(
                child: ListView(
                  reverse: true,
                  controller: _scrollController,
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                  children: messageWidgets,
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                    ),
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    final messageContent = _messageController.text.trim();
                    if (messageContent.isNotEmpty) {
                      _messagingService.sendMessage(widget.receiverEmail, messageContent);
                      _messageController.clear();
                      _scrollController.animateTo(
                        _scrollController.position.minScrollExtent,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
