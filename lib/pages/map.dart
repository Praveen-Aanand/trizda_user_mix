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

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
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
        zoomControlsEnabled: true,
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
        ),
      ),
    );
  }
}
