import 'dart:async';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trizda_user/helpers/auth.dart';
import 'package:trizda_user/pages/loginpage.dart';
import 'package:trizda_user/pages/shopeview.dart';
import 'dart:convert';
import '../models/route_argument.dart';
import "productview.dart";

final imgList = [
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
var cato = [
  {
    "img":
        "https://rukminim1.flixcart.com/flap/173/163/image/84e0f011761b970e.jpg?q=90",
  },
  {
    "img":
        "https://rukminim1.flixcart.com/flap/173/163/image/54abb23755dc69db.jpg?q=90",
  },
  {
    "img":
        "https://rukminim1.flixcart.com/flap/173/163/image/ff76448c9ce1c07c.jpg?q=90",
  },
  {
    "img": "https://rukminim1.flixcart.com/flap/173/163/image/e651df.jpg?q=90",
  },
  {
    "img": "https://rukminim1.flixcart.com/flap/173/163/image/0574df.jpg?q=90",
  },
  {
    "img":
        "https://rukminim1.flixcart.com/flap/173/163/image/52d4da926dbea236.jpg?q=90",
  },
  {
    "img":
        "https://rukminim1.flixcart.com/flap/173/163/image/a2c6d99c071fa0ae.jpg?q=90",
  },
  {
    "img": "https://rukminim1.flixcart.com/flap/173/163/image/b3af3e.jpg?q=90",
  },
];

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<RemoteConfig>(
      future: setupRemoteConfig(),
      builder: (BuildContext context, AsyncSnapshot<RemoteConfig> snapshot) {
        return snapshot.hasData
            ? RemotTemp(remoteConfig: snapshot.data)
            : Container();
      },
    );
  }
}

class RemotTemp extends AnimatedWidget {
  RemotTemp({this.remoteConfig}) : super(listenable: remoteConfig);

  final RemoteConfig remoteConfig;
  final name = FirebaseAuth.instance
      .currentUser()
      .then((value) => value.phoneNumber)
      .toString();
// var temp=remoteConfig.
  @override
  Widget build(BuildContext context) {
    // print(json.decode(remoteConfig.getString('home_feed')));
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TopBar(),
            // CatoList(cato),
            // SlideShow(imgList),
            if (remoteConfig.getString('welcome') == 'default welcome')
              Text("default man"),
            if (remoteConfig.getString('home_feed') != 'error')
              for (var item in json.decode(remoteConfig.getString('home_feed')))
                Container(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: case2(
                      item["type"],
                      {
                        "cato": CatoList(cato),
                        "pic": SlideShow(item["img"]),
                      },
                      Text("onnum ella")),
                ),
            GestureDetector(
              onTap: () => {
                // Navigator.of(context).pushNamed('/Product',
                //     arguments: new RouteArgument(id: '1'))
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShopFetch(
                        data: Data(text: "qB9qWygitUdH4poLWFkw"),
                      ),
                    ))
              },
              child: Container(
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
              )),
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () async {
                try {
                  await remoteConfig.fetch(
                      expiration: const Duration(seconds: 0));
                  await remoteConfig.activateFetched();
                } on FetchThrottledException catch (exception) {
                  print(exception);
                } catch (exception) {
                  print(
                      'Unable to fetch remote config. Cached or default values will be '
                      'used');
                }
              },
            ),
            FutureBuilder(
                future: FirebaseAuth.instance.currentUser(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {
                    return Text("${snapshot.data.phoneNumber}");
                  } else {
                    return FlatButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          )),
                      child: Text("login"),
                    );
                  }
                }),

            Text("$name"),
            StreamBuilder(
              stream: FirebaseAuth.instance.onAuthStateChanged,
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  return FlatButton(
                    onPressed: () async {
                      await AuthService().signOut();
                    },
                    child: Text("Logout from ${snapshot.data.phoneNumber}"),
                  );
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
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CatoList extends StatelessWidget {
  final imgList;
  CatoList(this.imgList);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (var item in imgList)
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: CachedNetworkImage(
                  imageUrl: item["img"],
                  height: 50,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class SlideShow extends StatelessWidget {
  final imgList;
  SlideShow(this.imgList);
  // final data = Data(text: "njr");
  @override
  Widget build(BuildContext context) {
    return Container(
        child: CarouselSlider(
      options: CarouselOptions(
        height: 130,
        autoPlay: true,
        viewportFraction: 1.0,
        enlargeCenterPage: false,

        // autoPlay: false,
      ),
      items: imgList
          .map<Widget>((item) => Container(
                child: GestureDetector(
                  onTap: () => {
                    // Navigator.of(context).pushNamed('/Product',
                    //     arguments: new RouteArgument(id: '1'))
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductFetch(
                            data: Data(text: "3h3N5JprkMNv0W2MTK4t"),
                          ),
                        ))
                  },
                  child: Center(
                    child: CachedNetworkImage(
                      imageUrl: item["img"],
                      height: 130,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ))
          .toList(),
    ));
  }
}

Future<RemoteConfig> setupRemoteConfig() async {
  final RemoteConfig remoteConfig = await RemoteConfig.instance;
  // Enable developer mode to relax fetch throttling
  remoteConfig.setConfigSettings(RemoteConfigSettings(debugMode: true));
  remoteConfig.setDefaults(<String, dynamic>{
    'welcome': 'default welcome',
    'home_feed': "error",
  });
  return remoteConfig;
}

// class PreviewPage extends StatelessWidget {
//   final String jsonString;

//   PreviewPage(this.jsonString);

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<Widget>(
//       future: _buildWidget(context),
//       builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
//         if (snapshot.hasError) {
//           print(snapshot.error);
//         }
//         return snapshot.hasData
//             ? SizedBox.expand(
//                 child: snapshot.data,
//               )
//             : Text("Loading...");
//       },
//     );
//   }

//   Future<Widget> _buildWidget(BuildContext context) async {
//     return DynamicWidgetBuilder.build(
//         jsonString, context, new DefaultClickListener());
//   }
// }

// class DefaultClickListener implements ClickListener {
//   @override
//   void onClicked(String event) {
//     print("Receive click event: " + event);
//   }
// }

class TopBar extends StatefulWidget {
  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Image.asset("./assets/img/logo.png", height: 45),
          Spacer(),
          Text("I")
        ],
      ),
    );
  }
}

TValue case2<TOptionType, TValue>(
  TOptionType selectedOption,
  Map<TOptionType, TValue> branches, [
  TValue defaultValue = null,
]) {
  if (!branches.containsKey(selectedOption)) {
    return defaultValue;
  }

  return branches[selectedOption];
}

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          width: 300,
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: CachedNetworkImage(
                  imageUrl: item["img"],
                  fit: BoxFit.fitHeight,
                )),
          ),
        ))
    .toList();
