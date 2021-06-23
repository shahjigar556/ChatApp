import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/utilities/constant.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'chat_screen.dart';
import 'redirect_screen.dart';
class LoginScreen extends StatefulWidget {
  static String id="login_screen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  String email;
  String password;
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool verified=true;
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal:50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                  'Flash Chat',
                  style:kWelcomeScreenHeading
              ),
            ),
            Container(
              margin: EdgeInsets.only(top:20),
              child: TextField(
                onChanged: (val){
                  setState(() {
                    email=val;
                  });
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Email Address'),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top:20),
              child: TextField(
                obscureText:true,
                onChanged: (val){
                  setState(() {
                    password=val;
                  });
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Password'),
              ),
            ),
            RoundedButton(
              text:'Register',
              onPressed: () async {
                UserCredential userCredential;
                try {
                      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email,
                      password: password
                  );
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    print('No user found for that email.');
                  } else if (e.code == 'wrong-password') {
                    print('Wrong password provided for that user.');
                  }
                }
                //print(userCredential);
                User user=_auth.currentUser;
                if(user!=null && !user.emailVerified){
                  setState(() {
                    verified=false;
                  });
                  await user.sendEmailVerification();
                }
                if(user.emailVerified){
                  setState(() {
                    verified=true;
                  });
                }
                if(verified){
                  Navigator.pushNamed(context, ChatScreen.id);
                }else{
                  Navigator.pushNamed(context, Redirect.id);
                }

              },
            )
          ],
        ),
      )
    );
  }
}
