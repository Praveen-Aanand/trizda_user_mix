import 'dart:convert';
// import 'dart:html';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:html/parser.dart';
// import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffcache/ffcache.dart';
import 'package:trizda_user/elements/Comment.dart';
import '../models/route_argument.dart';
import '../models/shop_model.dart';
import '../elements/Heading.dart';

class ShopFetch extends StatelessWidget {
  final Data data;
  ShopFetch({this.data});

  Future _dataedu() async {
    final cache = await FFCache();
    await cache.init();
    // await cache.clear();
    final id = data.text.toString();
    // if (await cache.has('S-$id')) {
    if (false) {
      final rJsonData = await cache.getJSON('S-$id');
      print("from cookies 🍪");
      return rJsonData;
    } else {
      Map<String, dynamic> jsonData = null;
      final Firestore firestore = await Firestore.instance;
      await firestore
          .collection('shops')
          .document(id.toString())
          .get()
          .then((value) async {
        print(value.data["name"].toString());
        jsonData =
            await json.decode(json.encode(ShopEntry.fromDoc(value).toMap()));
        await cache.setJSON('S-$id', jsonData);
        print("from fire 🔥 ");
      }).catchError((onError) => print(onError.toString()));
      return await jsonData;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _dataedu(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return ShopView(snapshot.data);
          } else {
            return Center(child: Text("loading..."));
          }
        });
  }
}

class Chumma extends StatelessWidget {
  final data;
  Chumma(this.data);
  @override
  Widget build(BuildContext context) {
    return Container(child: Text(data[0]["image"]));
  }
}

class ShopView extends StatelessWidget {
  final dataEntries;
  ShopView(this.dataEntries);

  @override
  Widget build(BuildContext context) {
    final productEntries = dataEntries;
    final commentFlag = false;
    print(productEntries);
    final List<Widget> imageSliders = productEntries["images"]
        .map<Widget>((item) => Container(
              child: Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: CachedNetworkImage(
                      imageUrl: item,
                      fit: BoxFit.scaleDown,
                    )),
              ),
            ))
        .toList();
    // final List<TableRow> attributes = productEntries["attr"]
    //     .entries
    //     .map<TableRow>((item) => TableRow(children: [
    //           TableCell(child: Text(item.key)),
    //           TableCell(child: Text(item.value))
    //         ]))
    //     .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(productEntries["name"].toString().trim()),
      ),
      body: Container(
        child: productEntries == null
            ? Center(child: Text("loading"))
            : Container(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: CarouselSlider(
                          options: CarouselOptions(
                            height: 350,
                            aspectRatio: 3.0,
                            enlargeCenterPage: true,
                            enableInfiniteScroll: false,
                            initialPage: 0,
                            autoPlay: false,
                            disableCenter: true,
                            viewportFraction: 1.0,
                          ),
                          items: imageSliders,
                        ),
                      ),
                      if (productEntries != null)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                productEntries["name"].toString(),
                                style:
                                    Theme.of(context).textTheme.headline5.merge(
                                          TextStyle(
                                            fontWeight: FontWeight.w300,
                                            letterSpacing: 1.03,
                                          ),
                                        ),
                              ),

                              SmoothStarRating(
                                rating: double.parse(
                                    productEntries["ring"].toString()),
                                isReadOnly: true,
                                size: 20,
                                color: Colors.orangeAccent,
                                borderColor: Colors.orangeAccent,
                                filledIconData: Icons.star,
                                halfFilledIconData: Icons.star_half,
                                defaultIconData: Icons.star_border,
                                starCount: 5,
                                allowHalfRating: true,
                                spacing: 1.0,
                              ),
                              SizedBox(height: 15),
                              Headline(title: "Product details :"),
                              // Table(
                              //   children: attributes,
                              // ),
                              SizedBox(height: 15),
                              Headline(title: "Description :"),
                              SizedBox(height: 7),
                              Text(productEntries["dis"].toString().trim()),
                              SizedBox(height: 15),
                              Headline(title: "Your Review:"),
                              SizedBox(height: 7),
                              YourReview(id: productEntries["id"], type: "p"),
                              Headline(title: "Reviews :"),
                              SizedBox(height: 7),
                              Comment(id: productEntries["id"], type: "p"),
                              SizedBox(height: 15),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
