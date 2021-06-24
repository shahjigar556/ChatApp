import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'redirect_screen.dart';
import 'package:flash_chat/utilities/alert.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

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
  bool showSpinner=false;
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
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
                  setState(() {
                    showSpinner=true;
                  });
                  UserCredential userCredential;
                  try {
                       userCredential = await _auth.createUserWithEmailAndPassword(
                        email: email,
                        password: password
                    );
                  }catch (e) {
                    setState(() {
                      showSpinner=false;
                    });
                    if (e.code == 'weak-password') {

                      Alert alert=Alert(context: context,title: 'Authentication error',content: 'The password provided is too weak.');
                      return alert.showAlert();
                    } else if (e.code == 'email-already-in-use') {
                      Alert alert=Alert(context: context,title: 'Authentication error',content: 'The account already exists for that email.');
                      return alert.showAlert();
                    }
                    Alert alert=Alert(context: context,title: 'Authentication error',content: 'Username not correct');
                    return alert.showAlert();

                  }
                  //print(userCredential);
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
                    setState(() {
                      showSpinner=false;
                    });
                    Navigator.pushNamed(context, ChatScreen.id);
                  }else{
                    Alert alert=Alert(context: context,title: 'Authentication',content: 'Email sent for verification');
                    alert.showAlert();
                    setState(() {
                      showSpinner=false;
                    });
                    Navigator.pushNamed(context, Redirect.id);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
