import 'package:flutter/material.dart';

class Headline extends StatelessWidget {
  final String title;
  Headline({this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline5.merge(
              TextStyle(fontWeight: FontWeight.w500, color: Colors.black87),
            ),
      ),
    );
  }
}
