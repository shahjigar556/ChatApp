import 'package:flutter/material.dart';
class Alert{
  Alert({@required this.context,this.title,this.content});
  final BuildContext context;
  final String title;
  final String content;
  void showAlert(){
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title:  Text(title),
        content:  Text(content),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}