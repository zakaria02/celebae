import 'package:flutter/material.dart';

class MessagesView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MessagesStateView();
  }
}

class _MessagesStateView extends State<MessagesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Messages Page"),
      ),
    );
  }
}
