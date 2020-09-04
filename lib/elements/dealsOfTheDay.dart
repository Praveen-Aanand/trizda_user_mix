import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Dodlist extends StatefulWidget {
  @override
  _DodlistState createState() => _DodlistState();
}

class _DodlistState extends State<Dodlist> {
  List<deals> deal;

  @override
  void initState() {
    super.initState();
    addDealItem();
  }

  addDealItem() {
    deal = List<deals>();
    deal.add(deals(
        "https://rukminim1.flixcart.com/image/150/150/jm573ww0/top/2/3/s/s-tttp002504-tokyo-talkies-original-imaf94k89eddvfha.jpeg?q=70",
        'Dresses & Tops',
        'From 99'));
    deal.add(deals(
        "https://rukminim1.flixcart.com/flap/150/150/image/6d2ed619459ca8c9.jpg?q=70",
        'Watches',
        'Upto 70% Off'));
    deal.add(deals(
        "https://rukminim1.flixcart.com/image/150/150/jcdoscw0/blazer/p/w/e/42-rlblu01-one-click-original-imaffg49ehyycgch.jpeg?q=70",
        'T Shirts',
        'Starting @99'));
    deal.add(deals(
        "https://rukminim1.flixcart.com/image/150/150/k44hksw0/t-shirt/m/t/r/m-dv24solidmustard-diversify-original-imafkbzvhcn3vgs7.jpeg?q=70",
        'Casual Shirts',
        'Extra 100 Off'));
  }

  buildItem(BuildContext context, int index) {
    return Container(
      height: MediaQuery.of(context).size.height / 3.5,
      child: Column(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height / 6.5,
              width: MediaQuery.of(context).size.width / 4,
              child: CachedNetworkImage(
                imageUrl: deal[index].imageUrl,
                fit: BoxFit.fitHeight,
              )),
          Text(
            '${deal[index].name}',
            style: TextStyle(fontSize: 15),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              '${deal[index].discount}',
              style: TextStyle(color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height / 1.6,
      child: Stack(
        children: <Widget>[
          Container(
            height: size.height / 1.7,
            color: Color(0xffFFBAF0),
          ),
          // Container(
          //   height: size.height / 7,
          //   width: size.width,
          //   alignment: Alignment.topCenter,
          //   child: Image.asset(
          //     "assets/banner_three.png",
          //   ),
          // ),
          Positioned(
            top: MediaQuery.of(context).size.height / 65,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Deals of the Day',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.access_time,
                                color: Colors.white,
                              ),
                              Text(
                                '19h 18m Remaining',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              )
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('View All'),
                          ),
                        ),
                      )
                    ],
                  ),
                  width: size.width,
                ),
                Container(
                  height: size.height / 1.75,
                  padding: EdgeInsets.only(left: 8, right: 8),
                  width: size.width,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.white,
                    child: GridView.builder(
                      padding: EdgeInsets.all(10),
                      itemCount: 4,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return buildItem(context, index);
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class deals {
  String _imageUrl;
  String _name;
  String _discount;

  deals(this._imageUrl, this._name, this._discount);

  String get discount => _discount;

  String get name => _name;

  String get imageUrl => _imageUrl;
}
