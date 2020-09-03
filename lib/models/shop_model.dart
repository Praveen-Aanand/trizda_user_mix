import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShopEntry {
  final List<dynamic> cato;
  final String name;
  final String documentId;
  final String dis;
  final double ring;
  final List<dynamic> images;
  final bool verified;
  // final GeoPoint loc;
  final String address;
  ShopEntry({
    this.cato,
    this.name,
    this.documentId,
    this.dis,
    this.ring,
    this.images,
    this.verified,
    // this.loc,
    this.address,
  });

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
      'cato': cato,
      'name': name,
      'images': images,
      // 'loc': loc,
      'add': address,
      'verified': verified,
      "dis": dis,
      "ring": ring
    };
  }

  static ShopEntry fromDoc(DocumentSnapshot doc) {
    if (doc == null) return null;

    return ShopEntry(
      cato: doc.data['cato'],
      name: doc.data['name'],
      dis: doc.data["dis"],
      // loc: doc.data["loc"],
      address: doc.data["add"],
      documentId: doc.documentID,
      images: doc.data["images"],
      ring: doc.data["ring"],
      verified: doc.data["verified"],
    );
  }

  @override
  String toString() => 'DiaryEntry emoji: $cato, title: $name, body: $dis';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ShopEntry && o.cato == cato && o.name == name;
  }

  @override
  int get hashCode => cato.hashCode ^ name.hashCode ^ ring.hashCode;
}
