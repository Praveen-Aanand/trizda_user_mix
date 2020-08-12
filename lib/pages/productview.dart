import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffcache/ffcache.dart';
import 'package:provider/provider.dart';
import '../models/route_argument.dart';
import '../models/product_model.dart';

final imgProdList = [
  {
    "img":
        "https://rukminim1.flixcart.com/flap/844/140/image/0a6a0670f671adae.jpg?q=50",
    "link": null
  },
  {
    "img":
        "https://rukminim1.flixcart.com/flap/844/140/image/16664a8c7406a264.jpg?q=50",
    "link": null
  },
  {
    "img":
        "https://rukminim1.flixcart.com/flap/844/140/image/bd6859fa16d745e6.jpg?q=50",
    "link": null
  }
];

class ProductFetch extends StatelessWidget {
  final Data data;
  ProductFetch({this.data});
  final cache = FFCache();

  Future<Firestore> getprodData() async {
    final Firestore firestore = await Firestore.instance;
    await firestore
        .collection('products')
        .document('3h3N5JprkMNv0W2MTK4t')
        .get()
        .then((value) async {
      final jsonData = json.encode(value);
      await cache.setJSON('P-3h3N5JprkMNv0W2MTK4t', jsonData.toString());
      print(jsonData);
      // // await cache.setString("P-3h3N5JprkMNv0W2MTK4t", value.data.toString());
      // print("hi from fire${await cache.get String('P-3h3N5JprkMNv0W2MTK4t')}");
      return value;
    }).catchError((onError) => print(onError));
  }

  // getprodData() async {
  //   await cache.init();
  //   // await cache.setString("hi", "hello");
  //   // print("f4kf${await cache.getString("P-3h3N5JprkMNv0W2MTK4t")}");
  //   if (await cache.has("P-3h3N5JprkMNv0W2MTK4t")) {
  //     final value = await cache.getString("P-3h3N5JprkMNv0W2MTK4t");
  //     // final js = json.decode(value);
  //     print("hi from catch $value");
  //     // await cache.clear();
  //     return value;
  //   } else {
  //     Firestore.instance
  //         .collection('products')
  //         .document('3h3N5JprkMNv0W2MTK4t')
  //         .get()
  //         .then((value) async {
  //       // final jsonData = json.decode('''$value''');
  //       // await cache.setJSON('json', jsonData);
  //       await cache.setString("P-3h3N5JprkMNv0W2MTK4t", value.data.toString());
  //       print("hi from fire${await cache.getString('P-3h3N5JprkMNv0W2MTK4t')}");
  //       return await cache.getString("P-3h3N5JprkMNv0W2MTK4t");
  //     }).catchError((onError) => print(onError));
  //   }
  // }

  //  Future<void> initState() async {
  //     var diaryEntries = await getprodData();
  //   print(diaryEntries);
  //  }
  @override
  Widget build(BuildContext context) {
    // print("jfefhu${getprodData()}");
    // var diaryEntries = getprodData();
    // print("here$diaryEntries");
    return FutureBuilder<Firestore>(
      future: getprodData(),
      builder: (BuildContext context, AsyncSnapshot<Firestore> snapshot) {
        return snapshot.hasData ? ProductView(snapshot.data) : Container();
      },
    );
    // return new StreamBuilder(
    //   stream: Firestore.instance
    //       .collection('products')
    //       .document('3h3N5JprkMNv0W2MTK4t')
    //       .snapshots(),
    //   builder: (context, snapshot) {
    //     if (!snapshot.hasData) {

    //       return new Text("Loading");
    //     }
    //     var diaryEntries = snapshot.data.data;

    //     // print(snapshot);

    //     return new ProductView(diaryEntries);
    //   },
    // );
  }
}

class ProductView extends StatelessWidget {
  final diaryEntries;
  ProductView(this.diaryEntries);

  @override
  Widget build(BuildContext context) {
    final productEntries = diaryEntries;

    // print(productEntries);
    return Scaffold(
      appBar: AppBar(
        title: Text("hi"),
      ),
      body: Container(
        child: productEntries == null
            ? Center(child: Text("loading"))
            : Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.network(
                        productEntries["image"],
                        width: 300,
                      ),
                      Text(
                        productEntries["title"],
                      ),
                      Container(
                        child: CarouselSlider(
                          options: CarouselOptions(
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
                        Text(
                          productEntries["title"],
                          style: Theme.of(context).textTheme.headline5.merge(
                                TextStyle(
                                  letterSpacing: 1.3,
                                ),
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

// class _ProductViewState extends State<ProductView> {
//   RouteArgument routeArgument;

//   _ProductViewState(this.routeArgument);

//   @override

// }

final List<Widget> imageSliders = imgProdList
    .map(
      (item) => Container(
        child: Container(
          margin: EdgeInsets.all(5.0),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: CachedNetworkImage(
              imageUrl: item["img"],
              height: 130,
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      ),
    )
    .toList();
