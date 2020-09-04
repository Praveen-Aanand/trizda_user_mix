import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Secondlist extends StatefulWidget {
  @override
  _SecondlistState createState() => _SecondlistState();
}

class _SecondlistState extends State<Secondlist> {
  buildItem(BuildContext context, int index) {
    return Container(
      height: MediaQuery.of(context).size.height / 4,
      child: Padding(
        padding: const EdgeInsets.only(left: 2, right: 2),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: CachedNetworkImage(
              imageUrl:
                  "https://rukminim1.flixcart.com/flap/173/163/image/54abb23755dc69db.jpg?q=90",
              fit: BoxFit.fitHeight,
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Container(
        height: MediaQuery.of(context).size.height / 4,
        child: ListView.builder(
          itemCount: 10,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return buildItem(context, index);
          },
        ),
      ),
    );
  }
}
