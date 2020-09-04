import 'dart:collection';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../generated/i18n.dart';

class MapWidget extends StatefulWidget {
  // RouteArgument routeArgument;
  // final GlobalKey<ScaffoldState> parentScaffoldKey;

  // MapWidget({Key key, this.routeArgument, this.parentScaffoldKey})
  //     : super(key: key);

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends StateMVC<MapWidget> {
  GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);
  Set<Marker> _markers = HashSet<Marker>();

  GoogleMapController _mapController;
  BitmapDescriptor _markerIcon;
  // void initState() {
  //   super.initState();
  //   _setMarkerIcon();
  // }

  // void _setMarkerIcon() async {
  //   _markerIcon = await BitmapDescriptor.fromAssetImage(
  //       ImageConfiguration(), 'assets/icons/icon (1).png');
  // }

  void _onMapCreated(GoogleMapController controller) async {
    _mapController = controller;
    var config = createLocalImageConfiguration(context, size: Size(30, 20));
    _markerIcon = await BitmapDescriptor.fromAssetImage(
        config, 'assets/icons/icon(38).png');
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId("0"),
          position: LatLng(10.826666, 78.696265),
          infoWindow: InfoWindow(
            title: "Trichy Sarathas",
            snippet: "Fasion Store",
          ),
          icon: _markerIcon,
        ),
      );
    });
  }

   Future<void> _gotoLocation(double lat,double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lat, long), zoom: 15,tilt: 50.0,
      bearing: 45.0,)));
  }
}

  // @override
  // void initState() {
  //   _con.currentMarket = widget.routeArgument?.param as Market;
  //   if (_con.currentMarket?.latitude != null) {
  //     // user select a market
  //     _con.getMarketLocation();
  //     _con.getDirectionSteps();
  //   } else {
  //     _con.getCurrentLocation();
  //   }
  //   super.initState();
  // }
Widget _gmap() {
  return GoogleMap(
    zoomGesturesEnabled: true,
    mapToolbarEnabled: false,
    mapType: MapType.normal,
    markers: _markers,
    zoomControlsEnabled: true,
    onMapCreated: _onMapCreated,
    initialCameraPosition: CameraPosition(
      target: _center,
    ),
  );
}


  Widget _buildContainer() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 150.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://lh5.googleusercontent.com/p/AF1QipO3VPL9m-b355xWeg4MXmOQTauFAEkavSluTtJU=w225-h160-k-no",
                  40.738380, -73.988426,"Gramercy Tavern"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://lh5.googleusercontent.com/p/AF1QipMKRN-1zTYMUVPrH-CcKzfTo6Nai7wdL7D8PMkt=w340-h160-k-no",
                  40.761421, -73.981667,"Le Bernardin"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://images.unsplash.com/photo-1504940892017-d23b9053d5d4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                  40.732128, -73.999619,"Blue Hill"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _boxes(String _image, double lat,double long,String restaurantName) {
    return  GestureDetector(
        onTap: () {
          _gotoLocation(lat,long);
        },
        child:Container(
              child: new FittedBox(
                child: Material(
                    color: Colors.white,
                    elevation: 14.0,
                    borderRadius: BorderRadius.circular(24.0),
                    shadowColor: Color(0x802196F3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 180,
                          height: 200,
                          child: ClipRRect(
                            borderRadius: new BorderRadius.circular(24.0),
                            child: Image(
                              fit: BoxFit.fill,
                              image: NetworkImage(_image),
                            ),
                          ),),
                          Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: myDetailsContainer1(restaurantName),
                          ),
                        ),

                      ],)
                ),
              ),
            ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      children: [
        _gmap(),

      ],
    ));
  }
}

