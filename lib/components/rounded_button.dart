import 'package:flash_chat/utilities/constant.dart';
import 'package:flutter/material.dart';
class RoundedButton extends StatelessWidget {
  RoundedButton({@required this.text,@required this.onPressed});
  final String text;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color:Colors.blueAccent
      ),
      margin: EdgeInsets.fromLTRB(0, 20.0, 0, 0),
      child: TextButton(
          onPressed: onPressed,
          child:Text(
            text,
            style:kButtonTextStyle,
          )
      ),
    );
  }
}
