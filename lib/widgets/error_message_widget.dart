import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  String text;
  ErrorMessage({@required this.text});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.redAccent,
        fontSize: 18,
      ),
      textAlign: TextAlign.start,
    );
  }
}
