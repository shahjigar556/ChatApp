import 'package:flash_chat/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/rounded_button.dart';

class Redirect extends StatelessWidget {
  @override
  static String id='redirect';
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: Container(
          child:Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                    child: Text(
                        'Verfiy Your Email Please',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0
                      ),
                    )
                ),
                RoundedButton(
                  text:'Sign In',
                  onPressed: (){
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                ),
              ],
            ),
          )
        ),
      )
    );
  }
}
