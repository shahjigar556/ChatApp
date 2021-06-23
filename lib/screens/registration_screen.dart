import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'redirect_screen.dart';
class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  FirebaseAuth _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool verified=false;
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.0),
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
                     userCredential = await _auth.createUserWithEmailAndPassword(
                      email: email,
                      password: password
                  );
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    print('The password provided is too weak.');
                  } else if (e.code == 'email-already-in-use') {
                    print('The account already exists for that email.');
                  }
                } catch (e) {
                  print(e);
                }
                print(userCredential);
                User user = _auth.currentUser;
                if (user!= null && !user.emailVerified) {
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
      ),
    );
  }
}
