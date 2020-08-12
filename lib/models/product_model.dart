import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class ProductEntry {
  final String cato;
  final String title;
  final String image;
  final String documentId;
  final String price;
  final String s_price;
  final String s_dis;

  ProductEntry(
      {this.cato,
      this.title,
      this.image,
      this.documentId,
      this.price,
      this.s_dis,
      this.s_price});

  Map<String, dynamic> toMap() {
    return {
      'cato': cato,
      'title': title,
      'image': image,
      "price": price,
      "s_price": s_price,
      "s_dis": s_dis,
    };
  }

  static ProductEntry fromDoc(DocumentSnapshot doc) {
    if (doc == null) return null;

    return ProductEntry(
      cato: doc.data['cato'],
      title: doc.data['title'],
      image: doc.data['image'],
      price: doc.data['price'],
      s_price: doc.data["s_price"],
      s_dis: doc.data["s_dis"],
      documentId: doc.documentID,
    );
  }

  @override
  String toString() => 'DiaryEntry emoji: $cato, title: $title, body: $image';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ProductEntry &&
        o.cato == cato &&
        o.title == title &&
        o.image == image;
  }

  @override
  int get hashCode => cato.hashCode ^ title.hashCode ^ image.hashCode;
}
