import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:global_configuration/global_configuration.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
// import 'package:location/location.dart';
import '../generated/i18n.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import '../helpers/maps_util.dart';
// import '../models/address.dart';
import '../models/setting.dart';

ValueNotifier<Setting> setting = new ValueNotifier(new Setting());
// ValueNotifier<Address> deliveryAddress = new ValueNotifier(new Address());
//LocationData locationData;

Future<Setting> initSettings() async {
  Setting _setting;
  var data = '''{"success":true,
      "data":{
        "app_name":"Smart Delivery",
        "enable_stripe":"1",
        "default_tax":"10",
        "default_currency":"i",
        "enable_paypal":"1",
        "main_color":"#ed9e02",
        "main_dark_color":"#ed9e02",
        "second_color":"#3b1a04",
        "second_dark_color":"#ddd3cc",
        "accent_color":"#a8998c",
        "accent_dark_color":"#9999aa",
        "scaffold_dark_color":"#2c2c2c",
        "scaffold_color":"#fafafa",
        "google_maps_key":"AIzaSyC3YYz8jqvHY3Yup1lzIdlU51FsjHKH5yE",
        "mobile_language":"en",
        "app_version":"1.5.0",
        "enable_version":"1",
        "currency_right":"0",
        "default_currency_decimal_digits":"2",
        "enable_razorpay":"1"
        },
        "message":"Settings retrieved successfully"
        }''';
  if (json.decode(data)['data'] != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('settings', json.encode(json.decode(data)['data']));
    _setting = Setting.fromJSON(json.decode(data)['data']);
    if (prefs.containsKey('language')) {
      _setting.mobileLanguage =
          new ValueNotifier(Locale(prefs.get('language'), ''));
    }
    setting.value = _setting;
    setting.notifyListeners();
  }

  return setting.value;
}

// Future<dynamic> setCurrentLocation() async {
//   var location = new Location();
//   MapsUtil mapsUtil = new MapsUtil();
//   final whenDone = new Completer();
//   Address _address = Address.fromJSON({'address': S.current.unknown});
//   location.requestService().then((value) async {
//     try {
//       location.getLocation().then((_locationData) async {
//         String _addressName = await mapsUtil.getAddressName(new LatLng(_locationData?.latitude, _locationData?.longitude), setting.value.googleMapsKey);
//         _address = Address.fromJSON({'address': _addressName, 'latitude': _locationData?.latitude, 'longitude': _locationData?.longitude});
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         await prefs.setString('delivery_address', json.encode(_address.toMap()));
//         whenDone.complete(_address);
//       }).timeout(Duration(seconds: 10), onTimeout: () async {
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         await prefs.setString('delivery_address', json.encode(_address.toMap()));
//         whenDone.complete(_address);
//         return null;
//       });
//     } on PlatformException catch (e) {
//       if (e.code == 'PERMISSION_DENIED') {
//         whenDone.complete(_address);
//         print('Permission denied');
//       }
//     }
//   });
//   return whenDone.future;
// }

// Future<Address> changeCurrentLocation(Address _address) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   await prefs.setString('delivery_address', json.encode(_address.toMap()));
//   return _address;
// }

// Future<Address> getCurrentLocation() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
// //  await prefs.clear();
//   if (prefs.containsKey('delivery_address')) {
//     deliveryAddress.value = Address.fromJSON(json.decode(prefs.getString('delivery_address')));
//     return deliveryAddress.value;
//   } else {
//     deliveryAddress.value = Address.fromJSON({});
//     return Address.fromJSON({});
//   }
// }

void setBrightness(Brightness brightness) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  brightness == Brightness.dark
      ? prefs.setBool("isDark", true)
      : prefs.setBool("isDark", false);
}

// Future<void> setDefaultLanguage(String language) async {
//   if (language != null) {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('language', language);
//   }
// }

// Future<String> getDefaultLanguage(String defaultLanguage) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   if (prefs.containsKey('language')) {
//     defaultLanguage = await prefs.get('language');
//   }
//   return defaultLanguage;
// }
