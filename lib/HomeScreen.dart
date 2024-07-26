import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'ButtonsLostFound.dart';
import 'MessagingScreen.dart';
import 'NewPostListener.dart';
import 'TextHomeScreen.dart';
import 'mydrawerlist.dart';
import 'myheaderdrawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getToken();
    NewFoundPostListener().startListening();
  }
  int _currentIndex = 0;
  String _searchCity = '';
  Future<void> saveTokenToDatabase(String token) async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;

    await FirebaseFirestore.instance.collection('users').add({
      'tokens': token,
    });
  }

  void getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    saveTokenToDatabase(token!);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFC55A),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(85),
        child: AppBar(
          iconTheme: IconThemeData(color: Colors.black, size: 35),
          backgroundColor: Color(0xff5DEBD7),
          title: Container(
            margin: EdgeInsets.only(top: 12),
            width: 240,
            height: 44,
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchCity = value;
                });
              },
              decoration: InputDecoration(

                hintText: 'Search by City',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 16,),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                // Navigate to the message screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InboxScreen()),
                );
              },
              icon: Icon(
                Icons.message_rounded,
                color: Colors.black,
                size: 33,
              ),
            ),
          ],
          centerTitle: true,
        ),
      ),
      drawer: Drawer(
        backgroundColor: Color(0xffFFC55A),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Your drawer content
              myheaderdrawer(),
              mydrawerlist(),
            ],
          ),
        ),
      ),
      body: _buildPostsFeed(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        iconSize: 40,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.find_in_page),
            label: 'Lost Section',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => addImages()),
                );
              },
              child: Icon(Icons.add),
            ),
            label:'Add Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.find_replace,
            ),
            label: 'Found Section',
          ),
        ],
        backgroundColor: Color(0xff5DEBD7),
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.black,
        unselectedFontSize: 17,
        selectedFontSize: 18,
      ),
    );
  }

  Widget _buildPostsFeed() {
    String status = _currentIndex == 0 ? 'lost' : 'found';
    CollectionReference postsRef = FirebaseFirestore.instance.collection('posts');

    Query query = postsRef.where('status', isEqualTo: status);

    // Conditionally adjust the Firestore query based on search city
    if (_searchCity.isNotEmpty) {
      query = query.where('city', isGreaterThanOrEqualTo: _searchCity);
      query = query.where('city', isLessThan: _searchCity + 'z');
    }

    return StreamBuilder<QuerySnapshot>(
      stream: query.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text('No posts available.'),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var post = snapshot.data!.docs[index];
            // Assuming each post document has fields 'images', 'description', 'category', and 'city'
            // Adjust this part according to your Firestore structure
            List<String> images = List<String>.from(post['images']);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    post['description'],
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 200, // Adjust the height as needed
                  child: PageView.builder(
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      return Image.network(
                        images[index],
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
                ListTile(
                  title: Text('Category: ${post['category']}',style: TextStyle(fontFamily: 'MainFont'),),
                  subtitle: Text('City: ${post['city']}',style: TextStyle(fontFamily: 'MainFont')),
                  onTap: () {
                    // Navigate to a detailed view of the post
                  },
                ),
                Divider(),
                // Add a button to send a message
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Implement logic to send a message to the post owner
                      // You can access the post owner's email from the post document
                      final currentUser = FirebaseAuth.instance.currentUser;
                      if (currentUser != null && post['email'] != currentUser.email) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MessagingScreen(receiverEmail: post['email']),
                          ),
                        );
                      }
                    },
                    child:
                    Text('Send Message to Post Owner (${post['email']})',),
                  ),
                ),
                Divider(),
              ],
            );
          },
        );
      },
    );
  }
}

