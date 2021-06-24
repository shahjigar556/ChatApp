import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  FirebaseAuth _auth = FirebaseAuth.instance;
  String messageText;
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flash Chat'),
          backgroundColor: Colors.lightBlueAccent,
          actions: [
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              },
            )
          ],
        ),
        body: SafeArea(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Expanded(
                    child:TextField(
                      onChanged: (val){
                        messageText=val;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter a Message'
                      ),
                    )
                  ),
                  TextButton(
                    onPressed: () {

                    },
                    child:Text(
                      'Send'
                    )
                  )
                ],
              )
            ],
          ),
        ));
  }
}
