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
        config, 'assets/icons/icon(1).png');

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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GoogleMap(
        zoomGesturesEnabled: true,
        mapToolbarEnabled: false,
        mapType: MapType.normal,
        markers: _markers,
        zoomControlsEnabled: true,
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
        ),
      ),
    );
  }
}
