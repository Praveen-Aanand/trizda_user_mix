import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/product_model.dart';
import 'package:provider/provider.dart';

class FavList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final diaryEntries =
        Firestore.instance.collection('favorites').snapshots().map((snapshot) {
      return snapshot.documents
          .map((doc) => ProductEntry.fromDoc(doc))
          .toList();
    });
    return StreamProvider<List<ProductEntry>>(
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
    final diaryEntries = Provider.of<List<ProductEntry>>(context);
    return SizedBox(
      width: MediaQuery.of(context).size.width * 3 / 5,
      child: ListView(
        children: <Widget>[
          SizedBox(height: 40),
          if (diaryEntries != null)
            for (var diaryData in diaryEntries) Text(diaryData.title),
          if (diaryEntries == null) Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
