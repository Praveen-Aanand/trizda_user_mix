import 'dart:convert';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffcache/ffcache.dart';
import 'package:provider/provider.dart';
import '../models/route_argument.dart';
import '../models/product_model.dart';

class ProductFetch extends StatelessWidget {
  final Data data;
  ProductFetch({this.data});

  Future _dataedu() async {
    final cache = await FFCache();
    await cache.init();
    // await cache.clear();

    final id = data.text.toString();

    // if (await cache.has('P-$id')) {
    if (false) {
      final rJsonData = await cache.getJSON('P-$id');
      print("from cookies 🍪");
      return rJsonData;
    } else {
      List<dynamic> jsonData = null;
      final Firestore firestore = await Firestore.instance;
      await firestore
          .collection('products')
          .document(id.toString())
          .get()
          .then((value) async {
        // getIMGurl() async {
        //   var imgList = [];
        //   final StorageReference storageRef =
        //       FirebaseStorage.instance.ref().child("product_pics/$id/images");

        //   for (var i = 0; i <= int.parse(value.data["numimg"]); i++) {
        //     var imgRef = storageRef.child("/img${i}_512x512.jpg");
        //     String url = (await imgRef.getDownloadURL()).toString();

        //     print(url);
        //     await imgList.add(url);
        //     print(imgList);
        //   }
        //   return imgList;
        //   // String url = (await storageRef.getDownloadURL()).toString();
        // }

        // final images = [];
        // for (var i = 0; i <= value.data["images"].length; i++) {
        //   await images.add({"img": "${value.data["images"][i]}"});
        // }
        print(value.data["title"].toString());
        jsonData = await json.decode('''[
            {"id":"$id",
            "title":"${value.data["title"].toString().trim()}",
            "image": "${value.data["images"][0]}",
            "cato":"${value.data["cato"]}",
            "price":"${value.data["price"]}",
            "s_price":"${value.data["s_price"]}",
            "s_dis":"${value.data["s_dis"]}" ,
            "numimg":"${value.data["numimg"]}"
          }
          ]''');
        await cache.setJSON('P-$id', jsonData);
        // final rJsonData = await cache.getJSON('P-$id');
        print("from fire 🔥 ");
      }).catchError((onError) => print(onError.toString()));
      return await jsonData;
    }
  }

  // getprodData() async {
  //   // final Firestore firestore = await Firestore.instance;
  //   // await firestore
  //   //     .collection('products')
  //   //     .document('3h3N5JprkMNv0W2MTK4t')
  //   //     .get()
  //   //     .then((value) async {
  //   //   // final jsonData = json.encode(ProductEntry.fromDoc(value));
  //   //   // await cache.setJSON('P-3h3N5JprkMNv0W2MTK4t', ProductEntry.toJson(value));
  //   //   // print(await cache.getJSON('P-3h3N5JprkMNv0W2MTK4t'));
  //   //   final jsonData = json.decode('''[{"id":1,"data":"string data","nested":{"id":"hello","flutter":"rocks"}}]''');
  //   // await cache.setJSON('json', jsonData);
  //   //   print("${value.data["title"].toString()}");
  //   //   // // await cache.setString("P-3h3N5JprkMNv0W2MTK4t", value.data.toString());
  //   //   // print("hi from fire${await cache.get String('P-3h3N5JprkMNv0W2MTK4t')}");
  //   //   return value;
  //   // }).catchError((onError) => print(onError));
  //   final f = "eide";
  //   final jsonData = json.decode(
  //       '''[{"id":"$f","title":"","image":"https://firebasestorage.googleapis.com/v0/b/trizdabeta.appspot.com/o/product_pics%2F3h3N5JprkMNv0W2MTK4t%2Fimages%2Fimg0_512x512.jpg?alt=media&token=7acf12c9-9498-4fdb-b0f2-91dd1e859682",nested":{"id":"hello","flutter":"rocks"}}]''');
  //   await cache.setJSON('json', jsonData);
  //   final rJsonData = await cache.getJSON('json');
  //   // var temp = await json.encode(rJsonData);
  //   print(rJsonData[0]["id"]);
  //   return rJsonData;
  // }

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
    return FutureBuilder(
        future: _dataedu(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return ProductView(snapshot.data);
          } else {
            return ProductView(snapshot.data);
          }
        });
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

class Chumma extends StatelessWidget {
  final data;
  Chumma(this.data);
  @override
  Widget build(BuildContext context) {
    return Container(child: Text(data[0]["image"]));
  }
}

