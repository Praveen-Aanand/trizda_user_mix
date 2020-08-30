import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trizda_user/models/comments_model.dart';
import 'package:provider/provider.dart';

class Comment extends StatefulWidget {
  final String id;
  final String type;
  Comment({this.id, this.type});

  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  @override
  Widget build(BuildContext context) {
    final diaryEntries = Firestore.instance
        .collection("${widget.type}")
        .document("${widget.id}")
        .collection("Rating")
        .snapshots()
        .map((snapshot) {
      return snapshot.documents
          .map((doc) => CommentsEntry.fromDoc(doc))
          .toList();
    });
    return StreamProvider<List<CommentsEntry>>(
      create: (_) => diaryEntries,
      child: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final diaryEntries = Provider.of<List<CommentsEntry>>(context);
    print(diaryEntries);
    return Column(
      children: <Widget>[
        SizedBox(height: 40),
        if (diaryEntries != null)
          for (var diaryData in diaryEntries) Text(diaryData.name),
        if (diaryEntries == null) Center(child: CircularProgressIndicator()),
      ],
    );
  }
}
