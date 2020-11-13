import 'package:flutter/material.dart';

class LikesView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LikesStateView();
  }
}

class _LikesStateView extends State<LikesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Like Page"),
      ),
    );
  }
}