class ProductView extends StatelessWidget {
  final diaryEntries;
  ProductView(this.diaryEntries);

  @override
  Widget build(BuildContext context) {
    final productEntries = diaryEntries[0];
    print(productEntries);
    // getIMGurl() async {
    //   final StorageReference storageRef = FirebaseStorage.instance
    //       .ref()
    //       .child("product_pics/${productEntries["id"]}/images");

    //   for (var i = 0; i <= int.parse(productEntries["numimg"]); i++) {
    //     var imgRef = storageRef.child("/img${i}_512x512.jpg");
    //     String url = (await imgRef.getDownloadURL()).toString();

    //     print(url);
    //     await imgList.add({"img": url});
    //     print(imgList);
    //   }

    //   // String url = (await storageRef.getDownloadURL()).toString();
    // }

    // getIMGurl();
    final imgProdList = [
      {
        "img":
            "https://firebasestorage.googleapis.com/v0/b/trizdabeta.appspot.com/o/product_pics%2F3h3N5JprkMNv0W2MTK4t%2Fimages%2Fimg0_512x512.jpg?alt=media&token=7acf12c9-9498-4fdb-b0f2-91dd1e859682",
        "link": null
      },
      {
        "img":
            "https://firebasestorage.googleapis.com/v0/b/trizdabeta.appspot.com/o/product_pics%2F3h3N5JprkMNv0W2MTK4t%2Fimages%2Fimg1_512x512.jpg?alt=media&token=4812d9d1-89ff-4e63-9cbf-c5636c5a2ac2",
        "link": null
      },
      {
        "img":
            "https://firebasestorage.googleapis.com/v0/b/trizdabeta.appspot.com/o/product_pics%2F3h3N5JprkMNv0W2MTK4t%2Fimages%2Fimg2_512x512.jpg?alt=media&token=6f9a2b27-ed01-43c7-8dd6-21d527c07903",
        "link": null
      }
    ];
    // final List<Widget> imageSliders = productEntries["image"]
    //     .map(
    //       (item) => Container(
    //         child: Container(
    //           margin: EdgeInsets.all(5.0),
    //           child: ClipRRect(
    //             borderRadius: BorderRadius.all(Radius.circular(5.0)),
    //             child: CachedNetworkImage(
    //               imageUrl: item.toString(),
    //               height: 130,
    //               fit: BoxFit.fitHeight,
    //             ),
    //           ),
    //         ),
    //       ),
    //     )
    //     .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(productEntries["title"].toString().trim()),
      ),
      body: Container(
        child: productEntries == null
            ? Center(child: Text("loading"))
            : Container(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Container(
                      //   child: CarouselSlider(
                      //     options: CarouselOptions(
                      //       aspectRatio: 1.0,
                      //       // enlargeCenterPage: true,
                      //       enableInfiniteScroll: false,
                      //       initialPage: 0,
                      //       autoPlay: false,
                      //       disableCenter: true,
                      //       viewportFraction: 1.0,
                      //     ),
                      //     items: imageSliders,
                      //   ),
                      // ),
                      if (productEntries != null)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                productEntries["title"].toString(),
                                style:
                                    Theme.of(context).textTheme.headline5.merge(
                                          TextStyle(
                                            fontWeight: FontWeight.w300,
                                            letterSpacing: 1.03,
                                          ),
                                        ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "₹${productEntries["s_price"].toString().trim()}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        .merge(
                                          TextStyle(
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 1.03,
                                            fontSize: 34,
                                          ),
                                        ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  if (productEntries["s_price"] != null)
                                    Text(
                                      "₹${productEntries["price"].toString().trim()}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5
                                          .merge(
                                            TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 1.03,
                                              fontSize: 18,
                                            ),
                                          ),
                                    ),
                                ],
                              ),
                              SmoothStarRating(
                                rating: 4,
                                isReadOnly: false,
                                size: 20,
                                color: Colors.orangeAccent,
                                borderColor: Colors.orangeAccent,
                                filledIconData: Icons.star,
                                halfFilledIconData: Icons.star_half,
                                defaultIconData: Icons.star_border,
                                starCount: 5,
                                allowHalfRating: true,
                                spacing: 1.0,
                                // onRated: (value) {
                                //   print("rating value -> $value");
                                //   // print("rating value dd -> ${value.truncate()}");
                                // },
                              ),
                              Image.network(
                                productEntries["image"].toString(),
                                width: 300,
                              ),
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

// class _ProductViewState extends State<ProductView> {
//   RouteArgument routeArgument;

//   _ProductViewState(this.routeArgument);

//   @override

// }
