import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class CommentsEntry {
  final String body;
  final String name;
  final String uid;
  final String documentId;
  final int ring;
  final String imgUrl;

  CommentsEntry(
      {this.body,
      this.name,
      this.uid,
      this.documentId,
      this.ring,
      this.imgUrl});

  // toJson(doc) {
  //   return {
  //     "data": {
  //       cato: doc.data['cato'],
  //       title: doc.data['title'],
  //       image: doc.data['image'],
  //       price: doc.data['price'],
  //       s_price: doc.data["s_price"],
  //       s_dis: doc.data["s_dis"],
  //       // documentId: doc.documentID,
  //     }
  //   };
  // }

  Map<String, dynamic> toMap() {
    return {
      'id': documentId,
      'body': body,
      'name': name,
      'uid': uid,
      "ring": ring,
      "imgUrl": imgUrl,
    };
  }

  static CommentsEntry fromDoc(DocumentSnapshot doc) {
    if (doc == null) return null;

    return CommentsEntry(
        body: doc.data['b'],
        name: doc.data['n'],
        documentId: doc.documentID,
        uid: doc.data['uid'],
        imgUrl: doc.data["iu"],
        ring: doc.data["r"]);
  }

  @override
  String toString() => 'DiaryEntry emoji: $name, title: $body, body: $ring';

  @override
  int get hashCode => name.hashCode ^ name.hashCode ^ ring.hashCode;
}
