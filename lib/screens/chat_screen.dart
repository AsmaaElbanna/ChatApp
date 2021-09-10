import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final fireStore = FirebaseFirestore.instance;
  late User loggedUser;
  final auth = FirebaseAuth.instance;
  String messageText = '';
  final textFieldController = TextEditingController();

  void getCurrentUser() async {
    try {
      final user = auth.currentUser;
      if (user != null) {
        loggedUser = user;
        print('User is $user');
        print(loggedUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void messagesStream() async {
    await for (var snapshot in fireStore.collection('messages').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }
  // String[] splitMessage(String message){
  //
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: [
          IconButton(
              onPressed: () {
                 Navigator.pop(context);
                // messagesStream();
                //  print(Timestamp.now());
              },
              icon: Icon(Icons.logout))
        ],
        centerTitle: true,
        title: Text('⚡ Chat'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: fireStore.collection('messages').orderBy('time',descending: true).snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text(' ');
                } else {
                  final messagesFromFb = snapshot.data!.docs;
                  List<MessageBubble> messageBubbles = [];
                  for (var message in messagesFromFb) {
                    final messageText = message.get('text');
                    final messageSender = message.get('sender');
                    final currentUser = loggedUser.email;

                    if(currentUser == messageSender){

                    }
                    final messageWidget =
                        MessageBubble(messageText, messageSender,currentUser==messageSender);
                    messageBubbles.add(messageWidget);
                  }
                  return Expanded(
                    flex: 1,
                    child: ListView(
                      reverse: true,
                      children: messageBubbles,
                    ),
                  );
                }
              }),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  flex: 6,
                  child: TextField(
                    maxLines: 3,
                    minLines: 1,
                    controller: textFieldController,
                    onChanged: (value) {
                      messageText = value;
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Type here...'),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: IconButton(
                      onPressed: () {
                        fireStore.collection('messages').add(
                            {'sender': loggedUser.email, 'text': messageText , 'time': Timestamp.now()});
                        setState(() {
                          textFieldController.clear();
                        });
                      },
                      icon: Icon(
                        Icons.send,
                        size: 40,
                        color: Colors.lightBlueAccent,
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final messageText;
  final messageSender;
  final bool isMe;

  const MessageBubble(this.messageText, this.messageSender,this.isMe);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment:isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Text(
            '$messageSender',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          Material(
            elevation: 5,
            borderRadius: BorderRadius.only(
              topLeft: isMe ? Radius.circular(0) : Radius.circular(30),
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              topRight: isMe ? Radius.circular(30) :Radius.circular(0)
            ),
           //color: Colors.lightBlueAccent,
            color: isMe ? Colors.white : Colors.lightBlueAccent,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                '$messageText',
                style: TextStyle(fontSize: 15, color:isMe ? Colors.lightBlue : Colors.white,fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
