import 'package:flutter/material.dart';

class TitleDefult extends StatelessWidget {
  final String title;
  const TitleDefult(this.title);
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          fontSize: 26.0, fontWeight: FontWeight.bold, fontFamily: 'Oswald'),
    );
  }
}
