import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/welcome_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/login_screen.dart';
import 'screens/chat_screen.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:WelcomeScreen(),
      routes:{
     ChatScreen.id: (BuildContext context) => ChatScreen(),
     LoginScreen.id: (BuildContext context) => LoginScreen(),
     RegistrationScreen.id: (BuildContext context) => RegistrationScreen(),
    }
    );
  }
}



