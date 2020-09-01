import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:trizda_user/helpers/auth.dart';
import 'package:trizda_user/models/comments_model.dart';
import 'package:provider/provider.dart';
import 'package:trizda_user/pages/loginpage.dart';

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
        .collection('Rating')
        .where("t", isEqualTo: "p")
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
    print("$diaryEntries ethu");
    return Column(
      children: <Widget>[
        SizedBox(height: 30),
        if (diaryEntries != null)
          for (var diaryData in diaryEntries)
            Container(
              padding: EdgeInsets.all(7),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, spreadRadius: 1),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        diaryData.imgUrl.toString(),
                        width: 50,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        diaryData.name.toString(),
                        style: TextStyle(color: Colors.black87),
                      ),
                      SmoothStarRating(
                        rating: double.parse(diaryData.ring.toString()),
                        isReadOnly: true,
                        size: 10,
                        color: Colors.orangeAccent,
                        borderColor: Colors.orangeAccent,
                        filledIconData: Icons.star,
                        halfFilledIconData: Icons.star_half,
                        defaultIconData: Icons.star_border,
                        starCount: 5,
                        allowHalfRating: true,
                        spacing: 1.0,
                      ),
                      Text(
                        diaryData.body.toString(),
                        style: TextStyle(color: Colors.black54),
                      ),
                    ],
                  )
                ],
              ),
            ),
        if (diaryEntries == null) Center(child: CircularProgressIndicator()),
      ],
    );
  }
}

class YourReview extends StatefulWidget {
  @override
  final String id;
  final String type;
  YourReview(this.id, this.type);

  _YourReviewState createState() => _YourReviewState(id, type);
}

class _YourReviewState extends State<YourReview> {
  String id;
  String type;

  _YourReviewState(this.id, this.type);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
          stream: FirebaseAuth.instance.onAuthStateChanged,
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              return MyReview(data: snapshot.data, id: id, type: type);
            } else {
              return FlatButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                ),
                child: Text("login"),
              );
            }
          }),
    );
  }
}

class MyReview extends StatelessWidget {
  final data;
  MyReview({this.data, id, type});
  Future diaryEntries() async {
    Map<String, dynamic> documentData;
    final data = await Firestore.instance
        .collection('Rating')
        .where("uid", isEqualTo: "321A")
        .getDocuments()
        .then((event) async {
      if (event.documents.isNotEmpty) {
        documentData = await event.documents.first.data;
        print(documentData["n"]);
      }
      return documentData;
    }).catchError((e) => print("error fetching data: $e"));

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: diaryEntries(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data.toString());
          } else {
            return Center(child: Text("loading..."));
          }
        });
  }
}
