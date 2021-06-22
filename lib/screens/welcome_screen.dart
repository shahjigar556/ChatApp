import 'package:flutter/material.dart';
import 'package:flash_chat/utilities/constant.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
class WelcomeScreen extends StatefulWidget {
  static String id='welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
        padding:  EdgeInsets.symmetric(horizontal: 120.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Flash Chat',
              style:kWelcomeScreenHeading
            ),
            RoundedButton(
              text:'Login',
              onPressed: (){
                 Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
           RoundedButton(
             text:'Register',
             onPressed: (){
                 Navigator.pushNamed(context,RegistrationScreen.id);
             },
           )
          ],
        ),
      )
    );
  }
}
